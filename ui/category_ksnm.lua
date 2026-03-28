local imgui = require('imgui')
local fonts = require('fonts')
local ksnm_data = require('ksnm.ksnm_data')

local M = {}

local function draw_wrapped_unformatted(text, color)
    imgui.PushStyleColor(ImGuiCol_Text, color or fonts.COLORS.LIGHT_GRAY)
    imgui.PushTextWrapPos(0)
    imgui.TextUnformatted(tostring(text or ''))
    imgui.PopTextWrapPos()
    imgui.PopStyleColor(1)
end

local function get_ksnms_by_level(level_text)
    local ksnms = {}
    if level_text and level_text ~= '' and level_text ~= 'Select Sub Category' then
        for _, ksnm in ipairs(ksnm_data.ksnm_list or {}) do
            if tostring(ksnm.level or ''):lower() == level_text:lower() then
                table.insert(ksnms, ksnm)
            end
        end
        table.sort(ksnms, function(a, b)
            return tostring(a.name or ''):lower() < tostring(b.name or ''):lower()
        end)
    end
    return ksnms
end

local function normalize_item_name(text)
    local s = tostring(text or '')
    if s == '' then
        return nil
    end

    if s:lower():find('gil', 1, true) then
        return nil
    end

    s = s:gsub('%s*%b()%s*$', '')
    s = s:gsub('^HorizonXI specific changes%s*', '')
    s = s:gsub('^adjusted stats%s*', '')
    s = s:gsub('^Scroll of%s+', '')
    s = s:gsub('^%s*(.-)%s*$', '%1')

    if s == '' then
        return nil
    end

    return s
end

local function render_reward_group_column(ctx, xidb, deps, state, reward_group, group_index, tag_prefix)
    local group_name = tostring(reward_group.group or ('Group ' .. tostring(group_index)))
    fonts.WithFont(18, function()
        draw_wrapped_unformatted(group_name, fonts.COLORS.WHITE)
    end)

    local items = reward_group.items or {}
    if #items == 0 then
        draw_wrapped_unformatted('  * No items listed', fonts.COLORS.GRAY)
        return
    end

    fonts.WithFont(18, function()
        for item_index, reward_item in ipairs(items) do
            local item_text = tostring(reward_item or '')
            local lookup_name = normalize_item_name(item_text)
            local item_id = nil
            if lookup_name ~= nil then
                item_id = ctx.find_item_id_by_name(xidb, lookup_name)
            end

            imgui.PushStyleColor(ImGuiCol_Text, fonts.COLORS.LIGHT_GRAY)
            if item_id ~= nil then
                local label = ('  * %s##%s_reward_%d_%d_%s'):format(item_text, tag_prefix, group_index, item_index, lookup_name)
                if imgui.Selectable(label, false) then
                    state.selected_module_index = ctx.module_index.ITEMS
                    state.selected_subcategory_index = 1
                    deps.set_filter(lookup_name)
                    deps.select_item(item_id)
                    ctx.update_details_cache(xidb, deps)
                end
            else
                draw_wrapped_unformatted('  * ' .. item_text, fonts.COLORS.LIGHT_GRAY)
            end
            imgui.PopStyleColor(1)
        end
    end)
end

function M.render(ctx, xidb, deps)
    local state = ctx.state
    local subcats = ctx.subcategories[state.selected_module_index] or { 'Select Sub Category' }
    local current_subcat = subcats[state.selected_subcategory_index] or subcats[1]

    local level_selected = (
        state.selected_subcategory_index > 1
        and current_subcat ~= ''
        and current_subcat ~= 'Select Sub Category'
    )

    local level_ksnms = level_selected and get_ksnms_by_level(current_subcat) or {}

    if not state.selected_ksnm_index then
        state.selected_ksnm_index = 0
    end

    if state.selected_ksnm_index < 0 or state.selected_ksnm_index > #level_ksnms then
        state.selected_ksnm_index = 0
    end

    local selected_ksnm = nil
    if state.selected_ksnm_index > 0 and state.selected_ksnm_index <= #level_ksnms then
        selected_ksnm = level_ksnms[state.selected_ksnm_index]
    end

    imgui.BeginChild('xidb_ksnm_list', { 260, -1 }, true)
        fonts.Title('KSNMs by Level')
        imgui.Separator()

        if not level_selected then
            fonts.TextWrappedPx(
                'Select a level from the Sub Category dropdown above.',
                fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE
            )
        elseif #level_ksnms == 0 then
            fonts.TextWrappedPx(
                'No KSNMs found for this level.',
                fonts.COLORS.GRAY, 18, fonts.SCALES.LARGE
            )
        else
            fonts.WithFont(18, function()
                for i, ksnm in ipairs(level_ksnms) do
                    local is_selected = (state.selected_ksnm_index == i)
                    if imgui.Selectable(ksnm.name, is_selected) then
                        state.selected_ksnm_index = i
                    end
                    if is_selected then
                        imgui.SetItemDefaultFocus()
                    end
                end
            end)
        end
    imgui.EndChild()

    imgui.SameLine()

    imgui.BeginChild('xidb_ksnm_details', { 0, -1 }, true)
        if not level_selected then
            fonts.Title('Kindred Seal Notorious Monsters')
            imgui.Separator()
            imgui.Spacing()
            fonts.WithFont(18, function()
                draw_wrapped_unformatted(
                    'Kindred Seal Notorious Monster (KSNM) events are a special type of arena battle in which adventurers fight a specific mob or group of mobs. These events are accessed by trading a specific orb to the entrance of a Burning Circle. These orbs can be obtained by trading Kindred\'s Seals to Shami in Port Jeuno (H-8).',
                    fonts.COLORS.LIGHT_GRAY
                )
                imgui.Spacing()

                draw_wrapped_unformatted('Notes', fonts.COLORS.WHITE)
                imgui.Spacing()
                draw_wrapped_unformatted('  * Only one person needs an orb to enter the battle.', fonts.COLORS.LIGHT_GRAY)
                draw_wrapped_unformatted('  * Unlike BCNMs, there are no level restrictions placed upon players.', fonts.COLORS.LIGHT_GRAY)
                draw_wrapped_unformatted('  * Food does not wear off upon entering.', fonts.COLORS.LIGHT_GRAY)
                draw_wrapped_unformatted('  * In the event of a K.O., all TP accumulated is reset to zero within a KSNM.', fonts.COLORS.LIGHT_GRAY)
                draw_wrapped_unformatted('  * In the event of a party wipe, the party has 3 minutes to reraise or all members get kicked out.', fonts.COLORS.LIGHT_GRAY)
                imgui.Spacing()

                draw_wrapped_unformatted('Horizon Changes', fonts.COLORS.WHITE)
                imgui.Spacing()
                draw_wrapped_unformatted('  * None', fonts.COLORS.LIGHT_GRAY)
                imgui.Spacing()
            end)
        elseif not selected_ksnm then
            fonts.Title('Level ' .. tostring(current_subcat))
            imgui.Separator()
            imgui.Spacing()
            fonts.TextWrappedPx(
                'Select a KSNM from the list on the left to view its details.',
                fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE
            )
        else
            fonts.Title(selected_ksnm.name or 'KSNM')
            imgui.Separator()
            imgui.Spacing()

            fonts.Header('Encounter')
            imgui.Separator()
            imgui.Spacing()

            imgui.BeginGroup()
                fonts.Label('Level:')
                imgui.SameLine()
                fonts.WithFont(18, function()
                    draw_wrapped_unformatted(tostring(selected_ksnm.level or 'Unknown'), fonts.COLORS.WHITE)
                end)

                fonts.Label('Orb Required:')
                imgui.SameLine()
                fonts.WithFont(18, function()
                    draw_wrapped_unformatted(selected_ksnm.orb_required or 'Unknown', fonts.COLORS.WHITE)
                end)

                fonts.Label('Zone:')
                imgui.SameLine()
                fonts.WithFont(18, function()
                    draw_wrapped_unformatted(selected_ksnm.zone or 'Unknown', fonts.COLORS.WHITE)
                end)

                fonts.Label('Maximum Members:')
                imgui.SameLine()
                fonts.WithFont(18, function()
                    draw_wrapped_unformatted(selected_ksnm.max_members or 'Unknown', fonts.COLORS.WHITE)
                end)

                fonts.Label('Time Limit:')
                imgui.SameLine()
                fonts.WithFont(18, function()
                    draw_wrapped_unformatted(selected_ksnm.time_limit or 'Unknown', fonts.COLORS.WHITE)
                end)
            imgui.EndGroup()

            imgui.Spacing()
            fonts.Header('Mobs')
            imgui.Separator()
            imgui.Spacing()

            local mobs = selected_ksnm.mobs or {}
            if #mobs == 0 then
                fonts.Label('No mob data recorded.')
            else
                fonts.WithFont(18, function()
                    for i, mob in ipairs(mobs) do
                        draw_wrapped_unformatted(('  %d. %s'):format(i, mob.name or 'Unknown'), fonts.COLORS.WHITE)
                        draw_wrapped_unformatted(('      Level: %s | Job: %s | Type: %s'):format(
                            tostring(mob.level or 'Unknown'),
                            tostring(mob.job or 'Unknown'),
                            tostring(mob.type or 'Unknown')
                        ), fonts.COLORS.LIGHT_GRAY)
                    end
                end)
            end

            if selected_ksnm.note and selected_ksnm.note ~= '' then
                imgui.Spacing()
                fonts.Header('Note')
                imgui.Separator()
                imgui.Spacing()

                fonts.WithFont(18, function()
                    for part in tostring(selected_ksnm.note):gmatch('[^|]+') do
                        local trimmed = part:match('^%s*(.-)%s*$')
                        if trimmed and trimmed ~= '' then
                            draw_wrapped_unformatted('  * ' .. trimmed, fonts.COLORS.LIGHT_GRAY)
                        end
                    end
                end)
            end

            imgui.Spacing()
            fonts.Header('Rewards')
            imgui.Separator()
            imgui.Spacing()

            local rewards = selected_ksnm.rewards or {}
            if #rewards == 0 then
                fonts.Label('No reward data recorded.')
            else
                local left_groups = math.ceil(#rewards / 2)

                imgui.Columns(2, 'xidb_ksnm_rewards_columns', false)
                for group_index = 1, left_groups do
                    render_reward_group_column(ctx, xidb, deps, state, rewards[group_index], group_index, 'xidb_ksnm')
                    if group_index < left_groups then
                        imgui.Spacing()
                    end
                end

                imgui.NextColumn()

                for group_index = left_groups + 1, #rewards do
                    render_reward_group_column(ctx, xidb, deps, state, rewards[group_index], group_index, 'xidb_ksnm')
                    if group_index < #rewards then
                        imgui.Spacing()
                    end
                end

                imgui.Columns(1)
            end
        end
    imgui.EndChild()
end

return M