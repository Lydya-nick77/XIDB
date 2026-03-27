local settings = require('settings')
local imgui = require('imgui')
local fonts = require('fonts')

local M = {}
local RECIPE_COLUMN_SPACING = 12

local function render_created_by_column(ctx, xidb, deps, entry, recipes, column_width)
    imgui.BeginChild('xidb_recipes_created_by', { column_width, 0, }, true)
        fonts.Header(('Created By (%d)'):fmt(#recipes))
        imgui.Separator()

        if #recipes == 0 then
            fonts.TextWrappedPx('This item is not produced by a tracked crafting recipe.', fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE)
        else
            for i, recipe in ipairs(recipes) do
                local recipe_name = tostring(recipe.name or entry.name or 'Unknown Recipe')
                local skill_name = tostring(recipe.skill or 'Unknown Skill')
                local level = tonumber(recipe.level) or 0
                local crystal = tostring(recipe.crystal or 'Unknown Crystal')
                local has_ingredients = type(recipe.ingredients) == 'table' and #recipe.ingredients > 0
                local has_subcraft = type(recipe.subcraft) == 'table' and #recipe.subcraft > 0

                fonts.RecipeName(('%d. %s'):fmt(i, recipe_name))
                fonts.Label(('Skill: %s (%d)'):fmt(skill_name, level))
                if has_subcraft then
                    fonts.Label(('Subcraft: %s'):fmt(table.concat(recipe.subcraft, ', ')))
                end

                if has_ingredients then
                    fonts.Header('Ingredients')
                    fonts.Label(('Crystal: %s'):fmt(crystal))
                    fonts.WithFont(18, function()
                        for ingredient_index, ingredient in ipairs(recipe.ingredients) do
                            local ingredient_text = tostring(ingredient)
                            local lookup_name = ctx.ingredient_to_lookup_name(ingredient_text)
                            local ingredient_id = ctx.find_item_id_by_name(xidb, lookup_name)

                            if ingredient_id ~= nil then
                                local label = ('> %s##recipe_%d_ingredient_%d'):fmt(ingredient_text, i, ingredient_index)
                                if imgui.Selectable(label, false) then
                                    deps.set_filter(lookup_name)
                                    deps.select_item(ingredient_id)
                                    ctx.update_details_cache(xidb, deps)
                                end
                            else
                                imgui.BulletText(ingredient_text)
                            end
                        end
                    end)
                end

                local hq_parts = { }
                if type(recipe.hq1) == 'string' and recipe.hq1 ~= '' then
                    hq_parts[#hq_parts + 1] = ('HQ1: %s'):fmt(recipe.hq1)
                end
                if type(recipe.hq2) == 'string' and recipe.hq2 ~= '' then
                    hq_parts[#hq_parts + 1] = ('HQ2: %s'):fmt(recipe.hq2)
                end
                if type(recipe.hq3) == 'string' and recipe.hq3 ~= '' then
                    hq_parts[#hq_parts + 1] = ('HQ3: %s'):fmt(recipe.hq3)
                end
                if #hq_parts > 0 then
                    fonts.TextWrappedPx(table.concat(hq_parts, ' | '), fonts.COLORS.LIGHT_GRAY, 18, fonts.SCALES.LARGE)
                end

                if i < #recipes then
                    imgui.Separator()
                end
            end
        end
    imgui.EndChild()
end

local function render_used_as_ingredient_column(ctx, xidb, deps, used_in_recipes)
    imgui.BeginChild('xidb_recipes_used_in', { 0, 0, }, true)
        fonts.Header(('Used in Recipes (%d)'):fmt(#used_in_recipes))
        imgui.Separator()

        if #used_in_recipes == 0 then
            fonts.TextWrappedPx('This item is not used as an ingredient in a tracked crafting recipe.', fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE)
        else
            for i, recipe in ipairs(used_in_recipes) do
                local recipe_name = tostring(recipe.name or 'Unknown Recipe')
                local skill_name = tostring(recipe.skill or 'Unknown Skill')
                local level = tonumber(recipe.level) or 0
                local result_lookup_name = ctx.ingredient_to_lookup_name(recipe_name)
                local result_item_id = ctx.find_item_id_by_name(xidb, result_lookup_name)
                local has_subcraft = type(recipe.subcraft) == 'table' and #recipe.subcraft > 0

                if result_item_id ~= nil then
                    fonts.WithFont(18, function()
                        local label = ('%d. %s##used_in_%d'):fmt(i, recipe_name, i)
                        if imgui.Selectable(label, false) then
                            deps.set_filter(result_lookup_name)
                            deps.select_item(result_item_id)
                            ctx.update_details_cache(xidb, deps)
                        end
                    end)
                else
                    fonts.Ingredient(('%d. %s'):fmt(i, recipe_name))
                end

                fonts.Label(('Skill: %s (%d)'):fmt(skill_name, level))
                if has_subcraft then
                    fonts.Label(('Subcraft: %s'):fmt(table.concat(recipe.subcraft, ', ')))
                end

                if i < #used_in_recipes then
                    imgui.Separator()
                end
            end
        end
    imgui.EndChild()
end

function M.render(ctx, xidb, deps)
    deps.ensure_index()

    if ctx.details_cache.selected_id ~= xidb.db.selected_id or (ctx.details_cache.entry == nil and xidb.db.selected_id ~= nil) then
        ctx.update_details_cache(xidb, deps)
    end

    fonts.TextWrappedPx('Search by name, description, or id.', fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE)
    local max_results = { deps.to_number(xidb.settings.max_results, 250), }

    if (imgui.InputText('Search', xidb.ui.filter, 256)) then
        deps.refresh_results(true)
    end
    imgui.SameLine()
    imgui.SetNextItemWidth(110)
    if (imgui.InputInt('Max Results', max_results)) then
        xidb.settings.max_results = math.max(25, math.min(max_results[1], 1000))
        deps.refresh_results(true)
        settings.save()
    end

    if (imgui.Button('Rescan')) then
        deps.rebuild_index(false)
        settings.save()
        ctx.update_details_cache(xidb, deps)
    end
    imgui.SameLine()
    if (imgui.Button('Clear Filter')) then
        deps.set_filter('')
    end

    imgui.Separator()

    imgui.BeginChild('xidb_results', { ctx.results_pane_width, -1, }, true)
        if (xidb.db.indexing) then
            fonts.TextPx('Scanning resources..', 18, fonts.SCALES.LARGE)
        elseif (#xidb.db.results == 0) then
            fonts.TextPx('No matching items.', 18, fonts.SCALES.LARGE)
        else
            fonts.WithFont(18, function()
                for _, entry in ipairs(xidb.db.results) do
                    local label = ('%s'):fmt(entry.log_singular)
                    if (imgui.Selectable(label, xidb.db.selected_id == entry.id)) then
                        deps.select_item(entry.id)
                        ctx.update_details_cache(xidb, deps)
                    end
                end
            end)
        end
    imgui.EndChild()

    imgui.SameLine()

    imgui.BeginChild('xidb_details', { ctx.details_pane_width, -1, }, true)
        local entry = ctx.details_cache.entry
        if (entry == nil) then
            fonts.TextPx('Select an item to inspect its details.', 18, fonts.SCALES.LARGE)
        else
            local item_name = ctx.details_cache.item_name or ''
            local tex_id = ctx.details_cache.tex_id
            if tex_id then
                local ok_img = pcall(function()
                    imgui.Image(tex_id, {36, 36}, {0, 0}, {1, 1}, {1, 1, 1, 1}, {0, 0, 0, 0})
                end)
                if ok_img then
                    imgui.SameLine()
                end
            end
            fonts.RecipeName(item_name)
            imgui.Separator()

            fonts.Label(('ID: %d'):fmt(entry.id))
            fonts.Label(('Level: %d'):fmt(entry.level))
            fonts.Label(('Stack Size: %d'):fmt(entry.stack_size))
            fonts.Label(('Type: %s  *verif needed*'):fmt(deps.format_item_type(entry.type)))
            fonts.Label(('Jobs: %s'):fmt(deps.format_jobs_mask(entry.jobs)))
            fonts.Label(('Slots: %s'):fmt(deps.format_slots_mask(entry.slots)))

            if (entry.log_singular ~= '') then
                imgui.Separator()
                fonts.Header('Short Name')
                fonts.TextWrappedPx(item_name, fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE)
            end

            if (entry.log_plural ~= '') then
                imgui.Separator()
                fonts.Header('Long Name')
                fonts.TextWrappedPx(entry.log_plural, fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE)
            end

            if (entry.description ~= '') then
                imgui.Separator()
                fonts.Header('Description')
                fonts.TextWrappedPx(entry.description, fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE)
            end
        end
    imgui.EndChild()

    imgui.SameLine()

    imgui.BeginChild('xidb_recipes', { 0, -1, }, true)
        fonts.Title('Crafting Recipes')
        imgui.Separator()

        local entry = ctx.details_cache.entry
        if (entry == nil) then
            fonts.TextPx('Select an item to view recipes.', 18, fonts.SCALES.LARGE)
        else
            local recipes, used_in_recipes = ctx.get_recipes_for_item_entry(entry, ctx.details_cache.item_name or '')

            if (#recipes == 0 and #used_in_recipes == 0) then
                fonts.TextWrappedPx('No crafting recipe found for this item.', fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE)
            else
                local available_width = imgui.GetContentRegionAvail()
                local column_width = math.max(220, (available_width - RECIPE_COLUMN_SPACING) / 2)

                render_created_by_column(ctx, xidb, deps, entry, recipes, column_width)
                imgui.SameLine()
                render_used_as_ingredient_column(ctx, xidb, deps, used_in_recipes)
            end
        end
    imgui.EndChild()
end

return M
