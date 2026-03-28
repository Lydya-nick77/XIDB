local settings = require('settings')
local imgui = require('imgui')
local fonts = require('fonts')
local nm_data = require('nms.nm_data')
local bcnm_data = require('bcnm.bcnm_data')
local ksnm_data = require('ksnm.ksnm_data')
local henm_data = require('henm.henm_data')

local M = {}
local RECIPE_COLUMN_SPACING = 12
local drop_lookup_cache = nil

local function clamp(value, min_value, max_value)
    if value < min_value then
        return min_value
    end
    if value > max_value then
        return max_value
    end
    return value
end

local function drop_to_lookup_name(ctx, drop)
    local text = tostring(drop or '')
    if text == '' then
        return nil
    end

    if text:lower():find('gil', 1, true) then
        return nil
    end

    text = text:gsub('%s*%b()%s*$', '')
    local lookup_name = ctx.ingredient_to_lookup_name(text)
    if lookup_name == '' then
        return nil
    end

    return lookup_name
end

local function ensure_nm_drop_lookup_cache(ctx)
    if drop_lookup_cache ~= nil then
        return
    end

    drop_lookup_cache = { }

    local function add_drop_source(lookup_name, source)
        if lookup_name == nil or lookup_name == '' then
            return
        end

        local bucket = drop_lookup_cache[lookup_name]
        if bucket == nil then
            bucket = { }
            drop_lookup_cache[lookup_name] = bucket
        end

        local key = table.concat({
            tostring(source.module or ''),
            tostring(source.name or ''),
            tostring(source.area or ''),
            tostring(source.level or ''),
            tostring(source.tier or ''),
        }, '\31')

        for _, existing in ipairs(bucket) do
            if existing._key == key then
                return
            end
        end

        source._key = key
        bucket[#bucket + 1] = source
    end

    local function reward_item_to_lookup_name(ctx2, item_text)
        local text = tostring(item_text or '')
        if text == '' then
            return nil
        end

        if text:lower():find('gil', 1, true) then
            return nil
        end

        text = text:gsub('%s*%b()%s*', ' ')
        text = text:gsub('^HorizonXI specific changes%s*', '')
        text = text:gsub('^adjusted stats%s*', '')
        text = text:gsub('^Scroll of%s+', '')
        text = text:gsub('%s*/%s*$', '')
        text = text:gsub('%s*%-%s*$', '')
        text = text:match('^%s*(.-)%s*$') or ''
        if text == '' then
            return nil
        end

        local lookup_name = ctx2.ingredient_to_lookup_name(text)
        if lookup_name == '' then
            return nil
        end

        return lookup_name
    end

    for _, nm in ipairs(nm_data.nm_list or { }) do
        if type(nm) == 'table' and type(nm.drops) == 'table' then
            local nm_name = tostring(nm.name or '')
            local nm_area = tostring(nm.area or '')

            if nm_name ~= '' then
                for _, drop in ipairs(nm.drops) do
                    local lookup_name = drop_to_lookup_name(ctx, drop)
                    if lookup_name ~= nil then
                        add_drop_source(lookup_name, {
                            module = 'NM',
                            name = nm_name,
                            area = nm_area,
                        })
                    end
                end
            end
        end
    end

    for _, bcnm in ipairs(bcnm_data.bcnm_list or { }) do
        if type(bcnm) == 'table' and type(bcnm.rewards) == 'table' and tostring(bcnm.name or '') ~= '' then
            for _, reward_group in ipairs(bcnm.rewards) do
                local items = (type(reward_group) == 'table' and type(reward_group.items) == 'table') and reward_group.items or { }
                for _, reward_item in ipairs(items) do
                    local lookup_name = reward_item_to_lookup_name(ctx, reward_item)
                    if lookup_name ~= nil then
                        add_drop_source(lookup_name, {
                            module = 'BCNM',
                            name = tostring(bcnm.name or ''),
                            level = tostring(bcnm.level or ''),
                            area = tostring(bcnm.zone or ''),
                        })
                    end
                end
            end
        end
    end

    for _, ksnm in ipairs(ksnm_data.ksnm_list or { }) do
        if type(ksnm) == 'table' and type(ksnm.rewards) == 'table' and tostring(ksnm.name or '') ~= '' then
            for _, reward_group in ipairs(ksnm.rewards) do
                local items = (type(reward_group) == 'table' and type(reward_group.items) == 'table') and reward_group.items or { }
                for _, reward_item in ipairs(items) do
                    local lookup_name = reward_item_to_lookup_name(ctx, reward_item)
                    if lookup_name ~= nil then
                        add_drop_source(lookup_name, {
                            module = 'KSNM',
                            name = tostring(ksnm.name or ''),
                            level = tostring(ksnm.level or ''),
                            area = tostring(ksnm.zone or ''),
                        })
                    end
                end
            end
        end
    end

    for _, henm in ipairs(henm_data.henm_list or { }) do
        if type(henm) == 'table' and type(henm.drops) == 'table' and tostring(henm.name or '') ~= '' then
            for _, drop in ipairs(henm.drops) do
                local lookup_name = drop_to_lookup_name(ctx, drop)
                if lookup_name ~= nil then
                    add_drop_source(lookup_name, {
                        module = 'HENM',
                        name = tostring(henm.name or ''),
                        tier = tostring(henm.tier or ''),
                        area = tostring(henm.area or ''),
                    })
                end
            end
        end
    end

    for _, bucket in pairs(drop_lookup_cache) do
        table.sort(bucket, function(a, b)
            local module_order = {
                NM = 1,
                BCNM = 2,
                KSNM = 3,
                HENM = 4,
            }
            local am = module_order[tostring(a.module or '')] or 99
            local bm = module_order[tostring(b.module or '')] or 99
            if am ~= bm then
                return am < bm
            end

            local an = tostring(a.name or ''):lower()
            local bn = tostring(b.name or ''):lower()
            if an == bn then
                return tostring(a.area or ''):lower() < tostring(b.area or ''):lower()
            end
            return an < bn
        end)
    end
end

local function get_nms_dropping_item(ctx, entry, item_name)
    ensure_nm_drop_lookup_cache(ctx)

    local merged = { }
    local seen = { }
    local candidates = {
        item_name or '',
    }

    if type(entry) == 'table' then
        candidates[#candidates + 1] = entry.name or ''
        candidates[#candidates + 1] = entry.log_singular or ''
        candidates[#candidates + 1] = entry.log_plural or ''
    end

    for _, candidate in ipairs(candidates) do
        local lookup_name = ctx.ingredient_to_lookup_name(candidate)
        if lookup_name ~= '' then
            local bucket = drop_lookup_cache[lookup_name] or { }
            for _, source in ipairs(bucket) do
                local key = tostring(source._key or '')
                if not seen[key] then
                    seen[key] = true
                    merged[#merged + 1] = source
                end
            end
        end
    end

    table.sort(merged, function(a, b)
        local module_order = {
            NM = 1,
            BCNM = 2,
            KSNM = 3,
            HENM = 4,
        }
        local am = module_order[tostring(a.module or '')] or 99
        local bm = module_order[tostring(b.module or '')] or 99
        if am ~= bm then
            return am < bm
        end

        local an = tostring(a.name or ''):lower()
        local bn = tostring(b.name or ''):lower()
        if an == bn then
            return tostring(a.area or ''):lower() < tostring(b.area or ''):lower()
        end
        return an < bn
    end)

    return merged
end

local function find_zone_subcategory_index(ctx, zone_name)
    local module_index = ctx.module_index.NM
    local subcategories = ctx.subcategories[module_index] or { 'Select Sub Category' }

    for index, value in ipairs(subcategories) do
        if tostring(value or ''):lower() == tostring(zone_name or ''):lower() then
            return index
        end
    end

    return 1
end

local function find_subcategory_index(ctx, module_index, subcategory_name)
    local subcategories = ctx.subcategories[module_index] or { 'Select Sub Category' }
    for index, value in ipairs(subcategories) do
        if tostring(value or ''):lower() == tostring(subcategory_name or ''):lower() then
            return index
        end
    end
    return 1
end

local function find_nm_index_in_zone(zone_name, nm_name)
    local zone_nms = { }

    for _, nm in ipairs(nm_data.nm_list or { }) do
        if type(nm) == 'table'
            and tostring(nm.name or '') ~= ''
            and tostring(nm.area or ''):lower() == tostring(zone_name or ''):lower()
        then
            zone_nms[#zone_nms + 1] = nm
        end
    end

    table.sort(zone_nms, function(a, b)
        return tostring(a.name or ''):lower() < tostring(b.name or ''):lower()
    end)

    for index, nm in ipairs(zone_nms) do
        if tostring(nm.name or ''):lower() == tostring(nm_name or ''):lower() then
            return index
        end
    end

    return 0
end

local function find_battle_index_in_level(list, level_text, battle_name)
    local filtered = { }
    for _, entry in ipairs(list or { }) do
        if type(entry) == 'table'
            and tostring(entry.name or '') ~= ''
            and tostring(entry.level or ''):lower() == tostring(level_text or ''):lower()
        then
            filtered[#filtered + 1] = entry
        end
    end

    table.sort(filtered, function(a, b)
        return tostring(a.name or ''):lower() < tostring(b.name or ''):lower()
    end)

    for index, entry in ipairs(filtered) do
        if tostring(entry.name or ''):lower() == tostring(battle_name or ''):lower() then
            return index
        end
    end

    return 0
end

local function find_henm_index_in_tier(tier_name, henm_name)
    local filtered = { }
    for _, entry in ipairs(henm_data.henm_list or { }) do
        if type(entry) == 'table'
            and tostring(entry.name or '') ~= ''
            and tostring(entry.tier or ''):lower() == tostring(tier_name or ''):lower()
        then
            filtered[#filtered + 1] = entry
        end
    end

    table.sort(filtered, function(a, b)
        return tostring(a.name or ''):lower() < tostring(b.name or ''):lower()
    end)

    for index, entry in ipairs(filtered) do
        if tostring(entry.name or ''):lower() == tostring(henm_name or ''):lower() then
            return index
        end
    end

    return 0
end

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

    local state = ctx.state
    local splitter_width = 6
    local min_results_width = 220
    local min_details_width = 260
    local min_recipes_width = 280
    local total_width = imgui.GetContentRegionAvail()

    if state.items_results_pane_width == nil then
        state.items_results_pane_width = ctx.results_pane_width
    end
    if state.items_details_pane_width == nil then
        state.items_details_pane_width = ctx.details_pane_width
    end

    local results_width = tonumber(state.items_results_pane_width) or ctx.results_pane_width
    local details_width = tonumber(state.items_details_pane_width) or ctx.details_pane_width

    local max_results_width = math.max(min_results_width, total_width - details_width - min_recipes_width - (splitter_width * 2))
    results_width = clamp(results_width, min_results_width, max_results_width)

    local max_details_width = math.max(min_details_width, total_width - results_width - min_recipes_width - (splitter_width * 2))
    details_width = clamp(details_width, min_details_width, max_details_width)

    state.items_results_pane_width = results_width
    state.items_details_pane_width = details_width

    imgui.BeginChild('xidb_results', { results_width, -1, }, true)
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

    local _, splitter_height_1 = imgui.GetContentRegionAvail()
    imgui.Button('##xidb_items_splitter_left', { splitter_width, splitter_height_1 })
    if imgui.IsItemActive() then
        local io = imgui.GetIO()
        local dragged_width = results_width + (io.MouseDelta.x or 0)
        local dragged_max = math.max(min_results_width, total_width - details_width - min_recipes_width - (splitter_width * 2))
        results_width = clamp(dragged_width, min_results_width, dragged_max)
        state.items_results_pane_width = results_width
    end

    imgui.SameLine()

    imgui.BeginChild('xidb_details', { details_width, -1, }, true)
        local entry = ctx.details_cache.entry
        if (entry == nil) then
            fonts.TextPx('Select an item to inspect its details.', 18, fonts.SCALES.LARGE)
        else
            local item_name = ctx.details_cache.item_name or ''
            local dropped_by_nms = get_nms_dropping_item(ctx, entry, item_name)
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

            if (#dropped_by_nms > 0) then
                imgui.Separator()
                fonts.Header(('Dropped by (%d)'):fmt(#dropped_by_nms))
                fonts.WithFont(18, function()
                    for i, source in ipairs(dropped_by_nms) do
                        local module_name = tostring(source.module or 'NM')
                        local location_text = tostring(source.area or '')
                        if module_name == 'BCNM' or module_name == 'KSNM' then
                            local lvl = tostring(source.level or '')
                            if lvl ~= '' then
                                location_text = ('Level %s%s%s'):fmt(lvl, location_text ~= '' and ' - ' or '', location_text)
                            end
                        elseif module_name == 'HENM' then
                            local tier = tostring(source.tier or '')
                            if tier ~= '' then
                                location_text = ('%s%s%s'):fmt(tier, location_text ~= '' and ' - ' or '', location_text)
                            end
                        end

                        if location_text == '' then
                            location_text = 'Unknown Area'
                        end

                        local label = ('%d. [%s] %s (%s)##xidb_item_drop_%d'):fmt(i, module_name, tostring(source.name or ''), location_text, i)
                        if imgui.Selectable(label, false) then
                            local state = ctx.state

                            if module_name == 'NM' then
                                state.selected_module_index = ctx.module_index.NM
                                state.selected_subcategory_index = find_zone_subcategory_index(ctx, source.area)
                                state.selected_nm_index = find_nm_index_in_zone(source.area, source.name)
                                state.nm_search_results = nil
                            elseif module_name == 'BCNM' then
                                state.selected_module_index = ctx.module_index.BCNM
                                state.selected_subcategory_index = find_subcategory_index(ctx, ctx.module_index.BCNM, source.level)
                                state.selected_bcnm_index = find_battle_index_in_level(bcnm_data.bcnm_list, source.level, source.name)
                            elseif module_name == 'KSNM' then
                                state.selected_module_index = ctx.module_index.KSNM
                                state.selected_subcategory_index = find_subcategory_index(ctx, ctx.module_index.KSNM, source.level)
                                state.selected_ksnm_index = find_battle_index_in_level(ksnm_data.ksnm_list, source.level, source.name)
                            elseif module_name == 'HENM' then
                                state.selected_module_index = ctx.module_index.HENM
                                state.selected_subcategory_index = find_subcategory_index(ctx, ctx.module_index.HENM, source.tier)
                                state.selected_henm_index = find_henm_index_in_tier(source.tier, source.name)
                                state.henm_search_results = nil
                            end
                        end
                    end
                end)
            end
        end
    imgui.EndChild()

    imgui.SameLine()

    local _, splitter_height_2 = imgui.GetContentRegionAvail()
    imgui.Button('##xidb_items_splitter_right', { splitter_width, splitter_height_2 })
    if imgui.IsItemActive() then
        local io = imgui.GetIO()
        local dragged_width = details_width + (io.MouseDelta.x or 0)
        local dragged_max = math.max(min_details_width, total_width - results_width - min_recipes_width - (splitter_width * 2))
        details_width = clamp(dragged_width, min_details_width, dragged_max)
        state.items_details_pane_width = details_width
    end

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
