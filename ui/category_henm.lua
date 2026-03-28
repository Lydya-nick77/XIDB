local imgui = require('imgui')
local fonts = require('fonts')
local henm_data = require('henm.henm_data')

local M = {}

local function draw_wrapped_unformatted(text, color)
    imgui.PushStyleColor(ImGuiCol_Text, color or fonts.COLORS.LIGHT_GRAY)
    imgui.PushTextWrapPos(0)
    imgui.TextUnformatted(tostring(text or ''))
    imgui.PopTextWrapPos()
    imgui.PopStyleColor(1)
end

-- Helper: Get all HENMs for a given tier
local function get_henms_by_tier(tier_name)
    local henms = {}
    if tier_name and tier_name ~= '' and tier_name ~= 'Select Sub Category' then
        for _, henm in ipairs(henm_data.henm_list) do
            if henm.tier and henm.tier:lower() == tier_name:lower() then
                table.insert(henms, henm)
            end
        end
        -- Sort alphabetically by name
        table.sort(henms, function(a, b)
            return a.name:lower() < b.name:lower()
        end)
    end
    return henms
end

-- Helper: Search HENMs by name (partial, case-insensitive)
local function search_henms_by_name(query)
    local results = {}
    local q = query:lower():match('^%s*(.-)%s*$') or ''
    if q == '' then return results end
    for _, henm in ipairs(henm_data.henm_list) do
        if henm.name:lower():find(q, 1, true) then
            table.insert(results, henm)
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

    -- Determine if a tier is selected
    local tier_selected = (
        state.selected_subcategory_index > 1
        and current_subcat ~= ''
        and current_subcat ~= 'Select Sub Category'
    )

    -- Initialize search state
    if not state.henm_search_buf then
        state.henm_search_buf = { '' }
    end
    if not state.henm_search_results then
        state.henm_search_results = nil  -- nil = not in search mode
    end

    -- Get HENMs for the selected tier (or search results)
    local tier_henms
    local in_search_mode = (state.henm_search_results ~= nil)
    if in_search_mode then
        tier_henms = state.henm_search_results
    else
        tier_henms = tier_selected and get_henms_by_tier(current_subcat) or {}
    end

    -- Initialize selected_henm_index if needed
    if not state.selected_henm_index then
        state.selected_henm_index = 0
    end

    -- Ensure selected_henm_index is valid
    if state.selected_henm_index < 0 or state.selected_henm_index > #tier_henms then
        state.selected_henm_index = 0
    end

    -- Get the currently selected HENM
    local selected_henm = nil
    if state.selected_henm_index > 0 and state.selected_henm_index <= #tier_henms then
        selected_henm = tier_henms[state.selected_henm_index]
    end

    local function run_henm_search(query)
        local results = search_henms_by_name(query)
        state.henm_search_results = results
        state.selected_henm_index = (#results == 1) and 1 or 0
    end

    -- ============== SEARCH BAR ==============
    fonts.WithFont(18, function()
        imgui.SetNextItemWidth(-160)
        if imgui.InputText('##xidb_henm_search', state.henm_search_buf, 128, ImGuiInputTextFlags_EnterReturnsTrue) then
            local q = state.henm_search_buf[1] or ''
            if q:match('^%s*(.-)%s*$') ~= '' then
                run_henm_search(q)
            else
                state.henm_search_results = nil
                state.selected_henm_index = 0
            end
        end
        imgui.SameLine()
        if imgui.Button('Search##xidb_henm_search_btn') then
            local q = state.henm_search_buf[1] or ''
            if q:match('^%s*(.-)%s*$') ~= '' then
                run_henm_search(q)
            end
        end
        imgui.SameLine()
        if imgui.Button('Clear##xidb_henm_search_clear') then
            state.henm_search_buf[1] = ''
            state.henm_search_results = nil
            state.selected_henm_index = 0
        end
    end)
    imgui.Spacing()

    -- ============== LEFT PANE: HENM List ==============
    imgui.BeginChild('xidb_henm_list', { 260, -1 }, true)
        if in_search_mode then
            fonts.Title('Search Results')
        else
            fonts.Title('HENMs in Tier')
        end
        imgui.Separator()

        if in_search_mode then
            if #tier_henms == 0 then
                fonts.TextWrappedPx(
                    'No HENMs found matching your search.',
                    fonts.COLORS.GRAY, 18, fonts.SCALES.LARGE
                )
            else
                fonts.WithFont(18, function()
                    for i, henm in ipairs(tier_henms) do
                        local is_selected = (state.selected_henm_index == i)
                        if imgui.Selectable(henm.name, is_selected) then
                            state.selected_henm_index = i
                        end
                        if is_selected then
                            imgui.SetItemDefaultFocus()
                        end
                    end
                end)
            end
        elseif not tier_selected then
            fonts.TextWrappedPx(
                'Select a tier from the Sub Category dropdown above.',
                fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE
            )
        elseif #tier_henms == 0 then
            fonts.TextWrappedPx(
                'No HENMs found in this tier.',
                fonts.COLORS.GRAY, 18, fonts.SCALES.LARGE
            )
        else
            fonts.WithFont(18, function()
                for i, henm in ipairs(tier_henms) do
                    local is_selected = (state.selected_henm_index == i)
                    if imgui.Selectable(henm.name, is_selected) then
                        state.selected_henm_index = i
                    end
                    if is_selected then
                        imgui.SetItemDefaultFocus()
                    end
                end
            end)
        end
    imgui.EndChild()

    imgui.SameLine()

    -- ============== RIGHT PANE: HENM Details ==============
    imgui.BeginChild('xidb_henm_details', { 0, -1 }, true)
        if not tier_selected and not in_search_mode then
            fonts.Title('Hyper Empty Notorious Monsters')
            imgui.Separator()
            imgui.Spacing()

            fonts.WithFont(18, function()
                draw_wrapped_unformatted(
                    'Hyper Empty Notorious Monster or HENM as it\'s more commonly referred to, is a custom HorizonXI tiered endgame content system with HorizonXI specific changes. Adventurers will face increasingly difficult fights as they progress through the tiers and can expect to be rewarded with brand new era+ equipment, crafting items and even ancient currency. Tier one released with the 1.2.1 patch in November 2023. Tier two released with the 1.2.2 patch in June 2024. Tier three is scheduled to be released as part of Treasures of Aht Urhgan\'s 2.1 patch.',
                    fonts.COLORS.LIGHT_GRAY
                )
                imgui.Spacing()

                draw_wrapped_unformatted('How Does it Work', fonts.COLORS.WHITE)
                imgui.Spacing()
                draw_wrapped_unformatted(
                    'To begin, adventurers must first visit Shady Tonberry in Rabao (E-7) and purchase the tier one pop item Faded Stone. A full alliance of 18 players may participate in each battle and only one member must possess a pop item. These can be taken to the various ???\'s found throughout Vana\'diel to begin the HENM fight. Adventurers will be granted the Confrontation status effect for the duration of the fight. Any players outside of the alliance without the Confrontation status cannot assist or participate in the fight. If a fight ends in failure, the group must purchase another pop item from Shady Tonberry. There is no limit to the amount of attempts players can make.',
                    fonts.COLORS.LIGHT_GRAY
                )
                imgui.Spacing()
                draw_wrapped_unformatted(
                    'Once a player has cleared a tier one HENM, they will become eligible to purchase a tier two pop item from Shady Tonberry. A single tier one and a single tier two clear will be required for players to be eligible for tier three when it releases. A player must be able to roll on the rewards from a HENM battle to be considered "cleared". Certain conditions must be met:',
                    fonts.COLORS.LIGHT_GRAY
                )
                imgui.Spacing()
                draw_wrapped_unformatted('  * Adventurers invited after the fight has begun will not be eligible to cast lots on loot.', fonts.COLORS.LIGHT_GRAY)
                draw_wrapped_unformatted('  * If an Adventurer disconnects, they must click the same ??? used to pop the HENM to regain Confrontation Status. They may gain the weakness status effect upon clicking ???.', fonts.COLORS.LIGHT_GRAY)
                draw_wrapped_unformatted('  * Once cleared, a player is on "loot lockout" for that tier. This does not prevent purchasing further pop items and assisting others.', fonts.COLORS.LIGHT_GRAY)
                imgui.Spacing()
                draw_wrapped_unformatted(
                    'As of the 1.2.2 patch, HENM fights will lock out all Adventurers who are in the alliance at the start of each encounter if completed successfully, even if that player is no longer in the alliance, dead, or offline.',
                    fonts.COLORS.LIGHT_GRAY
                )
                imgui.Spacing()

                draw_wrapped_unformatted('Rewards & Loot Lockout', fonts.COLORS.WHITE)
                imgui.Spacing()
                draw_wrapped_unformatted(
                    'HENMs have a special "loot lockout" mechanic which resets with the weekly conquest tally. All players are eligible for loot and Cerulean Shards once per tier, per conquest tally. Alliances must ensure that the majority of group members are eligible for loot for the group to receive drops.',
                    fonts.COLORS.LIGHT_GRAY
                )
                imgui.Spacing()
                draw_wrapped_unformatted(
                    'Cerulean Shards are a currency used to purchase items from Shady Tonberry and will be used to upgrade HENM gear in future tiers.',
                    fonts.COLORS.LIGHT_GRAY
                )
                imgui.Spacing()
                draw_wrapped_unformatted('Cerulean Shards per clear:', fonts.COLORS.LIGHT_GRAY)
                draw_wrapped_unformatted('  Tier 1: 50 Cerulean Shards', fonts.COLORS.LIGHT_GRAY)
                draw_wrapped_unformatted('  Tier 2: 75 Cerulean Shards', fonts.COLORS.LIGHT_GRAY)
                draw_wrapped_unformatted('  Tier 3: TBC', fonts.COLORS.LIGHT_GRAY)
                draw_wrapped_unformatted('  Tier 4: TBC', fonts.COLORS.LIGHT_GRAY)
                imgui.Spacing()
                draw_wrapped_unformatted('Experience points are only granted on the first clear:', fonts.COLORS.LIGHT_GRAY)
                draw_wrapped_unformatted('  Tier 1: 2,500 exp', fonts.COLORS.LIGHT_GRAY)
                draw_wrapped_unformatted('  Tier 2: 3,750 exp', fonts.COLORS.LIGHT_GRAY)
                draw_wrapped_unformatted('  Tier 3: TBC', fonts.COLORS.LIGHT_GRAY)
                draw_wrapped_unformatted('  Tier 4: TBC', fonts.COLORS.LIGHT_GRAY)
                imgui.Spacing()
            end)
        elseif not selected_henm then
            fonts.Title(in_search_mode and 'Search Results' or current_subcat)
            imgui.Separator()
            imgui.Spacing()
            fonts.TextWrappedPx(
                'Select a HENM from the list on the left to view its details.',
                fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE
            )
        else
            -- Title: HENM name
            fonts.Title(selected_henm.name)
            imgui.Separator()
            imgui.Spacing()

            -- === Stats ===
            fonts.Header('Stats')
            imgui.Separator()
            imgui.Spacing()

            imgui.BeginGroup()
                fonts.Label('Level:')
                imgui.SameLine()
                fonts.Ingredient(selected_henm.level ~= '' and selected_henm.level or 'Unknown')

                fonts.Label('Tier:')
                imgui.SameLine()
                fonts.WithFont(18, function()
                    draw_wrapped_unformatted(selected_henm.tier ~= '' and selected_henm.tier or 'Unknown', fonts.COLORS.LIGHT_GRAY)
                end)

                fonts.Label('Area:')
                imgui.SameLine()
                fonts.WithFont(18, function()
                    draw_wrapped_unformatted(selected_henm.area ~= '' and selected_henm.area or 'Unknown', fonts.COLORS.LIGHT_GRAY)
                end)

                fonts.Label('Spawn Type:')
                imgui.SameLine()
                fonts.WithFont(18, function()
                    draw_wrapped_unformatted(selected_henm.spawn_type ~= '' and selected_henm.spawn_type or 'Unknown', fonts.COLORS.LIGHT_GRAY)
                end)

                if selected_henm.spawn_time and selected_henm.spawn_time ~= '' then
                    fonts.Label('Spawn Information:')
                    fonts.WithFont(18, function()
                        draw_wrapped_unformatted(selected_henm.spawn_time, fonts.COLORS.LIGHT_GRAY)
                    end)
                end
            imgui.EndGroup()

            imgui.Spacing()

            -- === Drops ===
            fonts.Header('Drops')
            imgui.Separator()
            imgui.Spacing()

            local drops = selected_henm.drops or {}
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
                        elseif dl:find('hard mode', 1, true) then
                            color = fonts.COLORS.ORANGE
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
                            local selectable_label = ('%s##xidb_henm_drop_%d_%s'):fmt(label, i, lookup_name)
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
            if selected_henm.other_conditions and selected_henm.other_conditions ~= '' then
                imgui.Spacing()
                fonts.Header('Notes & Strategy')
                imgui.Separator()
                imgui.Spacing()

                fonts.WithFont(18, function()
                    -- Split by | and render each bullet
                    for part in selected_henm.other_conditions:gmatch('[^|]+') do
                        local trimmed = part:match('^%s*(.-)%s*$')
                        if trimmed and trimmed ~= '' then
                            draw_wrapped_unformatted('  * ' .. trimmed, fonts.COLORS.LIGHT_GRAY)
                        end
                    end
                end)
            end
        end -- selected_henm
    imgui.EndChild()
end

return M
