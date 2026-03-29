local imgui = require('imgui')
local fonts = require('fonts')
local expcamps_data = require('expcamps.expcamps')

local M = {}
local find_level_band_index_by_label

local LEVEL_BANDS = {
    { label = '1-10', min = 1, max = 10 },
    { label = '11-20', min = 11, max = 20 },
    { label = '21-30', min = 21, max = 30 },
    { label = '31-40', min = 31, max = 40 },
    { label = '41-50', min = 41, max = 50 },
    { label = '51-60', min = 51, max = 60 },
    { label = '61-70', min = 61, max = 70 },
    { label = '71-75', min = 71, max = 75 },
}

local function get_available_band_indices(merit_only_mode)
    if merit_only_mode then
        return { find_level_band_index_by_label('71-75') }
    end

    local out = {}
    for i = 1, #LEVEL_BANDS do
        out[#out + 1] = i
    end
    return out
end

local function step_band_index(current_index, merit_only_mode, direction)
    local indices = get_available_band_indices(merit_only_mode)
    if #indices == 0 then
        return current_index
    end

    local current_pos = 1
    for i, index in ipairs(indices) do
        if index == current_index then
            current_pos = i
            break
        end
    end

    local next_pos = current_pos + (direction or 0)
    if next_pos < 1 then
        next_pos = 1
    elseif next_pos > #indices then
        next_pos = #indices
    end

    return indices[next_pos]
end

find_level_band_index_by_label = function(label)
    for i, band in ipairs(LEVEL_BANDS) do
        if band.label == label then
            return i
        end
    end
    return 1
end

local function draw_wrapped_unformatted(text, color)
    imgui.PushStyleColor(ImGuiCol_Text, color or fonts.COLORS.LIGHT_GRAY)
    imgui.PushTextWrapPos(0)
    imgui.TextUnformatted(tostring(text or ''))
    imgui.PopTextWrapPos()
    imgui.PopStyleColor(1)
end

local function to_list(value)
    if type(value) == 'table' then
        local out = {}
        for _, entry in ipairs(value) do
            local text = tostring(entry or ''):match('^%s*(.-)%s*$') or ''
            if text ~= '' then
                out[#out + 1] = text
            end
        end
        return out
    end

    local text = tostring(value or ''):match('^%s*(.-)%s*$') or ''
    if text == '' then
        return {}
    end

    return { text }
end

local function join_list(value)
    local list = to_list(value)
    if #list == 0 then
        return 'N/A'
    end

    return table.concat(list, '; ')
end

local function parse_level_span(level_range, camp_type)
    local level_text = tostring(level_range or '')
    local numbers = {}

    for n in level_text:gmatch('(%d+)') do
        numbers[#numbers + 1] = tonumber(n)
        if #numbers >= 2 then
            break
        end
    end

    local min_level = nil
    local max_level = nil

    if #numbers >= 2 then
        min_level = numbers[1]
        max_level = numbers[2]
    elseif #numbers == 1 then
        min_level = numbers[1]
        max_level = numbers[1]
    else
        local camp_type_text = tostring(camp_type or ''):lower()
        if camp_type_text == 'merit camp' then
            min_level = 71
            max_level = 75
        end
    end

    if min_level == nil or max_level == nil then
        return nil, nil
    end

    if max_level < min_level then
        min_level, max_level = max_level, min_level
    end

    if level_text:find('%+') then
        max_level = 75
    end

    if min_level < 1 then
        min_level = 1
    end
    if max_level > 75 then
        max_level = 75
    end

    return min_level, max_level
end

local function camp_matches_filters(camp, selected_type, band)
    local camp_type = tostring(camp.camp_type or '')
    if selected_type == nil or selected_type == '' or selected_type == 'Select Sub Category' then
        return false
    end

    if camp_type:lower() ~= selected_type:lower() then
        return false
    end

    local min_level, max_level = parse_level_span(camp.level_range, camp.camp_type)
    if min_level == nil or max_level == nil then
        return false
    end

    return not (max_level < band.min or min_level > band.max)
end

local function get_filtered_camps(selected_type, band)
    local results = {}

    for _, camp in ipairs(expcamps_data or {}) do
        if camp_matches_filters(camp, selected_type, band) then
            results[#results + 1] = camp
        end
    end

    table.sort(results, function(a, b)
        local amin = select(1, parse_level_span(a.level_range, a.camp_type)) or 999
        local bmin = select(1, parse_level_span(b.level_range, b.camp_type)) or 999
        if amin ~= bmin then
            return amin < bmin
        end

        local az = tostring(a.zone or ''):lower()
        local bz = tostring(b.zone or ''):lower()
        if az ~= bz then
            return az < bz
        end

        local al = join_list(a.camp_location):lower()
        local bl = join_list(b.camp_location):lower()
        return al < bl
    end)

    return results
end

function M.render(ctx)
    local state = ctx.state
    local subcats = ctx.subcategories[state.selected_module_index] or { 'Select Sub Category' }
    local current_subcat = subcats[state.selected_subcategory_index] or subcats[1]
    local merit_only_mode = (tostring(current_subcat or ''):lower() == 'merit camp')
    local merit_band_index = find_level_band_index_by_label('71-75')

    if not state.selected_expcamp_band_index then
        state.selected_expcamp_band_index = 1
    end

    if state.selected_expcamp_band_index < 1 or state.selected_expcamp_band_index > #LEVEL_BANDS then
        state.selected_expcamp_band_index = 1
    end

    if merit_only_mode then
        state.selected_expcamp_band_index = merit_band_index
    end

    local selected_band = LEVEL_BANDS[state.selected_expcamp_band_index]

    imgui.BeginChild('xidb_expcamps_levels', { 200, -1 }, true)
        fonts.Title('Filters')
        imgui.Separator()

        fonts.Header('Level Range')
        imgui.SetNextItemWidth(-1)
        fonts.WithFont(18, function()
            if imgui.BeginCombo('##xidb_expcamps_band_combo', selected_band.label, ImGuiComboFlags_None) then
                for _, i in ipairs(get_available_band_indices(merit_only_mode)) do
                    local band = LEVEL_BANDS[i]
                    local count = 0
                    if current_subcat ~= 'Select Sub Category' then
                        count = #get_filtered_camps(current_subcat, band)
                    end

                    local item_label = ('%s (%d)'):format(band.label, count)
                    local is_selected = (state.selected_expcamp_band_index == i)
                    if imgui.Selectable(item_label, is_selected) then
                        state.selected_expcamp_band_index = i
                    end
                    if is_selected then
                        imgui.SetItemDefaultFocus()
                    end
                end
                imgui.EndCombo()
            end
        end)

        local can_go_prev = (step_band_index(state.selected_expcamp_band_index, merit_only_mode, -1) ~= state.selected_expcamp_band_index)
        local can_go_next = (step_band_index(state.selected_expcamp_band_index, merit_only_mode, 1) ~= state.selected_expcamp_band_index)

        if can_go_prev then
            if imgui.Button('Prev Band') then
                state.selected_expcamp_band_index = step_band_index(state.selected_expcamp_band_index, merit_only_mode, -1)
            end
        else
            imgui.PushStyleColor(ImGuiCol_Button, { 0.20, 0.20, 0.20, 0.50 })
            imgui.PushStyleColor(ImGuiCol_ButtonHovered, { 0.20, 0.20, 0.20, 0.50 })
            imgui.PushStyleColor(ImGuiCol_ButtonActive, { 0.20, 0.20, 0.20, 0.50 })
            imgui.Button('Prev Band')
            imgui.PopStyleColor(3)
        end
        imgui.SameLine()
        if can_go_next then
            if imgui.Button('Next Band') then
                state.selected_expcamp_band_index = step_band_index(state.selected_expcamp_band_index, merit_only_mode, 1)
            end
        else
            imgui.PushStyleColor(ImGuiCol_Button, { 0.20, 0.20, 0.20, 0.50 })
            imgui.PushStyleColor(ImGuiCol_ButtonHovered, { 0.20, 0.20, 0.20, 0.50 })
            imgui.PushStyleColor(ImGuiCol_ButtonActive, { 0.20, 0.20, 0.20, 0.50 })
            imgui.Button('Next Band')
            imgui.PopStyleColor(3)
        end

    imgui.EndChild()

    imgui.SameLine()

    imgui.BeginChild('xidb_expcamps_list', { 0, -1 }, true)
        if current_subcat == 'Select Sub Category' then
            fonts.Title('EXP Camps')
            imgui.Separator()
            imgui.Spacing()
            fonts.TextWrappedPx(
                'Select a camp type from the Sub Category dropdown above. '
                .. 'Then pick a level band on the left to list camps on the right.',
                fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE
            )
        else
            local camps = get_filtered_camps(current_subcat, selected_band)
            fonts.Title(('%s | %s'):format(current_subcat, selected_band.label))
            imgui.Separator()

            if #camps == 0 then
                imgui.Spacing()
                fonts.TextWrappedPx(
                    'No camps found for this camp type and level range.',
                    fonts.COLORS.GRAY, 18, fonts.SCALES.LARGE
                )
            else
                for i, camp in ipairs(camps) do
                    local level_text = tostring(camp.level_range or '')
                    if level_text == '' then
                        level_text = 'N/A'
                    end

                    local camp_type_text = tostring(camp.camp_type or ''):lower()
                    local show_level = (camp_type_text ~= 'merit camp')

                    local header_text = nil
                    if show_level then
                        header_text = ('%d. [%s] %s'):format(i, level_text, tostring(camp.zone or 'Unknown Zone'))
                    else
                        header_text = ('%d. %s'):format(i, tostring(camp.zone or 'Unknown Zone'))
                    end

                    local collapsible_label = ('%s##xidb_expcamp_%d'):format(header_text, i)
                    fonts.WithFont(18, function()
                        if imgui.CollapsingHeader(collapsible_label) then
                            draw_wrapped_unformatted('Camp: ' .. join_list(camp.camp_location), fonts.COLORS.LIGHT_GRAY)
                            draw_wrapped_unformatted('Mobs: ' .. join_list(camp.mobs), fonts.COLORS.LIGHT_GRAY)

                            local notes = tostring(camp.notes or ''):match('^%s*(.-)%s*$') or ''
                            if notes ~= '' then
                                draw_wrapped_unformatted('Notes: ' .. notes, fonts.COLORS.GRAY)
                            end

                            imgui.Separator()
                        end
                    end)
                end
            end
        end
    imgui.EndChild()
end

return M
