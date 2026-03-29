local imgui = require('imgui')
local fonts = require('fonts')

local M = {}

local TITLE_BY_MODULE = {
    ['Modules...'] = 'Welcome to FFXI Atlas (XIDB)',
    ['Crafting'] = 'Crafting Recipe Browser',
    ['Items Browser'] = 'Item Browser',
    ['Maps'] = 'Maps',
    ['NM'] = 'Notorious Monsters',
    ['BCNM'] = 'BCNM',
    ['KSNM'] = 'KSNM',
    ['HENM'] = 'HENM',
    ['EXP Camps'] = 'EXP Camps',
}

local function get_title_text(current_module)
    local module_name = tostring(current_module or '')
    if TITLE_BY_MODULE[module_name] ~= nil then
        return TITLE_BY_MODULE[module_name]
    end

    if module_name == '' then
        return 'Welcome to FFXI Atlas (XIDB)'
    end

    return module_name
end

local function draw_centered_text(text, color, scale, size_px, center_vertical)
    local content = tostring(text or '')
    local target_scale = scale or fonts.SCALES.NORMAL
    local text_width = fonts.MeasureText(content, size_px, target_scale)
    local available_width, available_height = imgui.GetContentRegionAvail()
    local cursor_x = imgui.GetCursorPosX()
    local cursor_y = imgui.GetCursorPosY()
    local indent = math.max(0, (available_width - text_width) / 2)

    if center_vertical then
        local line_height = nil
        if size_px ~= nil then
            fonts.WithFont(size_px, function()
                line_height = imgui.GetTextLineHeight()
            end)
        end
        if not line_height then
            line_height = imgui.GetTextLineHeight() * target_scale
        end

        local y_indent = math.max(0, (available_height - line_height) / 2)
        imgui.SetCursorPosY(cursor_y + y_indent)
    end

    imgui.SetCursorPosX(cursor_x + indent)
    if size_px ~= nil then
        fonts.TextColoredPx(content, color, size_px, target_scale)
    else
        fonts.TextColored(content, color, target_scale)
    end
end

function M.render(ctx)
    local state = ctx.state
    if type(ctx.ensure_subcategories_for_module) == 'function' then
        ctx.ensure_subcategories_for_module(state.selected_module_index)
    end

    local current_module = ctx.modules[state.selected_module_index] or ctx.modules[1]
    local subcats = ctx.subcategories[state.selected_module_index] or ctx.subcategories[1]
    local current_subcat = subcats[state.selected_subcategory_index] or subcats[1]
    local title_text = get_title_text(current_module)
    local selector_pane_flags = bit.bor(ImGuiWindowFlags_NoScrollbar, ImGuiWindowFlags_NoScrollWithMouse)

    if imgui.BeginChild('##xidb_pane_category', { 248, 70 }, true, selector_pane_flags) then
        fonts.Header('Select Category')
        imgui.SetNextItemWidth(-1)
        fonts.WithFont(18, function()
            if (imgui.BeginCombo('##xidb_select_module', current_module, ImGuiComboFlags_None)) then
                for i, module_name in ipairs(ctx.modules) do
                    local is_selected = (state.selected_module_index == i)
                    if (imgui.Selectable(module_name, is_selected)) then
                        if state.selected_module_index ~= i then
                            state.selected_module_index = i
                            state.selected_subcategory_index = 1
                            if type(ctx.ensure_subcategories_for_module) == 'function' then
                                ctx.ensure_subcategories_for_module(i)
                            end
                        end
                    end
                    if (is_selected) then
                        imgui.SetItemDefaultFocus()
                    end
                end
                imgui.EndCombo()
            end
        end)
    end
    imgui.EndChild()

    imgui.SameLine()

    if type(ctx.ensure_subcategories_for_module) == 'function' then
        ctx.ensure_subcategories_for_module(state.selected_module_index)
    end
    subcats = ctx.subcategories[state.selected_module_index] or ctx.subcategories[1]
    current_subcat = subcats[state.selected_subcategory_index] or subcats[1]

    if imgui.BeginChild('##xidb_pane_subcategory', { 248, 70 }, true, selector_pane_flags) then
        fonts.Header('Select Sub Category')
        imgui.SetNextItemWidth(-1)
        fonts.WithFont(18, function()
            if (imgui.BeginCombo('##xidb_select_subcat', current_subcat, ImGuiComboFlags_None)) then
                for i, subcat_name in ipairs(subcats) do
                    local is_selected = (state.selected_subcategory_index == i)
                    if (imgui.Selectable(subcat_name, is_selected)) then
                        state.selected_subcategory_index = i
                    end
                    if (is_selected) then
                        imgui.SetItemDefaultFocus()
                    end
                end
                imgui.EndCombo()
            end
        end)
    end
    imgui.EndChild()

    imgui.SameLine()

    if imgui.BeginChild('##xidb_pane_title', { 0, 70 }, true, selector_pane_flags) then
        draw_centered_text(title_text, fonts.COLORS.GOLD, fonts.SCALES.TITLE, 24, true)
    end
    imgui.EndChild()

    imgui.Spacing()

    return current_module
end

return M
