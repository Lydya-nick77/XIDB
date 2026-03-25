addon.name      = 'XIDB';
addon.author    = 'Lydya';
addon.version   = '0.2.0';
addon.desc      = 'Browsable item database backed by Ashita v4 item resources.';
addon.link      = 'https://github.com/Lydya-Nick77/XIDB';

require('common');
local chat = require('chat');
local settings = require('settings');
imgui = require('imgui');
local ffi = require('ffi')
local itemicon = require('itemicon')
local encoding = require('encoding')

local default_settings = T{
    auto_scan = T{ true, },
    max_results = 250,
    max_scan_id = 65535,
    window = T{
        x = 100,
        y = 100,
        width = 980,
        height = 620,
    },
    show_icons = T{ false, },
};

local xidb = T{
    settings = nil,
    ui = T{
        is_open = T{ false, },
        filter = { '', },
    },
    db = T{
        items = { },
        items_by_id = { },
        results = { },
        indexed = false,
        indexing = false,
        total_matches = 0,
        scanned_count = 0,
        last_scan_seconds = 0,
        selected_id = nil,
        status = 'Index not built yet.',
        cache_query = nil,
        cache_limit = nil,
    },
};

local function print_message(message)
    print(chat.header(addon.name):append(chat.message(message)));
end

local function print_error(message)
    print(chat.header(addon.name):append(chat.error(message)));
end

local function trim(value)
    if (type(value) ~= 'string') then
        return '';
    end

    return value:match('^%s*(.-)%s*$') or '';
end

local function lower(value)
    return string.lower(trim(value));
end

local function table_text(value)
    if (type(value) == 'table') then
        return trim(value[1] or value[2] or value[3] or '');
    end

    if (value == nil) then
        return '';
    end

    return trim(tostring(value));
end

local function to_number(value, fallback)
    if (type(value) == 'number') then
        return value;
    end

    local num = tonumber(value);
    if (num == nil) then
        return fallback or 0;
    end

    return num;
end

local function format_hex(value)
    return ('0x%08X'):fmt(to_number(value, 0));
end

local EQUIP_SLOT_MASKS = {
    [0x0001] = 'Main',
    [0x0002] = 'Sub',
    [0x0004] = 'Range',
    [0x0008] = 'Ammo',
    [0x0010] = 'Head',
    [0x0020] = 'Body',
    [0x0040] = 'Hands',
    [0x0080] = 'Legs',
    [0x0100] = 'Feet',
    [0x0200] = 'Neck',
    [0x0400] = 'Waist',
    [0x0800] = 'Ear1',
    [0x1000] = 'Ear2',
    [0x2000] = 'Ring1',
    [0x4000] = 'Ring2',
    [0x8000] = 'Back',
}

local function format_slots_mask(mask)
    mask = to_number(mask, 0)
    if mask == 0 then
        return 'None'
    end

    local function has_bit(m, b)
        if bit and bit.band then
            return bit.band(m, b) ~= 0
        else
            return (m % (b * 2)) >= b
        end
    end

    local ordered_bits = {0x0001,0x0002,0x0004,0x0008,0x0010,0x0020,0x0040,0x0080,0x0100,0x0200,0x0400,0x0800,0x1000,0x2000,0x4000,0x8000}
    local parts = { }
    for _, b in ipairs(ordered_bits) do
        local n = EQUIP_SLOT_MASKS[b]
        if n and has_bit(mask, b) then
            parts[#parts + 1] = n
        end
    end

    if #parts == 0 then
        return 'None'
    end

    return table.concat(parts, ', ')
end

local JOB_NAMES = {
    ' ','WAR','MNK','WHM','BLM','RDM','THF','PLD','DRK',
    'BST','BRD','RNG','SAM','NIN','DRG','SMN','BLU',
    'COR','PUP','DNC','SCH','GEO','RUN'
}

local function format_jobs_mask(mask)
    mask = to_number(mask, 0)
    if mask == 0 then
        return 'None'
    end

    local function has_bit(m, b)
        if bit and bit.band then
            return bit.band(m, b) ~= 0
        else
            return (m % (b * 2)) >= b
        end
    end

    local parts = { }
    for i = 1, #JOB_NAMES do
        local bitval = 2 ^ (i - 1)
        if has_bit(mask, bitval) then
            parts[#parts + 1] = JOB_NAMES[i]
        end
    end

    if #parts == 0 then
        return 'None'
    end

    return table.concat(parts, ', ')
end

-- Item flags mapping (bitmask -> name). Fill or adjust names as desired.
local ITEM_FLAG_NAMES = {
    [0x00000001] = 'Flag00',
    [0x00000002] = 'Flag01',
    [0x00000004] = 'Flag02',
    [0x00000008] = 'Flag03',
    [0x00000010] = 'Flag04',
    [0x00000020] = 'Inscribable',
    [0x00000040] = 'No Auction',
    [0x00000080] = 'Scroll',
    [0x00000100] = 'Linkshell',
    [0x00000200] = 'Can Use',
    [0x00000400] = 'Can trade NPC',
    [0x00000800] = 'Can Equip',
    [0x00001000] = 'No Sale',
    [0x00002000] = 'No Delivery',
    [0x00004000] = 'No Trade Player',
    [0x00008000] = 'Rare',
    [0x00010000] = 'Can Mog Garden',
    [0x00020000] = 'Is Furniture',
    [0x00040000] = 'Is Key Item',
    [0x00080000] = 'Is Currencies',
    [0x00100000] = 'Is Mount',
    [0x00200000] = 'Is Trust',
    [0x00400000] = 'Is Costume',
    [0x00800000] = 'Is Special',
    [0x01000000] = 'Is Mog Pell',
    [0x02000000] = 'Is Scripted',
    [0x04000000] = 'Is Technical',
    [0x08000000] = 'Reserved/Internal',
    [0x10000000] = 'RUN',
    [0x20000000] = 'GEO',
    [0x40000000] = 'Reserved/Expansion',
    [0x80000000] = 'Reserved/Expansion',
}

local function format_flags_mask(mask)
    mask = to_number(mask, 0)
    if mask == 0 then
        return 'None'
    end

    local function has_bit(m, b)
        if bit and bit.band then
            return bit.band(m, b) ~= 0
        else
            return (m % (b * 2)) >= b
        end
    end

    local parts = { }
    local bitval = 1
    for i = 0, 31 do
        if has_bit(mask, bitval) then
            local name = ITEM_FLAG_NAMES[bitval] or ('Bit' .. tostring(i))
            parts[#parts + 1] = name
        end
        bitval = bitval * 2
    end

    if #parts == 0 then
        return 'None'
    end

    return table.concat(parts, ', ')
end

-- Human-readable item type names. Edit as needed to match your resource set.
local ITEM_TYPE_NAMES = {
    [0] = 'None',
    [1] = 'Item',
    [2] = '2 ??',
    [3] = '3 ??',
    [4] = 'Weapon',
    [5] = 'Armor',
    [6] = '6 ??',
    [7] = 'Item / Consummable',
    [8] = '8 ??',
    [9] = '9 ??',
    [10] = 'Furniture',
    [11] = '11 ??',
    [12] = '12 ??',
    [13] = '13 ??',
    [14] = '14 ??',
    [15] = '15 ??',
    [16] = '16 ??',
    [17] = '17 ??',
    [18] = '18 ??',
    [19] = '19 ??',
    [20] = '20 ??',
}

local function format_item_type(t)
    t = to_number(t, -1)
    if ITEM_TYPE_NAMES[t] then
        return ITEM_TYPE_NAMES[t]
    end
    return ('Type_%d'):fmt(t)
end

local function get_item_name_by_id(id)
    if (id == nil) then
        return nil
    end

    local resources = AshitaCore:GetResourceManager()
    if (resources == nil) then
        return nil
    end

    local ok, s = pcall(function()
        return resources:GetString('items.names', id)
    end)
    if ok and type(s) == 'string' and s ~= '' then
        return s
    end

    local ok2, item = pcall(function()
        if type(resources.GetItemById) == 'function' then
            return resources:GetItemById(id)
        elseif type(resources.GetItemByID) == 'function' then
            return resources:GetItemByID(id)
        end
        return nil
    end)

    if not ok2 then
        return nil
    end
    if item == nil then
        return nil
    end

    if type(item) == 'table' and type(item.Name) == 'table' then
        local candidate = item.Name[1] or item.Name[0] or item.Name[2]
        if type(candidate) == 'string' and candidate ~= '' then
            return candidate
        end
    end

    local probes = {
        function() return item.Name and item.Name[1] end,
        function() return item.Name and item.Name:get() end,
        function() return tostring(item.Name) end,
        function() return tostring(item) end,
    }

    for i, probe in ipairs(probes) do
        local okp, val = pcall(probe)
        if okp and type(val) == 'string' and val ~= '' then
            return val
        end
    end

    return nil
end

local function get_item_description_by_id(id)
    if (id == nil) then
        return nil
    end

    local resources = AshitaCore:GetResourceManager()
    if (resources == nil) then
        return nil
    end

    local ok, s = pcall(function()
        return resources:GetString('items.descriptions', id)
    end)
    if ok and type(s) == 'string' and s ~= '' then
        return s
    end

    local ok2, item = pcall(function()
        if type(resources.GetItemById) == 'function' then
            return resources:GetItemById(id)
        elseif type(resources.GetItemByID) == 'function' then
            return resources:GetItemByID(id)
        end
        return nil
    end)

    if not ok2 or item == nil then
        return nil
    end

    if type(item) == 'table' and type(item.Description) == 'table' then
        return item.Description[1] or item.Description[0] or item.Description[2]
    end

    local probes = {
        function() return item.Description and item.Description[1] end,
        function() return item.Description and item.Description:get() end,
        function() return tostring(item.Description) end,
        function() return tostring(item) end,
    }

    for _, probe in ipairs(probes) do
        local okp, val = pcall(probe)
        if okp and type(val) == 'string' and val ~= '' then
            return val
        end
    end

    return nil
end

-- Try multiple ways to obtain a UTF-8 log name (singular/plural) for a given item id.
local function get_item_logname_by_id(id, field)
    if (id == nil or field == nil) then
        return nil
    end

    local resources = AshitaCore:GetResourceManager()
    if (resources == nil) then
        return nil
    end

    -- Try resource entry
    local ok2, item = pcall(function()
        if type(resources.GetItemById) == 'function' then
            return resources:GetItemById(id)
        elseif type(resources.GetItemByID) == 'function' then
            return resources:GetItemByID(id)
        end
        return nil
    end)

    if not ok2 or item == nil then
        return nil
    end

    if type(item) == 'table' and type(item[field]) == 'table' then
        return item[field][1] or item[field][0] or item[field][2]
    end

    local probes = {
        function() return item[field] and item[field][1] end,
        function() return item[field] and item[field]:get() end,
        function() return tostring(item[field]) end,
    }

    for _, probe in ipairs(probes) do
        local okp, val = pcall(probe)
        if okp and type(val) == 'string' and val ~= '' then
            return val
        end
    end

    return nil
end

local function join_args(args, start_index)
    local parts = { };

    for i = start_index, #args do
        parts[#parts + 1] = tostring(args[i]);
    end

    return trim(table.concat(parts, ' '));
end

local function build_entry(id, item)
    local name = table_text(item.Name);

    if (name == nil or name == '' or tostring(name):match('userdata')) then
        local alt = get_item_name_by_id(id)
        if (type(alt) == 'string' and alt ~= '') then
            name = alt
        end
    end
    local log_singular = table_text(item.LogNameSingular);
    local log_plural = table_text(item.LogNamePlural);

    -- If log names are empty or userdata, try resource-backed lookup
    if (log_singular == nil or log_singular == '' or tostring(log_singular):match('userdata')) then
        local alt = get_item_logname_by_id(id, 'LogNameSingular')
        if (type(alt) == 'string' and alt ~= '') then
            log_singular = alt
        end
    end
    if (log_plural == nil or log_plural == '' or tostring(log_plural):match('userdata')) then
        local alt2 = get_item_logname_by_id(id, 'LogNamePlural')
        if (type(alt2) == 'string' and alt2 ~= '') then
            log_plural = alt2
        end
    end
    local description = table_text(item.Description);

    if (description == nil or description == '' or tostring(description):match('userdata')) then
        local alt_desc = get_item_description_by_id(id)
        if (type(alt_desc) == 'string' and alt_desc ~= '') then
            description = alt_desc
        end
    end

    if (name == '') then
        name = ('Item #%d'):fmt(id);
    end

    return {
        id = id,
        name = name,
        name_lc = string.lower(name),
        log_singular = log_singular,
        log_singular_lc = string.lower(log_singular),
        log_plural = log_plural,
        log_plural_lc = string.lower(log_plural),
        description = description,
        description_lc = string.lower(description),
        resource = item,
        type = to_number(item.Type, 0),
        flags = to_number(item.Flags, 0),
        stack_size = to_number(item.StackSize, 0),
        level = to_number(item.Level, 0),
        jobs = to_number(item.Jobs, 0),
        slots = to_number(item.Slots, 0),
    };
end

local function select_item(item_id)
    local id = to_number(item_id, 0);
    if (id <= 0) then
        xidb.db.selected_id = nil;
        return;
    end

    if (xidb.db.items_by_id[id] ~= nil) then
        xidb.db.selected_id = id;
        return;
    end

    xidb.db.selected_id = nil;
end

local function score_entry(query, entry)
    if (query == '') then
        return 1000;
    end

    local id_text = tostring(entry.id);
    if (id_text == query) then
        return 0;
    end
    if (entry.name_lc == query or entry.log_singular_lc == query or entry.log_plural_lc == query) then
        return 1;
    end
    if (string.sub(entry.name_lc, 1, #query) == query) then
        return 2;
    end
    if (entry.log_singular_lc ~= '' and string.sub(entry.log_singular_lc, 1, #query) == query) then
        return 3;
    end
    if (entry.log_plural_lc ~= '' and string.sub(entry.log_plural_lc, 1, #query) == query) then
        return 4;
    end
    if (string.find(entry.name_lc, query, 1, true) ~= nil) then
        return 5;
    end
    if (entry.log_singular_lc ~= '' and string.find(entry.log_singular_lc, query, 1, true) ~= nil) then
        return 6;
    end
    if (entry.log_plural_lc ~= '' and string.find(entry.log_plural_lc, query, 1, true) ~= nil) then
        return 7;
    end
    if (entry.description_lc ~= '' and string.find(entry.description_lc, query, 1, true) ~= nil) then
        return 8;
    end
    if (string.find(id_text, query, 1, true) ~= nil) then
        return 9;
    end

    return nil;
end

local function refresh_results(force)
    local query = lower(xidb.ui.filter[1]);
    local limit = math.max(25, to_number(xidb.settings.max_results, 250));

    if (not force and xidb.db.cache_query == query and xidb.db.cache_limit == limit) then
        return;
    end

    xidb.db.cache_query = query;
    xidb.db.cache_limit = limit;
    xidb.db.results = { };
    xidb.db.total_matches = 0;

    if (not xidb.db.indexed) then
        return;
    end

    if (query == '') then
        xidb.db.total_matches = #xidb.db.items;

        local max_count = math.min(limit, #xidb.db.items);
        for i = 1, max_count do
            xidb.db.results[#xidb.db.results + 1] = xidb.db.items[i];
        end

    else
        local matches = { };
        for _, entry in ipairs(xidb.db.items) do
            local score = score_entry(query, entry);
            if (score ~= nil) then
                xidb.db.total_matches = xidb.db.total_matches + 1;
                matches[#matches + 1] = {
                    score = score,
                    entry = entry,
                };
            end
        end

        table.sort(matches, function (a, b)
            if (a.score == b.score) then
                if (a.entry.name_lc == b.entry.name_lc) then
                    return a.entry.id < b.entry.id;
                end

                return a.entry.name_lc < b.entry.name_lc;
            end

            return a.score < b.score;
        end);

        local max_count = math.min(limit, #matches);
        for i = 1, max_count do
            xidb.db.results[#xidb.db.results + 1] = matches[i].entry;
        end
    end

    local selected_visible = false;
    if (xidb.db.selected_id ~= nil) then
        for _, entry in ipairs(xidb.db.results) do
            if (entry.id == xidb.db.selected_id) then
                selected_visible = true;
                break;
            end
        end
    end

    if (#xidb.db.results == 0) then
        xidb.db.selected_id = nil;
    elseif (xidb.db.selected_id == nil or not selected_visible) then
        xidb.db.selected_id = xidb.db.results[1].id;
    end
end

local function rebuild_index(silent)
    if (xidb.db.indexing) then
        if (not silent) then
            print_message('A scan is already running.');
        end
        return;
    end

    local resources = AshitaCore:GetResourceManager();
    if (resources == nil) then
        print_error('Unable to access the Ashita resource manager.');
        return;
    end

    xidb.db.indexing = true;
    xidb.db.status = 'Scanning item resources..';
    -- Clear any previously cached textures to avoid holding stale/native resources
    pcall(function() itemicon.clear() end)
    xidb.db.items = { };
    xidb.db.items_by_id = { };
    xidb.db.indexed = false;
    xidb.db.selected_id = nil;

    local started_at = os.clock();
    local miss_streak = 0;
    local max_scan_id = math.max(4096, to_number(xidb.settings.max_scan_id, 65535));

    for id = 1, max_scan_id do
        local ok, item = pcall(function() return resources:GetItemById(id) end)
        if not ok then item = nil end

        if item ~= nil then
            local entry = build_entry(id, item);
            local name = tostring(entry.name or '');
            local is_autogen = name:match('^Item #%d+$') ~= nil;
            local is_empty_or_punct = trim(name) == '' or name:match('^%p+$') ~= nil;

                if (not is_autogen and not is_empty_or_punct) then
                    -- Do not keep the full resource (which may contain large Bitmap data)
                    entry.resource = nil
                    xidb.db.items[#xidb.db.items + 1] = entry;
                    xidb.db.items_by_id[id] = entry;
                miss_streak = 0;
            else
                miss_streak = miss_streak + 1;
                if (#xidb.db.items > 0 and miss_streak >= 2048) then
                    break;
                end
            end
        else
            miss_streak = miss_streak + 1;
            if (#xidb.db.items > 0 and miss_streak >= 2048) then
                break;
            end
        end
    end

    xidb.db.indexing = false;
    xidb.db.indexed = true;
    xidb.db.scanned_count = #xidb.db.items;
    xidb.db.last_scan_seconds = os.clock() - started_at;
    xidb.db.status = ('Indexed %d items in %.2f seconds.'):fmt(xidb.db.scanned_count, xidb.db.last_scan_seconds);
    xidb.db.cache_query = nil;
    xidb.db.cache_limit = nil;

    refresh_results(true);

    if (#xidb.db.results > 0) then
        select_item(xidb.db.results[1].id);
    end

    if (not silent) then
        print_message(xidb.db.status);
    end
end

local function ensure_index()
    if (not xidb.db.indexed and not xidb.db.indexing) then
        rebuild_index(false);
    end
end

local function set_filter(value)
    xidb.ui.filter[1] = value or '';
    refresh_results(true);
end

local function print_help(is_error)
    if (is_error) then
        print_error('Invalid command syntax.');
    end

    print_message('Available commands:');
    print_message('/xidb - Open or close the item database window.');
    print_message('/xidb help - Show this help text.');
    print_message('/xidb scan - Rebuild the item index from Ashita resources.');
    print_message('/xidb clear - Clear the current search filter.');
    print_message('/xidb find <text> - Search by name, log name, description, or id.');
    print_message('/xidb id <itemid> - Jump directly to a specific item id.');
end

settings.register('settings', 'settings_update', function (s)
    if (s ~= nil) then
        xidb.settings = s;
    end

    refresh_results(true);
end);

ashita.events.register('load', 'xidb_load_cb', function ()
    xidb.settings = settings.load(default_settings);

    if (xidb.settings.auto_scan[1]) then
        rebuild_index(true);
    end
end);

ashita.events.register('unload', 'xidb_unload_cb', function ()
    settings.save();
end);

ashita.events.register('command', 'xidb_command_cb', function (e)
    local args = e.command:args();
    if (#args == 0 or not args[1]:any('/xidb')) then
        return;
    end

    e.blocked = true;

    if (#args == 1) then
        xidb.ui.is_open[1] = not xidb.ui.is_open[1];
        if (xidb.ui.is_open[1]) then
            ensure_index();
        end
        return;
    end

    if (args[2]:any('help')) then
        print_help(false);
        return;
    end

    if (args[2]:any('scan')) then
        rebuild_index(false);
        xidb.ui.is_open[1] = true;
        return;
    end

    -- debug command removed

    if (args[2]:any('clear')) then
        set_filter('');
        xidb.ui.is_open[1] = true;
        return;
    end

    if (args[2]:any('find')) then
        ensure_index();
        set_filter(join_args(args, 3));
        xidb.ui.is_open[1] = true;
        if (#xidb.db.results > 0) then
            select_item(xidb.db.results[1].id);
        end
        return;
    end

    if (args[2]:any('id')) then
        ensure_index();

        local item_id = to_number(args[3], 0);
        if (item_id <= 0) then
            print_help(true);
            return;
        end

        local entry = xidb.db.items_by_id[item_id];
        if (entry == nil) then
            print_error(('No item found for id %d.'):fmt(item_id));
            return;
        end

        xidb.ui.is_open[1] = true;
        set_filter(tostring(item_id));
        select_item(item_id);
        return;
    end

    print_help(true);
end);


-- Caching for details pane: only update when selection changes or index is rebuilt
local details_cache = {
    selected_id = nil,
    entry = nil,
    item_name = '',
    tex_id = nil,
}

local function update_details_cache()
    local sel_id = xidb.db.selected_id or -1
    local entry = xidb.db.items_by_id[sel_id]
    if entry == nil then
        details_cache.selected_id = sel_id
        details_cache.entry = nil
        details_cache.item_name = ''
        details_cache.tex_id = nil
        return
    end
    details_cache.selected_id = sel_id
    details_cache.entry = entry
    local item_name = entry.name or ''
    local name_lookup = get_item_name_by_id(entry.id)
    if name_lookup and name_lookup ~= '' then
        item_name = name_lookup
    end
    details_cache.item_name = item_name
    -- Only reload texture if id or resource changed
    -- xidb_load_item_texture now returns a numeric texture id (or nil)
    local tex_id = nil
    if xidb.settings.show_icons[1] then
        local ok, tid = pcall(function() return itemicon.load(entry.id) end)
        if ok and tid and type(tid) == 'number' then
            tex_id = tid
        else
            if not ok then
                print_error(('Failed to load texture for item %d'):fmt(entry.id))
            end
        end
    end
    details_cache.tex_id = tex_id
end

ashita.events.register('d3d_present', 'xidb_present_cb', function ()
    if (not xidb.ui.is_open[1]) then
        return;
    end

    ensure_index();

    -- Update details cache if selection changed or index rebuilt
    if details_cache.selected_id ~= xidb.db.selected_id or (details_cache.entry == nil and xidb.db.selected_id ~= nil) then
        update_details_cache()
    end

    imgui.SetNextWindowPos({ xidb.settings.window.x, xidb.settings.window.y }, ImGuiCond_FirstUseEver);
    imgui.SetNextWindowSize({ xidb.settings.window.width, xidb.settings.window.height }, ImGuiCond_FirstUseEver);
    imgui.SetNextWindowSizeConstraints({ 820, 500, }, { FLT_MAX, FLT_MAX, });

    if (imgui.Begin('XIDB', xidb.ui.is_open)) then
        local pos_x, pos_y = imgui.GetWindowPos();
        local size_x, size_y = imgui.GetWindowSize();
        xidb.settings.window.x = math.floor(pos_x);
        xidb.settings.window.y = math.floor(pos_y);
        xidb.settings.window.width = math.floor(size_x);
        xidb.settings.window.height = math.floor(size_y);

        imgui.TextColored({ 1.0, 0.82, 0.32, 1.0 }, 'Ashita v4 Item Database');
        imgui.SameLine();
        imgui.Text(('Indexed: %d'):fmt(xidb.db.scanned_count));
        imgui.SameLine();
        imgui.Text(('Matches: %d'):fmt(xidb.db.total_matches));

        if (imgui.Button('Rescan')) then
            rebuild_index(false);
            settings.save();
            update_details_cache()
        end
        imgui.SameLine();
        if (imgui.Button('Clear Filter')) then
            set_filter('');
        end
        imgui.SameLine();
        local auto_scan = { xidb.settings.auto_scan[1], };
        if (imgui.Checkbox('Auto Scan On Load', auto_scan)) then
            xidb.settings.auto_scan[1] = auto_scan[1];
            settings.save();
        end

        imgui.SameLine();
        local show_icons = { xidb.settings.show_icons[1], };
        if (imgui.Checkbox('Show Item Icons', show_icons)) then
            xidb.settings.show_icons[1] = show_icons[1];
            settings.save();
            if not xidb.settings.show_icons[1] then
                -- clearing cache when user disables icons
                pcall(function() itemicon.clear() end)
            end
        end

        local max_results = { to_number(xidb.settings.max_results, 250), };
        imgui.SameLine();
        imgui.SetNextItemWidth(110);
        if (imgui.InputInt('Max Results', max_results)) then
            xidb.settings.max_results = math.max(25, math.min(max_results[1], 1000));
            refresh_results(true);
            settings.save();
        end

        imgui.SetNextItemWidth(-1);
        if (imgui.InputText('Search', xidb.ui.filter, 256)) then
            refresh_results(true);
        end

        imgui.TextWrapped('Search by item name, description text, or a numeric id. It reads directly from Ashita item resources');
        imgui.TextColored({ 0.75, 0.75, 0.75, 1.0 }, xidb.db.status);
        imgui.Separator();

        imgui.BeginChild('xidb_results', { 430, -1, }, true);
            if (xidb.db.indexing) then
                imgui.Text('Scanning resources..');
            elseif (#xidb.db.results == 0) then
                imgui.Text('No matching items.');
            else
                for _, entry in ipairs(xidb.db.results) do
                    local label = ('[%05d] %s'):fmt(entry.id, entry.log_singular);
                    if (imgui.Selectable(label, xidb.db.selected_id == entry.id)) then
                        select_item(entry.id);
                        update_details_cache()
                    end
                end
            end
        imgui.EndChild();

        imgui.SameLine();

        imgui.BeginChild('xidb_details', { 0, -1, }, true);
            local entry = details_cache.entry
            if (entry == nil) then
                imgui.Text('Select an item to inspect its details.');
            else
                local item_name = details_cache.item_name or ''
                local tex_id = details_cache.tex_id
                if tex_id then
                    local ok_img = pcall(function()
                        imgui.Image(tex_id, {36, 36}, {0, 0}, {1, 1}, {1, 1, 1, 1}, {0, 0, 0, 0})
                    end)
                    if ok_img then
                        imgui.SameLine()
                    else
                        -- ignore image failures to avoid crashing the addon
                    end
                end
                imgui.TextColored({ 1.0, 0.85, 0.35, 1.0 }, item_name);
                imgui.Separator();

                imgui.Text(('ID: %d'):fmt(entry.id));
                imgui.Text(('Level: %d'):fmt(entry.level));
                imgui.Text(('Stack Size: %d'):fmt(entry.stack_size));
                imgui.Text(('Type: %s  *verification needed*'):fmt(format_item_type(entry.type)));
                imgui.Text(('Flags: %s  *verification needed*'):fmt(format_flags_mask(entry.flags)));
                imgui.Text(('Jobs: %s'):fmt(format_jobs_mask(entry.jobs)));
                imgui.Text(('Slots: %s'):fmt(format_slots_mask(entry.slots)));

                if (entry.log_singular ~= '') then
                    imgui.Separator();
                    imgui.Text('Short Name');
                    imgui.TextWrapped(item_name);
                end

                if (entry.log_plural ~= '') then
                    imgui.Separator();
                    imgui.Text('Long Name');
                    imgui.TextWrapped(entry.log_plural);
                end

                if (entry.description ~= '') then
                    imgui.Separator();
                    imgui.Text('Description');
                    imgui.TextWrapped(entry.description);
                end
            end
        imgui.EndChild();
    end

    imgui.End();
end);