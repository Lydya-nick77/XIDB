local helpers = require('core.helpers')
local item_resources = require('core.item_resources')

local M = {}

local function build_entry(id, item)
    local name = helpers.table_text(item.Name)

    if name == nil or name == '' or tostring(name):match('userdata') then
        local alt = item_resources.get_item_name_by_id(id)
        if type(alt) == 'string' and alt ~= '' then
            name = alt
        end
    end

    local log_singular = helpers.table_text(item.LogNameSingular)
    local log_plural = helpers.table_text(item.LogNamePlural)

    if log_singular == nil or log_singular == '' or tostring(log_singular):match('userdata') then
        local alt = item_resources.get_item_logname_by_id(id, 'LogNameSingular')
        if type(alt) == 'string' and alt ~= '' then
            log_singular = alt
        end
    end

    if log_plural == nil or log_plural == '' or tostring(log_plural):match('userdata') then
        local alt = item_resources.get_item_logname_by_id(id, 'LogNamePlural')
        if type(alt) == 'string' and alt ~= '' then
            log_plural = alt
        end
    end

    local description = helpers.table_text(item.Description)
    if description == nil or description == '' or tostring(description):match('userdata') then
        local alt = item_resources.get_item_description_by_id(id)
        if type(alt) == 'string' and alt ~= '' then
            description = alt
        end
    end

    if name == '' then
        name = ('Item #%d'):fmt(id)
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
        type = helpers.to_number(item.Type, 0),
        flags = helpers.to_number(item.Flags, 0),
        stack_size = helpers.to_number(item.StackSize, 0),
        level = helpers.to_number(item.Level, 0),
        jobs = helpers.to_number(item.Jobs, 0),
        slots = helpers.to_number(item.Slots, 0),
    }
end

local function score_entry(query, entry)
    if query == '' then
        return 1000
    end

    local id_text = tostring(entry.id)
    if id_text == query then
        return 0
    end

    if entry.name_lc == query or entry.log_singular_lc == query or entry.log_plural_lc == query then
        return 1
    end
    if string.sub(entry.name_lc, 1, #query) == query then
        return 2
    end
    if entry.log_singular_lc ~= '' and string.sub(entry.log_singular_lc, 1, #query) == query then
        return 3
    end
    if entry.log_plural_lc ~= '' and string.sub(entry.log_plural_lc, 1, #query) == query then
        return 4
    end
    if string.find(entry.name_lc, query, 1, true) ~= nil then
        return 5
    end
    if entry.log_singular_lc ~= '' and string.find(entry.log_singular_lc, query, 1, true) ~= nil then
        return 6
    end
    if entry.log_plural_lc ~= '' and string.find(entry.log_plural_lc, query, 1, true) ~= nil then
        return 7
    end
    if entry.description_lc ~= '' and string.find(entry.description_lc, query, 1, true) ~= nil then
        return 8
    end
    if string.find(id_text, query, 1, true) ~= nil then
        return 9
    end

    return nil
end

local function load_from_cache(xidb, cache_path, json)
    local f = io.open(cache_path, 'r')
    if not f then
        return false
    end

    local content = f:read('*a')
    f:close()

    if not content or content == '' then
        return false
    end

    local ok, loaded = pcall(json.decode, content)
    if not ok or type(loaded) ~= 'table' then
        return false
    end

    xidb.db.items = {}
    xidb.db.items_by_id = {}

    for _, raw in ipairs(loaded) do
        local id = helpers.to_number(raw.id, 0)
        if id > 0 then
            local name = raw.name or ''
            local log_singular = raw.log_singular or ''
            local log_plural = raw.log_plural or ''
            local description = raw.description or ''

            local entry = {
                id = id,
                name = name,
                name_lc = string.lower(name),
                log_singular = log_singular,
                log_singular_lc = string.lower(log_singular),
                log_plural = log_plural,
                log_plural_lc = string.lower(log_plural),
                description = description,
                description_lc = string.lower(description),
                resource = nil,
                type = helpers.to_number(raw.type, 0),
                flags = helpers.to_number(raw.flags, 0),
                stack_size = helpers.to_number(raw.stack_size, 0),
                level = helpers.to_number(raw.level, 0),
                jobs = helpers.to_number(raw.jobs, 0),
                slots = helpers.to_number(raw.slots, 0),
            }

            xidb.db.items[#xidb.db.items + 1] = entry
            xidb.db.items_by_id[id] = entry
        end
    end

    return #xidb.db.items > 0
end

local function save_cache(xidb, cache_dir, cache_path, json, print_error)
    local to_save = {}
    for _, entry in ipairs(xidb.db.items) do
        to_save[#to_save + 1] = {
            id = entry.id,
            name = entry.name,
            log_singular = entry.log_singular,
            log_plural = entry.log_plural,
            description = entry.description,
            type = entry.type,
            flags = entry.flags,
            stack_size = entry.stack_size,
            level = entry.level,
            jobs = entry.jobs,
            slots = entry.slots,
        }
    end

    os.execute(('mkdir "%s" >nul 2>nul'):fmt(cache_dir))

    local f, err = io.open(cache_path, 'w+')
    if not f then
        print_error(('Failed to write item cache: %s'):fmt(tostring(err)))
        return
    end

    local ok, encoded = pcall(json.encode, to_save)
    if not ok or not encoded then
        print_error('Failed to encode item cache.')
        f:close()
        return
    end

    f:write(encoded)
    f:close()
end

function M.create(xidb, opts)
    local index = {}

    local function apply_cache_load(started_at)
        xidb.db.indexed = true
        xidb.db.scanned_count = #xidb.db.items
        xidb.db.last_scan_seconds = os.clock() - started_at
        xidb.db.status = ('Loaded %d items from cache in %.2f seconds.'):fmt(
            xidb.db.scanned_count, xidb.db.last_scan_seconds)
        xidb.db.cache_query = nil
        xidb.db.cache_limit = nil
        index.refresh_results(true)

        if #xidb.db.results > 0 then
            index.select_item(xidb.db.results[1].id)
        end
    end

    function index.select_item(item_id)
        local id = helpers.to_number(item_id, 0)
        if id <= 0 then
            xidb.db.selected_id = nil
            return
        end

        if xidb.db.items_by_id[id] ~= nil then
            xidb.db.selected_id = id
            return
        end

        xidb.db.selected_id = nil
    end

    function index.refresh_results(force)
        local query = helpers.lower(xidb.ui.filter[1])
        local limit = math.max(25, helpers.to_number(xidb.settings.max_results, 250))

        if not force and xidb.db.cache_query == query and xidb.db.cache_limit == limit then
            return
        end

        xidb.db.cache_query = query
        xidb.db.cache_limit = limit
        xidb.db.results = {}
        xidb.db.total_matches = 0

        if not xidb.db.indexed then
            return
        end

        if query == '' then
            xidb.db.total_matches = #xidb.db.items
            local max_count = math.min(limit, #xidb.db.items)
            for i = 1, max_count do
                xidb.db.results[#xidb.db.results + 1] = xidb.db.items[i]
            end
        else
            local matches = {}
            for _, entry in ipairs(xidb.db.items) do
                local score = score_entry(query, entry)
                if score ~= nil then
                    xidb.db.total_matches = xidb.db.total_matches + 1
                    matches[#matches + 1] = {
                        score = score,
                        entry = entry,
                    }
                end
            end

            table.sort(matches, function(a, b)
                if a.score == b.score then
                    if a.entry.name_lc == b.entry.name_lc then
                        return a.entry.id < b.entry.id
                    end

                    return a.entry.name_lc < b.entry.name_lc
                end

                return a.score < b.score
            end)

            local max_count = math.min(limit, #matches)
            for i = 1, max_count do
                xidb.db.results[#xidb.db.results + 1] = matches[i].entry
            end
        end

        if #xidb.db.results == 0 then
            xidb.db.selected_id = nil
        elseif xidb.db.selected_id == nil or xidb.db.items_by_id[xidb.db.selected_id] == nil then
            xidb.db.selected_id = xidb.db.results[1].id
        else
            local selected_visible = false
            for _, entry in ipairs(xidb.db.results) do
                if entry.id == xidb.db.selected_id then
                    selected_visible = true
                    break
                end
            end
            if not selected_visible then
                xidb.db.selected_id = xidb.db.results[1].id
            end
        end
    end

    function index.rebuild_index(silent)
        if xidb.db.indexing then
            if not silent then
                opts.print_message('A scan is already running.')
            end
            return
        end

        local resources = AshitaCore:GetResourceManager()
        if resources == nil then
            opts.print_error('Unable to access the Ashita resource manager.')
            return
        end

        xidb.db.indexing = true
        xidb.db.status = 'Scanning item resources..'

        pcall(function() opts.itemicon.clear() end)

        xidb.db.items = {}
        xidb.db.items_by_id = {}
        xidb.db.indexed = false
        xidb.db.selected_id = nil

        local started_at = os.clock()
        local miss_streak = 0
        local max_scan_id = math.max(4096, helpers.to_number(xidb.settings.max_scan_id, 65535))

        for id = 1, max_scan_id do
            local ok, item = pcall(function() return resources:GetItemById(id) end)
            if not ok then
                item = nil
            end

            if item ~= nil then
                local entry = build_entry(id, item)
                local name = tostring(entry.name or '')
                local is_autogen = name:match('^Item #%d+$') ~= nil
                local is_empty_or_punct = helpers.trim(name) == '' or name:match('^%p+$') ~= nil

                if not is_autogen and not is_empty_or_punct then
                    entry.resource = nil
                    xidb.db.items[#xidb.db.items + 1] = entry
                    xidb.db.items_by_id[id] = entry
                    miss_streak = 0
                else
                    miss_streak = miss_streak + 1
                end
            else
                miss_streak = miss_streak + 1
            end

            if #xidb.db.items > 0 and miss_streak >= 2048 then
                break
            end
        end

        xidb.db.indexing = false
        xidb.db.indexed = true
        xidb.db.scanned_count = #xidb.db.items
        xidb.db.last_scan_seconds = os.clock() - started_at
        xidb.db.status = ('Indexed %d items in %.2f seconds.'):fmt(xidb.db.scanned_count, xidb.db.last_scan_seconds)
        xidb.db.cache_query = nil
        xidb.db.cache_limit = nil

        save_cache(xidb, opts.cache_dir, opts.cache_path, opts.json, opts.print_error)

        index.refresh_results(true)

        if #xidb.db.results > 0 then
            index.select_item(xidb.db.results[1].id)
        end

        if not silent then
            opts.print_message(xidb.db.status)
        end
    end

    function index.ensure_index()
        if not xidb.db.indexed and not xidb.db.indexing then
            local started_at = os.clock()
            if load_from_cache(xidb, opts.cache_path, opts.json) then
                apply_cache_load(started_at)
            else
                index.rebuild_index(false)
            end
        end
    end

    function index.prime_index_from_setting(silent_rebuild)
        local started_at = os.clock()
        if load_from_cache(xidb, opts.cache_path, opts.json) then
            apply_cache_load(started_at)
        else
            index.rebuild_index(silent_rebuild == true)
        end
    end

    function index.set_filter(value)
        xidb.ui.filter[1] = value or ''
        index.refresh_results(true)
    end

    return index
end

return M
