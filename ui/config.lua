local crafting_ranks = require('ranks')
local zones = require('zones')

local M = {}

M.MODULES = {
    'Modules...',
    'Crafting',
    'Items Browser',
    'Maps',
    'NM'
}

M.MODULE_INDEX = {
    HOME = 1,
    CRAFTING = 2,
    ITEMS = 3,
    MAPS = 4,
    NM = 5,
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
    [M.MODULE_INDEX.NM] = { 'Select Sub Category' },
}

function M.get_current_subcategory_name(state)
    local subcategories = M.SUBCATEGORIES[state.selected_module_index] or M.SUBCATEGORIES[M.MODULE_INDEX.HOME]
    return subcategories[state.selected_subcategory_index] or subcategories[1]
end

return M