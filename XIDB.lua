addon.name      = 'XIDB';
addon.author    = 'Lydya';
addon.version   = '0.3.0';
addon.desc      = 'Browsable item database backed by Ashita v4 item resources.';
addon.link      = 'https://github.com/Lydya-Nick77/XIDB';

require('common');
local chat = require('chat');
local settings = require('settings');
imgui = require('imgui');
local ffi = require('ffi')
local json = require('json')
local itemicon = require('itemicon')
local encoding = require('encoding')
local ui = require('ui')
local ui_config = require('ui.config')

local default_settings = T{
    auto_scan = T{ true, },
    max_results = 250,
    max_scan_id = 65535,
    window = T{
        x = ui_config.WINDOW_DEFAULT.x,
        y = ui_config.WINDOW_DEFAULT.y,
        width = ui_config.WINDOW_DEFAULT.width,
        height = ui_config.WINDOW_DEFAULT.height,
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

local save_cache;

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

local function has_bit(m, b)
    if bit and bit.band then
        return bit.band(m, b) ~= 0
    else
        return (m % (b * 2)) >= b
    end
end

local ORDERED_EQUIP_BITS = {0x0001,0x0002,0x0004,0x0008,0x0010,0x0020,0x0040,0x0080,0x0100,0x0200,0x0400,0x0800,0x1000,0x2000,0x4000,0x8000}

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

    local parts = { }
    for _, b in ipairs(ORDERED_EQUIP_BITS) do
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

    if (#xidb.db.results == 0) then
        xidb.db.selected_id = nil;
    elseif (xidb.db.selected_id == nil or xidb.db.items_by_id[xidb.db.selected_id] == nil) then
        xidb.db.selected_id = xidb.db.results[1].id;
    else
        local selected_visible = false;
        for _, entry in ipairs(xidb.db.results) do
            if (entry.id == xidb.db.selected_id) then
                selected_visible = true;
                break;
            end
        end
        if not selected_visible then
            xidb.db.selected_id = xidb.db.results[1].id;
        end
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

    save_cache();

    refresh_results(true);

    if (#xidb.db.results > 0) then
        select_item(xidb.db.results[1].id);
    end

    if (not silent) then
        print_message(xidb.db.status);
    end
end

local function get_cache_dir()
    return addon.path .. 'items';
end

local function get_cache_path()
    return get_cache_dir() .. '\\item_cache.json';
end

save_cache = function()
    local to_save = {};
    for _, entry in ipairs(xidb.db.items) do
        to_save[#to_save + 1] = {
            id          = entry.id,
            name        = entry.name,
            log_singular = entry.log_singular,
            log_plural  = entry.log_plural,
            description = entry.description,
            type        = entry.type,
            flags       = entry.flags,
            stack_size  = entry.stack_size,
            level       = entry.level,
            jobs        = entry.jobs,
            slots       = entry.slots,
        };
    end

    os.execute(('mkdir "%s" >nul 2>nul'):fmt(get_cache_dir()));

    local path = get_cache_path();
    local f, err = io.open(path, 'w+');
    if not f then
        print_error(('Failed to write item cache: %s'):fmt(tostring(err)));
        return;
    end
    local ok, enc = pcall(json.encode, to_save);
    if not ok or not enc then
        print_error('Failed to encode item cache.');
        f:close();
        return;
    end
    f:write(enc);
    f:close();
end

local function load_from_cache()
    local path = get_cache_path();
    local f = io.open(path, 'r');
    if not f then
        return false;
    end
    local content = f:read('*a');
    f:close();

    if not content or content == '' then
        return false;
    end

    local ok, loaded = pcall(json.decode, content);
    if not ok or type(loaded) ~= 'table' then
        return false;
    end

    xidb.db.items = {};
    xidb.db.items_by_id = {};

    for _, raw in ipairs(loaded) do
        local id = to_number(raw.id, 0);
        if id > 0 then
            local entry = {
                id            = id,
                name          = raw.name or '',
                name_lc       = string.lower(raw.name or ''),
                log_singular  = raw.log_singular or '',
                log_singular_lc = string.lower(raw.log_singular or ''),
                log_plural    = raw.log_plural or '',
                log_plural_lc = string.lower(raw.log_plural or ''),
                description   = raw.description or '',
                description_lc = string.lower(raw.description or ''),
                resource      = nil,
                type          = to_number(raw.type, 0),
                flags         = to_number(raw.flags, 0),
                stack_size    = to_number(raw.stack_size, 0),
                level         = to_number(raw.level, 0),
                jobs          = to_number(raw.jobs, 0),
                slots         = to_number(raw.slots, 0),
            };
            xidb.db.items[#xidb.db.items + 1] = entry;
            xidb.db.items_by_id[id] = entry;
        end
    end

    return #xidb.db.items > 0;
end

local function apply_cache_load(started_at)
    xidb.db.indexed = true;
    xidb.db.scanned_count = #xidb.db.items;
    xidb.db.last_scan_seconds = os.clock() - started_at;
    xidb.db.status = ('Loaded %d items from cache in %.2f seconds.'):fmt(
        xidb.db.scanned_count, xidb.db.last_scan_seconds);
    xidb.db.cache_query = nil;
    xidb.db.cache_limit = nil;
    refresh_results(true);
    if (#xidb.db.results > 0) then
        select_item(xidb.db.results[1].id);
    end
end

local function ensure_index()
    if (not xidb.db.indexed and not xidb.db.indexing) then
        local started_at = os.clock();
        if load_from_cache() then
            apply_cache_load(started_at);
        else
            rebuild_index(false);
        end
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
        local started_at = os.clock();
        if load_from_cache() then
            apply_cache_load(started_at);
        else
            rebuild_index(true);
        end
    end
end);

ashita.events.register('unload', 'xidb_unload_cb', function ()
    -- Cleanup DAT reader resources
    local ok, dat_reader = pcall(require, 'dat_reader')
    if ok and dat_reader and dat_reader.cleanup then
        dat_reader.cleanup()
    end

    settings.save()
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

    print_help(true);
end);

ashita.events.register('d3d_present', 'xidb_present_cb', function ()
    ui.render(xidb, {
        ensure_index = ensure_index,
        rebuild_index = rebuild_index,
        refresh_results = refresh_results,
        set_filter = set_filter,
        select_item = select_item,
        to_number = to_number,
        get_item_name_by_id = get_item_name_by_id,
        format_item_type = format_item_type,
        format_flags_mask = format_flags_mask,
        format_jobs_mask = format_jobs_mask,
        format_slots_mask = format_slots_mask,
        print_error = print_error,
        itemicon = itemicon,
        FLT_MAX = FLT_MAX,
    })
end);