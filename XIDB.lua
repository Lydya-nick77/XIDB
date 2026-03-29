addon.name      = 'XIDB';
addon.author    = 'Lydya';
addon.version   = '0.6.0 ';
addon.desc      = 'Browsable item database backed by Ashita v4 item resources.';
addon.link      = 'https://github.com/Lydya-Nick77/XIDB';

require('common');
local chat = require('chat');
local settings = require('settings');
imgui = require('imgui');
local itemicon = require('itemicon');
local ui = require('ui');
local ui_config = require('ui.config');

local helpers = require('core.helpers');
local item_meta = require('core.item_meta');
local item_resources = require('core.item_resources');
local index_factory = require('core.index');
local json = require('json');

local VK_ESCAPE = 0x1B;
local KEYUP_MASK = bit.lshift(0x8000, 0x10);

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

local function print_message(message)
    print(chat.header(addon.name):append(chat.message(message)));
end

local function print_error(message)
    print(chat.header(addon.name):append(chat.error(message)));
end

local function get_cache_dir()
    return addon.path .. 'items';
end

local function get_cache_path()
    return get_cache_dir() .. '\\item_cache.json';
end

local index = index_factory.create(xidb, {
    cache_dir = get_cache_dir(),
    cache_path = get_cache_path(),
    json = json,
    itemicon = itemicon,
    print_message = print_message,
    print_error = print_error,
});

local function print_help(is_error)
    if (is_error) then
        print_error('Invalid command syntax.');
    end

    print_message('Available commands:');
    print_message('/xidb - Open or close the item database window.');
    print_message('/xidb help - Show this help text.');
end

local function set_window_open(is_open)
    local next_state = (is_open == true);
    if (xidb.ui.is_open[1] == next_state) then
        return;
    end

    xidb.ui.is_open[1] = next_state;
    if (next_state) then
        index.ensure_index();
    else
        index.release_index_memory();
    end
end

local function toggle_window_open()
    set_window_open(not xidb.ui.is_open[1]);
end

settings.register('settings', 'settings_update', function (s)
    if (s ~= nil) then
        xidb.settings = s;
    end

    index.refresh_results(true);
end);

ashita.events.register('load', 'xidb_load_cb', function ()
    xidb.settings = settings.load(default_settings);

    if (xidb.settings.auto_scan[1]) then
        index.prime_index_from_setting(true);
    end
end);

ashita.events.register('unload', 'xidb_unload_cb', function ()
    local ok, dat_reader = pcall(require, 'dat_reader');
    if ok and dat_reader and dat_reader.cleanup then
        dat_reader.cleanup();
    end

    settings.save();
end);

ashita.events.register('command', 'xidb_command_cb', function (e)
    local args = e.command:args();
    if (#args == 0 or not args[1]:any('/xidb')) then
        return;
    end

    e.blocked = true;

    if (#args == 1) then
        toggle_window_open();
        return;
    end

    if (args[2]:any('help')) then
        print_help(false);
        return;
    end

    print_help(true);
end);

ashita.events.register('key', 'xidb_key_cb', function (e)
    if (not xidb.ui.is_open[1]) then
        return;
    end

    if (e.wparam ~= VK_ESCAPE) then
        return;
    end

    if (bit.band(e.lparam, KEYUP_MASK) == KEYUP_MASK) then
        return;
    end

    set_window_open(false);
end);

ashita.events.register('d3d_present', 'xidb_present_cb', function ()
    ui.render(xidb, {
        ensure_index = index.ensure_index,
        rebuild_index = index.rebuild_index,
        refresh_results = index.refresh_results,
        set_filter = index.set_filter,
        select_item = index.select_item,
        to_number = helpers.to_number,
        get_item_name_by_id = item_resources.get_item_name_by_id,
        format_item_type = item_meta.format_item_type,
        format_flags_mask = item_meta.format_flags_mask,
        format_jobs_mask = item_meta.format_jobs_mask,
        format_slots_mask = item_meta.format_slots_mask,
        print_error = print_error,
        itemicon = itemicon,
        FLT_MAX = FLT_MAX,
    });
end);
