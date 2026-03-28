local imgui = require('imgui')
local fonts = require('fonts')
local bcnm_data = require('bcnm.bcnm_data')

local M = {}

local function draw_wrapped_unformatted(text, color)
    imgui.PushStyleColor(ImGuiCol_Text, color or fonts.COLORS.LIGHT_GRAY)
    imgui.PushTextWrapPos(0)
    imgui.TextUnformatted(tostring(text or ''))
    imgui.PopTextWrapPos()
    imgui.PopStyleColor(1)
end

local function get_bcnms_by_level(level_text)
    local bcnms = {}
    if level_text and level_text ~= '' and level_text ~= 'Select Sub Category' then
        for _, bcnm in ipairs(bcnm_data.bcnm_list or {}) do
            if tostring(bcnm.level or ''):lower() == level_text:lower() then
                table.insert(bcnms, bcnm)
            end
        end
        table.sort(bcnms, function(a, b)
            return tostring(a.name or ''):lower() < tostring(b.name or ''):lower()
        end)
    end
    return bcnms
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

    local level_bcnms = level_selected and get_bcnms_by_level(current_subcat) or {}

    if not state.selected_bcnm_index then
        state.selected_bcnm_index = 0
    end

    if state.selected_bcnm_index < 0 or state.selected_bcnm_index > #level_bcnms then
        state.selected_bcnm_index = 0
    end

    local selected_bcnm = nil
    if state.selected_bcnm_index > 0 and state.selected_bcnm_index <= #level_bcnms then
        selected_bcnm = level_bcnms[state.selected_bcnm_index]
    end

    imgui.BeginChild('xidb_bcnm_list', { 260, -1 }, true)
        fonts.Title('BCNMs by Level')
        imgui.Separator()

        if not level_selected then
            fonts.TextWrappedPx(
                'Select a level from the Sub Category dropdown above.',
                fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE
            )
        elseif #level_bcnms == 0 then
            fonts.TextWrappedPx(
                'No BCNMs found for this level.',
                fonts.COLORS.GRAY, 18, fonts.SCALES.LARGE
            )
        else
            fonts.WithFont(18, function()
                for i, bcnm in ipairs(level_bcnms) do
                    local is_selected = (state.selected_bcnm_index == i)
                    if imgui.Selectable(bcnm.name, is_selected) then
                        state.selected_bcnm_index = i
                    end
                    if is_selected then
                        imgui.SetItemDefaultFocus()
                    end
                end
            end)
        end
    imgui.EndChild()

    imgui.SameLine()

    imgui.BeginChild('xidb_bcnm_details', { 0, -1 }, true)
        if not level_selected then
            fonts.Title('Burning Circle Notorious Monsters')
            imgui.Separator()
            imgui.Spacing()
            fonts.WithFont(18, function()
                draw_wrapped_unformatted(
                    'Officially called Orb Battles, Burning Circle Notorious Monster (BCNM) events are a special type of arena battle in which adventurers fight a specific mob or group of mobs. They are great ways to have fun and earn powerful items in the world of Vana\'diel.',
                    fonts.COLORS.LIGHT_GRAY
                )
                imgui.Spacing()
                draw_wrapped_unformatted(
                    'These events are accessed by trading a specific orb to the entrance of a Burning Circle. These orbs can be obtained by trading Beastmen\'s Seals to Shami in Port Jeuno.',
                    fonts.COLORS.LIGHT_GRAY
                )
                imgui.Spacing()

                draw_wrapped_unformatted('Notes', fonts.COLORS.WHITE)
                imgui.Spacing()
                draw_wrapped_unformatted('  * Only one person needs an orb to enter the battle.', fonts.COLORS.LIGHT_GRAY)
                draw_wrapped_unformatted('  * Food does not wear off upon entering.', fonts.COLORS.LIGHT_GRAY)
                draw_wrapped_unformatted('  * In the event of a K.O., all TP accumulated is reset to zero within a BCNM.', fonts.COLORS.LIGHT_GRAY)
                draw_wrapped_unformatted('  * In the event of a party wipe, the party has 3 minutes to reraise or all members get kicked out.', fonts.COLORS.LIGHT_GRAY)
                imgui.Spacing()
            end)
        elseif not selected_bcnm then
            fonts.Title('Level ' .. tostring(current_subcat))
            imgui.Separator()
            imgui.Spacing()
            fonts.TextWrappedPx(
                'Select a BCNM from the list on the left to view its details.',
                fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE
            )
        else
            fonts.Title(selected_bcnm.name or 'BCNM')
            imgui.Separator()
            imgui.Spacing()

            fonts.Header('Encounter')
            imgui.Separator()
            imgui.Spacing()

            imgui.BeginGroup()
                fonts.Label('Level:')
                imgui.SameLine()
                fonts.WithFont(18, function()
                    draw_wrapped_unformatted(tostring(selected_bcnm.level or 'Unknown'), fonts.COLORS.WHITE)
                end)

                fonts.Label('Orb Required:')
                imgui.SameLine()
                fonts.WithFont(18, function()
                    draw_wrapped_unformatted(selected_bcnm.orb_required or 'Unknown', fonts.COLORS.WHITE)
                end)

                fonts.Label('Zone:')
                imgui.SameLine()
                fonts.WithFont(18, function()
                    draw_wrapped_unformatted(selected_bcnm.zone or 'Unknown', fonts.COLORS.WHITE)
                end)

                fonts.Label('Maximum Members:')
                imgui.SameLine()
                fonts.WithFont(18, function()
                    draw_wrapped_unformatted(selected_bcnm.max_members or 'Unknown', fonts.COLORS.WHITE)
                end)

                fonts.Label('Time Limit:')
                imgui.SameLine()
                fonts.WithFont(18, function()
                    draw_wrapped_unformatted(selected_bcnm.time_limit or 'Unknown', fonts.COLORS.WHITE)
                end)
            imgui.EndGroup()

            imgui.Spacing()
            fonts.Header('Mobs')
            imgui.Separator()
            imgui.Spacing()

            local mobs = selected_bcnm.mobs or {}
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

            if selected_bcnm.note and selected_bcnm.note ~= '' then
                imgui.Spacing()
                fonts.Header('Note')
                imgui.Separator()
                imgui.Spacing()

                fonts.WithFont(18, function()
                    for part in tostring(selected_bcnm.note):gmatch('[^|]+') do
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

            local rewards = selected_bcnm.rewards or {}
            if #rewards == 0 then
                fonts.Label('No reward data recorded.')
            else
                local left_groups = math.ceil(#rewards / 2)

                imgui.Columns(2, 'xidb_bcnm_rewards_columns', false)
                for group_index = 1, left_groups do
                    render_reward_group_column(ctx, xidb, deps, state, rewards[group_index], group_index, 'xidb_bcnm')
                    if group_index < left_groups then
                        imgui.Spacing()
                    end
                end

                imgui.NextColumn()

                for group_index = left_groups + 1, #rewards do
                    render_reward_group_column(ctx, xidb, deps, state, rewards[group_index], group_index, 'xidb_bcnm')
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
