local imgui = require('imgui')
local ffi = require('ffi')
local d3d8 = require('d3d8')

local C = ffi.C

local M = {}

local logo_texture_id = nil
local logo_loaded = false
local LOGO_DRAW_WIDTH = 480
local LOGO_DRAW_HEIGHT = 240

local function try_load_logo_texture()
    if logo_loaded then
        return logo_texture_id
    end

    logo_loaded = true

    local d3d8dev = d3d8.get_device()
    if not d3d8dev then
        return nil
    end

    local addon_path = ''
    if addon and addon.path then
        addon_path = tostring(addon.path)
    end
    local logo_path = ('%sassets/logo.png'):fmt(addon_path)

    local texture_ptr = ffi.new('IDirect3DTexture8*[1]')
    local hr = C.D3DXCreateTextureFromFileA(d3d8dev, logo_path, texture_ptr)
    if hr ~= C.S_OK or texture_ptr[0] == nil then
        return nil
    end

    local ok, id = pcall(function()
        return tonumber(ffi.cast('uint32_t', texture_ptr[0]))
    end)

    if not ok or not id then
        return nil
    end

    logo_texture_id = id
    return logo_texture_id
end

function M.draw_centered_logo()
    local tex_id = try_load_logo_texture()
    if not tex_id then
        imgui.TextWrapped('Unable to load logo image from assets/logo.png')
        return
    end

    local available_width, available_height = imgui.GetContentRegionAvail()
    local draw_width = math.min(LOGO_DRAW_WIDTH, available_width)
    local draw_height = LOGO_DRAW_HEIGHT * (draw_width / LOGO_DRAW_WIDTH)
    local cursor_x = imgui.GetCursorPosX()
    local cursor_y = imgui.GetCursorPosY()
    local indent_x = math.max(0, (available_width - draw_width) / 2)
    local indent_y = math.max(0, (available_height - draw_height) / 2)

    imgui.SetCursorPosX(cursor_x + indent_x)
    imgui.SetCursorPosY(cursor_y + indent_y)
    imgui.Image(tex_id, { draw_width, draw_height }, { 0, 0 }, { 1, 1 }, { 1, 1, 1, 1 }, { 0, 0, 0, 0 })
end

function M.push_theme()
    local color_count = 0
    local var_count = 0

    local function push_color(col, value)
        imgui.PushStyleColor(col, value)
        color_count = color_count + 1
    end

    local function push_var(style_var, value)
        imgui.PushStyleVar(style_var, value)
        var_count = var_count + 1
    end

    local gold = {0.957, 0.855, 0.592, 1.0}
    local gold_dark = {0.765, 0.684, 0.474, 1.0}
    local gold_darker = {0.573, 0.512, 0.355, 1.0}
    local bg_dark = {0.0, 0.0, 0.0, 1.0}
    local bg_medium = {0.098, 0.090, 0.075, 1.0}
    local bg_light = {0.137, 0.125, 0.106, 1.0}
    local bg_lighter = {0.176, 0.161, 0.137, 1.0}
    local text_light = {0.878, 0.855, 0.812, 1.0}
    local border_dark = {0.3, 0.275, 0.235, 1.0}
    local border_gold = {gold_dark[1], gold_dark[2], gold_dark[3], 0.85}
    local button_base = {0.176, 0.149, 0.106, 0.95}
    local button_hover = {0.286, 0.239, 0.165, 0.95}
    local button_active = {0.420, 0.353, 0.243, 0.95}

    push_color(ImGuiCol_WindowBg, bg_dark)
    push_color(ImGuiCol_ChildBg, {0.0, 0.0, 0.0, 1.0})
    push_color(ImGuiCol_TitleBg, bg_medium)
    push_color(ImGuiCol_TitleBgActive, bg_light)
    push_color(ImGuiCol_TitleBgCollapsed, bg_dark)
    push_color(ImGuiCol_FrameBg, {0.125, 0.110, 0.086, 0.98})
    push_color(ImGuiCol_FrameBgHovered, {0.173, 0.153, 0.122, 0.98})
    push_color(ImGuiCol_FrameBgActive, {0.231, 0.200, 0.157, 0.98})
    push_color(ImGuiCol_Header, bg_light)
    push_color(ImGuiCol_HeaderHovered, bg_lighter)
    push_color(ImGuiCol_HeaderActive, {gold[1], gold[2], gold[3], 0.3})
    push_color(ImGuiCol_Border, border_gold)
    push_color(ImGuiCol_Text, text_light)
    push_color(ImGuiCol_TextDisabled, gold_dark)
    push_color(ImGuiCol_Button, button_base)
    push_color(ImGuiCol_ButtonHovered, button_hover)
    push_color(ImGuiCol_ButtonActive, button_active)
    push_color(ImGuiCol_CheckMark, gold)
    push_color(ImGuiCol_SliderGrab, gold_dark)
    push_color(ImGuiCol_SliderGrabActive, gold)
    push_color(ImGuiCol_ScrollbarBg, bg_medium)
    push_color(ImGuiCol_ScrollbarGrab, bg_lighter)
    push_color(ImGuiCol_ScrollbarGrabHovered, border_dark)
    push_color(ImGuiCol_ScrollbarGrabActive, gold_dark)
    push_color(ImGuiCol_Separator, border_dark)
    push_color(ImGuiCol_PopupBg, bg_medium)
    push_color(ImGuiCol_ResizeGrip, gold_darker)
    push_color(ImGuiCol_ResizeGripHovered, gold_dark)
    push_color(ImGuiCol_ResizeGripActive, gold)

    push_var(ImGuiStyleVar_WindowPadding, {12, 12})
    push_var(ImGuiStyleVar_FramePadding, {8, 6})
    push_var(ImGuiStyleVar_ItemSpacing, {8, 7})
    push_var(ImGuiStyleVar_FrameRounding, 4.0)
    push_var(ImGuiStyleVar_WindowRounding, 6.0)
    push_var(ImGuiStyleVar_ChildRounding, 4.0)
    push_var(ImGuiStyleVar_PopupRounding, 4.0)
    push_var(ImGuiStyleVar_ScrollbarRounding, 4.0)
    push_var(ImGuiStyleVar_GrabRounding, 4.0)
    push_var(ImGuiStyleVar_WindowBorderSize, 1.0)
    push_var(ImGuiStyleVar_ChildBorderSize, 1.0)
    push_var(ImGuiStyleVar_FrameBorderSize, 1.0)

    return color_count, var_count
end

return M