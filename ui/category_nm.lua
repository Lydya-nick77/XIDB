local imgui = require('imgui')
local fonts = require('fonts')
local nm_data = require('nms.nm_data')

local M = {}

local function draw_wrapped_unformatted(text, color)
    imgui.PushStyleColor(ImGuiCol_Text, color or fonts.COLORS.LIGHT_GRAY)
    imgui.PushTextWrapPos(0)
    imgui.TextUnformatted(tostring(text or ''))
    imgui.PopTextWrapPos()
    imgui.PopStyleColor(1)
end

-- Helper: Get all NMs for a given zone
local function get_nms_by_zone(zone_name)
    local nms = {}
    if zone_name and zone_name ~= '' and zone_name ~= 'Select Sub Category' then
        for _, nm in ipairs(nm_data.nm_list) do
            if nm.area and nm.area:lower() == zone_name:lower() then
                table.insert(nms, nm)
            end
        end
        -- Sort alphabetically by name
        table.sort(nms, function(a, b)
            return a.name:lower() < b.name:lower()
        end)
    end
    return nms
end

-- Helper: Search NMs by name (partial, case-insensitive)
local function search_nms_by_name(query)
    local results = {}
    local q = query:lower():match('^%s*(.-)%s*$') or ''
    if q == '' then return results end
    for _, nm in ipairs(nm_data.nm_list) do
        if nm.name:lower():find(q, 1, true) then
            table.insert(results, nm)
        end
    end
    table.sort(results, function(a, b)
        return a.name:lower() < b.name:lower()
    end)
    return results
end

local function drop_to_lookup_name(ctx, drop)
    local text = tostring(drop or '')
    if text == '' then
        return nil
    end

    -- Gil lines are not item entries.
    if text:lower():find('gil', 1, true) then
        return nil
    end

    -- Remove trailing drop-rate suffix, e.g. "(24%)" / "(???%)".
    text = text:gsub('%s*%b()%s*$', '')
    local lookup_name = ctx.ingredient_to_lookup_name(text)
    if lookup_name == '' then
        return nil
    end

    return lookup_name
end

function M.render(ctx, xidb, deps)
    local state = ctx.state
    local subcats = ctx.subcategories[state.selected_module_index] or { 'Select Sub Category' }
    local current_subcat = subcats[state.selected_subcategory_index] or subcats[1]

    -- Determine if a zone is selected
    local zone_selected = (
        state.selected_subcategory_index > 1
        and current_subcat ~= ''
        and current_subcat ~= 'Select Sub Category'
    )

    -- Initialize search state
    if not state.nm_search_buf then
        state.nm_search_buf = { '' }
    end
    if not state.nm_search_results then
        state.nm_search_results = nil  -- nil = not in search mode
    end

    -- Get NMs for the selected zone (or search results)
    local zone_nms
    local in_search_mode = (state.nm_search_results ~= nil)
    if in_search_mode then
        zone_nms = state.nm_search_results
    else
        zone_nms = zone_selected and get_nms_by_zone(current_subcat) or {}
    end

    -- Initialize selected_nm_index if needed
    if not state.selected_nm_index then
        state.selected_nm_index = 0
    end

    -- Ensure selected_nm_index is valid
    if state.selected_nm_index < 0 or state.selected_nm_index > #zone_nms then
        state.selected_nm_index = 0
    end

    -- Get the currently selected NM
    local selected_nm = nil
    if state.selected_nm_index > 0 and state.selected_nm_index <= #zone_nms then
        selected_nm = zone_nms[state.selected_nm_index]
    end

    local function run_nm_search(query)
        local results = search_nms_by_name(query)
        state.nm_search_results = results
        state.selected_nm_index = (#results == 1) and 1 or 0
    end

    -- ============== SEARCH BAR ==============
    fonts.WithFont(18, function()
        imgui.SetNextItemWidth(-160)
        if imgui.InputText('##xidb_nm_search', state.nm_search_buf, 128, ImGuiInputTextFlags_EnterReturnsTrue) then
            local q = state.nm_search_buf[1] or ''
            if q:match('^%s*(.-)%s*$') ~= '' then
                run_nm_search(q)
            else
                state.nm_search_results = nil
                state.selected_nm_index = 0
            end
        end
        imgui.SameLine()
        if imgui.Button('Search##xidb_nm_search_btn') then
            local q = state.nm_search_buf[1] or ''
            if q:match('^%s*(.-)%s*$') ~= '' then
                run_nm_search(q)
            end
        end
        imgui.SameLine()
        if imgui.Button('Clear##xidb_nm_search_clear') then
            state.nm_search_buf[1] = ''
            state.nm_search_results = nil
            state.selected_nm_index = 0
        end
    end)
    imgui.Spacing()

    -- ============== LEFT PANE: NM List ==============
    imgui.BeginChild('xidb_nm_list', { 260, -1 }, true)
        if in_search_mode then
            fonts.Title('Search Results')
        else
            fonts.Title('NMs in Zone')
        end
        imgui.Separator()

        if in_search_mode then
            if #zone_nms == 0 then
                fonts.TextWrappedPx(
                    'No NMs found matching your search.',
                    fonts.COLORS.GRAY, 18, fonts.SCALES.LARGE
                )
            else
                fonts.WithFont(18, function()
                    for i, nm in ipairs(zone_nms) do
                        local is_selected = (state.selected_nm_index == i)
                        if imgui.Selectable(nm.name, is_selected) then
                            state.selected_nm_index = i
                        end
                        if is_selected then
                            imgui.SetItemDefaultFocus()
                        end
                    end
                end)
            end
        elseif not zone_selected then
            fonts.TextWrappedPx(
                'Select a zone from the Sub Category dropdown above.',
                fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE
            )
        elseif #zone_nms == 0 then
            fonts.TextWrappedPx(
                'No NMs found in this zone.',
                fonts.COLORS.GRAY, 18, fonts.SCALES.LARGE
            )
        else
            fonts.WithFont(18, function()
                for i, nm in ipairs(zone_nms) do
                    local is_selected = (state.selected_nm_index == i)
                    if imgui.Selectable(nm.name, is_selected) then
                        state.selected_nm_index = i
                    end
                    if is_selected then
                        imgui.SetItemDefaultFocus()
                    end
                end
            end)
        end
    imgui.EndChild()

    imgui.SameLine()

    -- ============== RIGHT PANE: NM Details ==============
    imgui.BeginChild('xidb_nm_details', { 0, -1 }, true)
        if not zone_selected and not in_search_mode then
            fonts.Title('Notorious Monsters')
            imgui.Separator()
            imgui.Spacing()
            fonts.TextWrappedPx(
                'Select a zone from the Sub Category dropdown, or search for an NM by name above. '
                .. 'All NMs in the selected zone will be listed in the left panel. '
                .. 'Select an NM to view its details including level, area, spawn type, spawn window, '
                .. 'all known drops with drop rates, and any additional notes.',
                fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE
            )
        elseif not selected_nm then
            fonts.Title(in_search_mode and 'Search Results' or current_subcat)
            imgui.Separator()
            imgui.Spacing()
            fonts.TextWrappedPx(
                'Select an NM from the list on the left to view its details.',
                fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE
            )
        else
            -- Title: NM name
            fonts.Title(selected_nm.name)
            imgui.Separator()
            imgui.Spacing()

            -- === Stats ===
            fonts.Header('Stats')
            imgui.Separator()
            imgui.Spacing()

            imgui.BeginGroup()
                fonts.Label('Level:')
                imgui.SameLine()
                fonts.Ingredient(selected_nm.level ~= '' and selected_nm.level or 'Unknown')

                fonts.Label('Area:')
                imgui.SameLine()
                fonts.WithFont(18, function()
                    draw_wrapped_unformatted(selected_nm.area ~= '' and selected_nm.area or 'Unknown', fonts.COLORS.LIGHT_GRAY)
                end)

                fonts.Label('Spawn Type:')
                imgui.SameLine()
                fonts.WithFont(18, function()
                    draw_wrapped_unformatted(selected_nm.spawn_type ~= '' and selected_nm.spawn_type or 'Unknown', fonts.COLORS.LIGHT_GRAY)
                end)

                if selected_nm.spawn_time and selected_nm.spawn_time ~= '' then
                    fonts.Label('Spawn Window:')
                    fonts.WithFont(18, function()
                        draw_wrapped_unformatted(selected_nm.spawn_time, fonts.COLORS.LIGHT_GRAY)
                    end)
                end
            imgui.EndGroup()

            imgui.Spacing()

            -- === Drops ===
            fonts.Header('Drops')
            imgui.Separator()
            imgui.Spacing()

            local drops = selected_nm.drops or {}
            if #drops == 0 then
                fonts.Label('No drops recorded.')
            else
                fonts.WithFont(18, function()
                    for i, drop in ipairs(drops) do
                        -- Color-code by drop rate hint
                        local color = fonts.COLORS.LIGHT_GRAY
                        local dl = drop:lower()
                        if dl:find('100%%') then
                            color = fonts.COLORS.GREEN
                        elseif dl:find('gil') then
                            color = fonts.COLORS.GOLD
                        elseif dl:find('%?%%') or dl:find('%?%?%?') then
                            color = fonts.COLORS.ORANGE
                        end

                        local label = ('  %d. %s'):fmt(i, drop)
                        local lookup_name = drop_to_lookup_name(ctx, drop)
                        local drop_item_id = nil
                        if lookup_name ~= nil then
                            drop_item_id = ctx.find_item_id_by_name(xidb, lookup_name)
                        end

                        imgui.PushStyleColor(ImGuiCol_Text, color)
                        if drop_item_id ~= nil then
                            local selectable_label = ('%s##xidb_nm_drop_%d_%s'):fmt(label, i, lookup_name)
                            if imgui.Selectable(selectable_label, false) then
                                state.selected_module_index = ctx.module_index.ITEMS
                                state.selected_subcategory_index = 1
                                deps.set_filter(lookup_name)
                                deps.select_item(drop_item_id)
                                ctx.update_details_cache(xidb, deps)
                            end
                        else
                            imgui.TextUnformatted(label)
                        end
                        imgui.PopStyleColor(1)
                    end
                end)
            end

            -- === Notes & Conditions ===
            if selected_nm.other_conditions and selected_nm.other_conditions ~= '' then
                imgui.Spacing()
                fonts.Header('Notes & Conditions')
                imgui.Separator()
                imgui.Spacing()

                fonts.WithFont(18, function()
                    -- Split by | and render each bullet
                    for part in selected_nm.other_conditions:gmatch('[^|]+') do
                        local trimmed = part:match('^%s*(.-)%s*$')
                        if trimmed and trimmed ~= '' then
                            draw_wrapped_unformatted('  * ' .. trimmed, fonts.COLORS.LIGHT_GRAY)
                        end
                    end
                end)
            end
        end -- selected_nm
    imgui.EndChild()
end

return M
