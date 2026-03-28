local crafting_ranks = require('ranks')
local zones = require('zones')
local nm_data = require('nms.nm_data')
local bcnm_data = require('bcnm.bcnm_data')
local ksnm_data = require('ksnm.ksnm_data')
local henm_data = require('henm.henm_data')

local M = {}

M.MODULES = {
    'Modules...',
    'Crafting',
    'Items Browser',
    'Maps',
    'NM',
    'BCNM',
    'KSNM',
    'HENM',
}

M.MODULE_INDEX = {
    HOME = 1,
    CRAFTING = 2,
    ITEMS = 3,
    MAPS = 4,
    NM = 5,
    BCNM = 6,
    KSNM = 7,
    HENM = 8,
}

M.RESULTS_PANE_WIDTH = 300
M.DETAILS_PANE_WIDTH = 320
M.crafting_ranks = crafting_ranks

M.WINDOW_DEFAULT = {
    x = 100,
    y = 100,
    width = 980,
    height = 620,
}

M.WINDOW_MIN = {
    width = 820,
    height = 500,
}

M.CRAFT_SUBCATEGORY_TO_SKILL = {
    ['Alchemy'] = 'alchemy',
    ['Bonecrafting'] = 'bonecraft',
    ['Clothcraft'] = 'clothcraft',
    ['Cooking'] = 'cooking',
    ['Goldsmithing'] = 'goldsmith',
    ['Leathercraft'] = 'leathercraft',
    ['Smithing'] = 'smithing',
    ['Woodworking'] = 'woodworking',
}

local function build_maps_nm_subcategories()
    local areas_by_key = { }
    for _, zone in ipairs(zones.list or { }) do
        if type(zone) == 'table' then
            local area_name = tostring(zone.area or ''):match('^%s*(.-)%s*$') or ''
            if area_name ~= '' then
                local key = area_name:lower()
                if areas_by_key[key] == nil then
                    areas_by_key[key] = area_name
                end
            end
        end
    end

    local area_list = { }
    for _, area_name in pairs(areas_by_key) do
        area_list[#area_list + 1] = area_name
    end

    table.sort(area_list, function(a, b)
        return a:lower() < b:lower()
    end)

    local subcategories = { 'Select Sub Category' }
    for _, area_name in ipairs(area_list) do
        subcategories[#subcategories + 1] = area_name
    end

    return subcategories
end

local function build_nm_zones_subcategories()
    local zones_by_key = { }
    for _, nm in ipairs(nm_data.nm_list or { }) do
        if type(nm) == 'table' then
            local zone_name = tostring(nm.area or ''):match('^%s*(.-)%s*$') or ''
            if zone_name ~= '' then
                local key = zone_name:lower()
                if zones_by_key[key] == nil then
                    zones_by_key[key] = zone_name
                end
            end
        end
    end

    local zone_list = { }
    for _, zone_name in pairs(zones_by_key) do
        zone_list[#zone_list + 1] = zone_name
    end

    table.sort(zone_list, function(a, b)
        return a:lower() < b:lower()
    end)

    local subcategories = { 'Select Sub Category' }
    for _, zone_name in ipairs(zone_list) do
        subcategories[#subcategories + 1] = zone_name
    end

    return subcategories
end

local function build_bcnm_levels_subcategories()
    local levels_by_key = { }
    for _, bcnm in ipairs(bcnm_data.bcnm_list or { }) do
        if type(bcnm) == 'table' then
            local level_text = tostring(bcnm.level or ''):match('^%s*(.-)%s*$') or ''
            if level_text ~= '' then
                local key = level_text:lower()
                if levels_by_key[key] == nil then
                    levels_by_key[key] = level_text
                end
            end
        end
    end

    local level_list = { }
    for _, level_text in pairs(levels_by_key) do
        level_list[#level_list + 1] = level_text
    end

    table.sort(level_list, function(a, b)
        local na = tonumber(a)
        local nb = tonumber(b)
        if na ~= nil and nb ~= nil then
            return na < nb
        end
        return a:lower() < b:lower()
    end)

    local subcategories = { 'Select Sub Category' }
    for _, level_text in ipairs(level_list) do
        subcategories[#subcategories + 1] = level_text
    end

    return subcategories
end

local function build_ksnm_levels_subcategories()
    local levels_by_key = { }
    for _, ksnm in ipairs(ksnm_data.ksnm_list or { }) do
        if type(ksnm) == 'table' then
            local level_text = tostring(ksnm.level or ''):match('^%s*(.-)%s*$') or ''
            if level_text ~= '' then
                local key = level_text:lower()
                if levels_by_key[key] == nil then
                    levels_by_key[key] = level_text
                end
            end
        end
    end

    local level_list = { }
    for _, level_text in pairs(levels_by_key) do
        level_list[#level_list + 1] = level_text
    end

    table.sort(level_list, function(a, b)
        local na = tonumber(a)
        local nb = tonumber(b)
        if na ~= nil and nb ~= nil then
            return na < nb
        end
        return a:lower() < b:lower()
    end)

    local subcategories = { 'Select Sub Category' }
    for _, level_text in ipairs(level_list) do
        subcategories[#subcategories + 1] = level_text
    end

    return subcategories
end

local function build_henm_tiers_subcategories()
    local tiers_by_key = { }
    for _, henm in ipairs(henm_data.henm_list or { }) do
        if type(henm) == 'table' then
            local tier_name = tostring(henm.tier or ''):match('^%s*(.-)%s*$') or ''
            if tier_name ~= '' then
                local key = tier_name:lower()
                if tiers_by_key[key] == nil then
                    tiers_by_key[key] = tier_name
                end
            end
        end
    end

    local tier_list = { }
    for _, tier_name in pairs(tiers_by_key) do
        tier_list[#tier_list + 1] = tier_name
    end

    table.sort(tier_list, function(a, b)
        return a:lower() < b:lower()
    end)

    local subcategories = { 'Select Sub Category' }
    for _, tier_name in ipairs(tier_list) do
        subcategories[#subcategories + 1] = tier_name
    end

    return subcategories
end

M.SUBCATEGORIES = {
    [M.MODULE_INDEX.HOME] = { 'Select Sub Category' },
    [M.MODULE_INDEX.CRAFTING] = {
        'Select Sub Category',
        'Alchemy',
        'Bonecrafting',
        'Clothcraft',
        'Cooking',
        'Goldsmithing',
        'Leathercraft',
        'Smithing',
        'Woodworking',
    },
    [M.MODULE_INDEX.ITEMS] = { 'Select Sub Category' },
    [M.MODULE_INDEX.MAPS] = build_maps_nm_subcategories(),
    [M.MODULE_INDEX.NM] = build_nm_zones_subcategories(),
    [M.MODULE_INDEX.BCNM] = build_bcnm_levels_subcategories(),
    [M.MODULE_INDEX.KSNM] = build_ksnm_levels_subcategories(),
    [M.MODULE_INDEX.HENM] = build_henm_tiers_subcategories(),
}

function M.get_current_subcategory_name(state)
    local subcategories = M.SUBCATEGORIES[state.selected_module_index] or M.SUBCATEGORIES[M.MODULE_INDEX.HOME]
    return subcategories[state.selected_subcategory_index] or subcategories[1]
end

return M
