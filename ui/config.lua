local crafting_ranks = require('ranks')

local M = {}
local subcategory_cache = {}

local function safe_require(module_name)
    local ok, mod = pcall(require, module_name)
    if ok and type(mod) == 'table' then
        return mod
    end
    return {}
end

M.MODULES = {
    'Modules...',
    'Crafting',
    'Items Browser',
    'Maps',
    'NM',
    'BCNM',
    'KSNM',
    'HENM',
    'EXP Camps',
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
    EXP_CAMPS = 9,
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
    local zones = safe_require('zones')
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
    local nm_data = safe_require('nms.nm_data')
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
    local bcnm_data = safe_require('bcnm.bcnm_data')
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
    local ksnm_data = safe_require('ksnm.ksnm_data')
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
    local henm_data = safe_require('henm.henm_data')
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

local function build_expcamp_type_subcategories()
    local expcamps_data = safe_require('expcamps.expcamps')
    local types_by_key = { }
    for _, camp in ipairs(expcamps_data or { }) do
        if type(camp) == 'table' then
            local camp_type = tostring(camp.camp_type or ''):match('^%s*(.-)%s*$') or ''
            if camp_type ~= '' then
                local key = camp_type:lower()
                if types_by_key[key] == nil then
                    types_by_key[key] = camp_type
                end
            end
        end
    end

    local ordered_keys = {
        'exp camp',
        'merit camp',
        'mana burn camp',
        'undead burn camp',
    }

    local subcategories = { 'Select Sub Category' }
    local added = { }

    for _, key in ipairs(ordered_keys) do
        if types_by_key[key] ~= nil then
            subcategories[#subcategories + 1] = types_by_key[key]
            added[key] = true
        end
    end

    local remainder = { }
    for key, type_name in pairs(types_by_key) do
        if not added[key] then
            remainder[#remainder + 1] = type_name
        end
    end

    table.sort(remainder, function(a, b)
        return a:lower() < b:lower()
    end)

    for _, type_name in ipairs(remainder) do
        subcategories[#subcategories + 1] = type_name
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
    [M.MODULE_INDEX.MAPS] = { 'Select Sub Category' },
    [M.MODULE_INDEX.NM] = { 'Select Sub Category' },
    [M.MODULE_INDEX.BCNM] = { 'Select Sub Category' },
    [M.MODULE_INDEX.KSNM] = { 'Select Sub Category' },
    [M.MODULE_INDEX.HENM] = { 'Select Sub Category' },
    [M.MODULE_INDEX.EXP_CAMPS] = { 'Select Sub Category' },
}

local function build_subcategories_for_module(module_index)
    if module_index == M.MODULE_INDEX.MAPS then
        return build_maps_nm_subcategories()
    end
    if module_index == M.MODULE_INDEX.NM then
        return build_nm_zones_subcategories()
    end
    if module_index == M.MODULE_INDEX.BCNM then
        return build_bcnm_levels_subcategories()
    end
    if module_index == M.MODULE_INDEX.KSNM then
        return build_ksnm_levels_subcategories()
    end
    if module_index == M.MODULE_INDEX.HENM then
        return build_henm_tiers_subcategories()
    end
    if module_index == M.MODULE_INDEX.EXP_CAMPS then
        return build_expcamp_type_subcategories()
    end

    return M.SUBCATEGORIES[module_index] or { 'Select Sub Category' }
end

function M.get_subcategories(module_index)
    if subcategory_cache[module_index] ~= nil then
        return subcategory_cache[module_index]
    end

    local built = build_subcategories_for_module(module_index)
    if type(built) ~= 'table' or #built == 0 then
        built = { 'Select Sub Category' }
    end

    subcategory_cache[module_index] = built
    M.SUBCATEGORIES[module_index] = built
    return built
end

function M.ensure_subcategories_for_module(module_index)
    return M.get_subcategories(module_index)
end

function M.get_current_subcategory_name(state)
    local subcategories = M.get_subcategories(state.selected_module_index)
        or M.SUBCATEGORIES[M.MODULE_INDEX.HOME]
    return subcategories[state.selected_subcategory_index] or subcategories[1]
end

return M
