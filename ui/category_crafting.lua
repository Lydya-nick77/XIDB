local imgui = require('imgui')
local fonts = require('fonts')

local M = {}

local function go_to_item_browser(ctx, xidb, deps, item_name)
    if xidb == nil or deps == nil then
        return false
    end

    local lookup_name = ctx.ingredient_to_lookup_name(item_name)
    if lookup_name == '' then
        return false
    end

    local item_id = ctx.find_item_id_by_name(xidb, lookup_name)
    if item_id == nil then
        return false
    end

    ctx.state.selected_module_index = ctx.module_index.ITEMS
    deps.set_filter(lookup_name)
    deps.select_item(item_id)
    ctx.update_details_cache(xidb, deps)
    return true
end

local function render_clickable_item_line(ctx, xidb, deps, display_text, item_name, id_suffix)
    local line_text = tostring(display_text or '')
    if line_text == '' then
        return
    end

    if xidb == nil or deps == nil then
        fonts.Ingredient(line_text)
        return
    end

    local lookup_name = ctx.ingredient_to_lookup_name(item_name)
    if lookup_name == '' then
        fonts.Ingredient(line_text)
        return
    end

    local item_id = ctx.find_item_id_by_name(xidb, lookup_name)
    if item_id == nil then
        fonts.Ingredient(line_text)
        return
    end

    fonts.WithFont(18, function()
        local label = line_text .. '##craft_item_link_' .. tostring(id_suffix or '')
        if imgui.Selectable(label, false) then
            go_to_item_browser(ctx, xidb, deps, item_name)
        end
    end)
end

function M.render(ctx, xidb, deps)
    local state = ctx.state
    local rank_list = ctx.crafting_ranks.list or { }
    if state.selected_rank_index < 1 or state.selected_rank_index > #rank_list then
        state.selected_rank_index = 1
    end

    imgui.BeginChild('xidb_crafting_ranks', { 220, -1, }, true)
        fonts.Title('Crafting Ranks')
        imgui.Separator()
        fonts.WithFont(18, function()
            for i, rank in ipairs(rank_list) do
                local rank_name = tostring(rank.name or ('Rank ' .. tostring(i)))
                local min_level = tonumber(rank.min) or 0
                local max_level = tonumber(rank.max) or 0
                local label = ('%s (%d-%d)##rank_%d'):fmt(rank_name, min_level, max_level, i)
                if imgui.Selectable(label, state.selected_rank_index == i) then
                    state.selected_rank_index = i
                end
            end
        end)
    imgui.EndChild()

    imgui.SameLine()

    imgui.BeginChild('xidb_crafting_recipes_browser', { 0, -1, }, true)
        fonts.Title('Recipes')
        imgui.Separator()

        local current_subcat = ctx.get_current_subcategory_name()
        if state.selected_subcategory_index <= 1 then
            fonts.TextWrappedPx('Select a craft in Sub Category to show recipes.', fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE)
        else
            local skill_name = ctx.craft_subcategory_to_skill[current_subcat]
            local selected_rank = rank_list[state.selected_rank_index]
            if not skill_name then
                fonts.TextWrappedPx('Selected sub category is not mapped to a recipe skill yet.', fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE)
            elseif not selected_rank then
                fonts.TextWrappedPx('No crafting ranks are available in ranks.lua.', fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE)
            else
                local recipes = ctx.get_recipes_for_skill_and_rank(skill_name, selected_rank)

                if #recipes == 0 then
                    fonts.TextWrappedPx('No recipes found for this craft and rank range.', fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE)
                else
                    for i, recipe in ipairs(recipes) do
                        local recipe_name = tostring(recipe.name or 'Unknown Recipe')
                        local level = tonumber(recipe.level) or 0
                        local crystal = tostring(recipe.crystal or 'Unknown Crystal')
                        local row_start_x = imgui.GetCursorPosX()
                        local row_start_y = imgui.GetCursorPosY()

                        -- Check if this recipe is shown as a subcraft match (main skill != selected skill)
                        local recipe_main_skill = tostring(recipe.skill or ''):lower()
                        local selected_skill_lower = tostring(skill_name or ''):lower()
                        local is_subcraft_match = (recipe_main_skill ~= selected_skill_lower)
                        
                        local display_level = level
                        local display_main_skill = recipe.skill
                        
                        if is_subcraft_match then
                            -- Find the matching subcraft entry to get its level
                            if recipe.subcraft and type(recipe.subcraft) == 'table' then
                                for _, subcraft_item in ipairs(recipe.subcraft) do
                                    local subcraft_str = tostring(subcraft_item or '')
                                    local sc_skill, sc_level = subcraft_str:match('^%s*(.-)%s*%((%d+)%)%s*$')
                                    if sc_skill and sc_skill:lower() == selected_skill_lower then
                                        display_level = tonumber(sc_level) or 0
                                        break
                                    end
                                end
                            end
                        end

                        imgui.BeginGroup()
                            local recipe_header = ('(%d) %s'):fmt(display_level, recipe_name)
                            local recipe_lookup_name = ctx.ingredient_to_lookup_name(recipe_name)
                            local recipe_item_id = nil
                            if xidb ~= nil and recipe_lookup_name ~= '' then
                                recipe_item_id = ctx.find_item_id_by_name(xidb, recipe_lookup_name)
                            end

                            if xidb ~= nil and deps ~= nil and recipe_item_id ~= nil then
                                fonts.WithFont(18, function()
                                    local label = ('%s##craft_recipe_result_%d'):fmt(recipe_header, i)
                                    if imgui.Selectable(label, false) then
                                        go_to_item_browser(ctx, xidb, deps, recipe_name)
                                    end
                                end)
                            else
                                fonts.RecipeName(recipe_header)
                            end
                            -- Show main skill as subcraft if this is a subcraft match
                            if is_subcraft_match then
                                fonts.Label('Subcraft: ' .. tostring(display_main_skill) .. ' (' .. tostring(level) .. ')')
                            end
                            if recipe.subcraft then
                                if type(recipe.subcraft) == 'table' then
                                    for _, subcraft_item in ipairs(recipe.subcraft) do
                                        if not is_subcraft_match then
                                            fonts.Label('Subcraft: ' .. tostring(subcraft_item))
                                        else
                                            -- Only show other subcrafts, not the one matching selected skill
                                            local subcraft_str = tostring(subcraft_item or '')
                                            local sc_skill = subcraft_str:match('^%s*(.-)%s*%(')
                                            if not (sc_skill and sc_skill:lower() == selected_skill_lower) then
                                                fonts.Label('Subcraft: ' .. tostring(subcraft_item))
                                            end
                                        end
                                    end
                                else
                                    if not is_subcraft_match then
                                        local subcraft_str = tostring(recipe.subcraft):match('^%s*(.-)%s*$') or ''
                                        if subcraft_str ~= '' then
                                            fonts.Label('Subcraft: ' .. subcraft_str)
                                        end
                                    end
                                end
                            end
                            fonts.Label('Ingredients:')
                            fonts.Label(('Crystal: %s'):fmt(crystal))
                            if recipe.ingredients and type(recipe.ingredients) == 'table' then
                                for ingredient_index, ingredient in ipairs(recipe.ingredients) do
                                    if type(ingredient) == 'table' then
                                        local ingredient_name = tostring(ingredient.name or 'Unknown Ingredient')
                                        local ingredient_qty = tonumber(ingredient.qty)
                                        if ingredient_qty and ingredient_qty > 0 then
                                            render_clickable_item_line(ctx, xidb, deps, (' - %s x%d'):fmt(ingredient_name, ingredient_qty), ingredient_name, ('%d_ingredient_%d'):fmt(i, ingredient_index))
                                        else
                                            render_clickable_item_line(ctx, xidb, deps, (' - %s'):fmt(ingredient_name), ingredient_name, ('%d_ingredient_%d'):fmt(i, ingredient_index))
                                        end
                                    else
                                        local ingredient_text = tostring(ingredient)
                                        render_clickable_item_line(ctx, xidb, deps, (' - %s'):fmt(ingredient_text), ingredient_text, ('%d_ingredient_%d'):fmt(i, ingredient_index))
                                    end
                                end
                            else
                                fonts.Ingredient('No ingredient information available.')
                            end
                        imgui.EndGroup()

                        local left_end_y = imgui.GetCursorPosY()
                        imgui.SameLine()
                        imgui.SetCursorPosX(row_start_x + 360)
                        imgui.SetCursorPosY(row_start_y)

                        imgui.BeginGroup()
                            fonts.Label('HQ Results:')
                            local has_hq = false
                            if type(recipe.hq1) == 'string' and recipe.hq1 ~= '' then
                                render_clickable_item_line(ctx, xidb, deps, (' - HQ1: %s'):fmt(recipe.hq1), recipe.hq1, ('%d_hq1'):fmt(i))
                                has_hq = true
                            end
                            if type(recipe.hq2) == 'string' and recipe.hq2 ~= '' then
                                render_clickable_item_line(ctx, xidb, deps, (' - HQ2: %s'):fmt(recipe.hq2), recipe.hq2, ('%d_hq2'):fmt(i))
                                has_hq = true
                            end
                            if type(recipe.hq3) == 'string' and recipe.hq3 ~= '' then
                                render_clickable_item_line(ctx, xidb, deps, (' - HQ3: %s'):fmt(recipe.hq3), recipe.hq3, ('%d_hq3'):fmt(i))
                                has_hq = true
                            end
                            if not has_hq then
                                fonts.Ingredient(' - None')
                            end
                        imgui.EndGroup()

                        local right_end_y = imgui.GetCursorPosY()
                        imgui.SetCursorPosY(math.max(left_end_y, right_end_y))

                        if i < #recipes then
                            imgui.Separator()
                        end
                    end
                end
            end
        end
    imgui.EndChild()
end

return M
