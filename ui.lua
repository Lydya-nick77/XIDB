local imgui = require('imgui')
local selectors_ui = require('ui.selectors')
local home_category_ui = require('ui.category_home')
local crafting_category_ui = require('ui.category_crafting')
local items_category_ui = require('ui.category_items')
local maps_nm_category_ui = require('ui.category_maps')
local placeholder_category_ui = require('ui.category_placeholder')
local ui_config = require('ui.config')
local ui_chrome = require('ui.chrome')
local ui_data = require('ui.data')

local ui = { }

local ui_state = {
    selected_module_index = ui_config.MODULE_INDEX.HOME,
    selected_subcategory_index = 1,
    selected_rank_index = 1,
    selected_map_zone_index = 1,
    selected_map_area_key = nil,
    selected_map_preview_zone = nil,
    selected_map_preview_index = 1,
}

local function build_render_context()
    return {
        state = ui_state,
        modules = ui_config.MODULES,
        subcategories = ui_config.SUBCATEGORIES,
        craft_subcategory_to_skill = ui_config.CRAFT_SUBCATEGORY_TO_SKILL,
        crafting_ranks = ui_config.crafting_ranks,
        details_cache = ui_data.details_cache,
        results_pane_width = ui_config.RESULTS_PANE_WIDTH,
        details_pane_width = ui_config.DETAILS_PANE_WIDTH,
        draw_centered_logo = ui_chrome.draw_centered_logo,
        get_current_subcategory_name = function()
            return ui_config.get_current_subcategory_name(ui_state)
        end,
        update_details_cache = ui_data.update_details_cache,
        ingredient_to_lookup_name = ui_data.ingredient_to_lookup_name,
        find_item_id_by_name = ui_data.find_item_id_by_name,
        get_recipes_for_item_name = ui_data.get_recipes_for_item_name,
        get_recipes_using_item_name = ui_data.get_recipes_using_item_name,
        get_recipes_for_item_entry = ui_data.get_recipes_for_item_entry,
        get_recipes_for_skill_and_rank = ui_data.get_recipes_for_skill_and_rank,
    }
end

local function render_selected_module(ctx, xidb, deps, current_module)
    local selected_module_index = ui_state.selected_module_index

    if selected_module_index == ui_config.MODULE_INDEX.HOME then
        home_category_ui.render(ctx)
    elseif selected_module_index == ui_config.MODULE_INDEX.CRAFTING then
        crafting_category_ui.render(ctx)
    elseif selected_module_index == ui_config.MODULE_INDEX.ITEMS then
        items_category_ui.render(ctx, xidb, deps)
    elseif selected_module_index == ui_config.MODULE_INDEX.MAPS then
        maps_nm_category_ui.render(ctx)
    else
        placeholder_category_ui.render(ctx, current_module)
    end
end

function ui.render(xidb, deps)
    if (not xidb.ui.is_open[1]) then
        return
    end

    local pushed_style_colors, pushed_style_vars = ui_chrome.push_theme()
    imgui.PushStyleVar(ImGuiStyleVar_WindowTitleAlign, { 0.5, 0.5 })
    pushed_style_vars = pushed_style_vars + 1

    imgui.SetNextWindowPos({ xidb.settings.window.x, xidb.settings.window.y }, ImGuiCond_FirstUseEver)
    imgui.SetNextWindowSize({ xidb.settings.window.width, xidb.settings.window.height }, ImGuiCond_FirstUseEver)
    imgui.SetNextWindowSizeConstraints({ ui_config.WINDOW_MIN.width, ui_config.WINDOW_MIN.height, }, { deps.FLT_MAX, deps.FLT_MAX, })

    if (imgui.Begin('FFXI Atlas (XIDB)', xidb.ui.is_open, bit.bor(ImGuiWindowFlags_NoCollapse))) then
        local pos_x, pos_y = imgui.GetWindowPos()
        local size_x, size_y = imgui.GetWindowSize()
        xidb.settings.window.x = math.floor(pos_x)
        xidb.settings.window.y = math.floor(pos_y)
        xidb.settings.window.width = math.floor(size_x)
        xidb.settings.window.height = math.floor(size_y)

        local ctx = build_render_context()
        local current_module = selectors_ui.render(ctx)
        render_selected_module(ctx, xidb, deps, current_module)
    end

    imgui.End()
    imgui.PopStyleVar(pushed_style_vars)
    imgui.PopStyleColor(pushed_style_colors)
end

return ui