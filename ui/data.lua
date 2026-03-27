local M = {}

local RECIPE_SKILLS = {
    'alchemy',
    'bonecraft',
    'clothcraft',
    'cooking',
    'goldsmith',
    'leathercraft',
    'smithing',
    'woodworking',
}

local recipes_loaded = false
local recipes_by_result = { }
local recipes_by_ingredient = { }
local recipes_by_skill = { }
local item_lookup_cache = {
    scanned_count = -1,
    by_name = { },
}

M.details_cache = {
    selected_id = nil,
    entry = nil,
    item_name = '',
    tex_id = nil,
}

local function normalize_recipe_name(name)
    if type(name) ~= 'string' then
        return ''
    end
    local trimmed = name:match('^%s*(.-)%s*$') or ''
    return string.lower(trimmed)
end

local function canonicalize_lookup_name(name)
    local text = normalize_recipe_name(name)
    if text == '' then
        return ''
    end

    text = text:gsub('^an%s+', '')
    text = text:gsub('^a%s+', '')
    text = text:gsub('^the%s+', '')
    text = text:gsub('^piece of%s+', '')
    text = text:gsub('^square of%s+', '')
    text = text:gsub('^chunk of%s+', '')
    text = text:gsub('^sheet of%s+', '')
    text = text:gsub('^bolt of%s+', '')
    text = text:gsub('^spool of%s+', '')
    text = text:gsub('^pair of%s+', '')
    text = text:gsub('^handful of%s+', '')
    text = text:gsub('^slice of%s+', '')
    text = text:gsub('^jar of%s+', '')
    text = text:gsub('^pot of%s+', '')
    text = text:gsub('^flask of%s+', '')
    text = text:gsub('^vial of%s+', '')
    text = text:gsub('^bottle of%s+', '')
    text = text:gsub('^bag of%s+', '')

    return text:match('^%s*(.-)%s*$') or ''
end

local function normalize_item_name(name)
    return canonicalize_lookup_name(name)
end

function M.ingredient_to_lookup_name(ingredient)
    local text = tostring(ingredient or '')
    text = text:match('^%s*(.-)%s*$') or ''
    text = text:gsub('%s*[xX]%d+%s*$', '')
    return canonicalize_lookup_name(text)
end

local function ensure_item_lookup_cache(xidb)
    local scanned_count = tonumber(xidb.db.scanned_count) or 0
    if item_lookup_cache.scanned_count == scanned_count then
        return
    end

    item_lookup_cache.scanned_count = scanned_count
    item_lookup_cache.by_name = { }

    for _, entry in ipairs(xidb.db.items or { }) do
        local entry_id = tonumber(entry.id)
        if entry_id and entry_id > 0 then
            local names = {
                entry.name,
                entry.log_singular,
                entry.log_plural,
            }

            for _, candidate in ipairs(names) do
                local key = normalize_item_name(candidate)
                if key ~= '' and item_lookup_cache.by_name[key] == nil then
                    item_lookup_cache.by_name[key] = entry_id
                end
            end
        end
    end
end

function M.find_item_id_by_name(xidb, name)
    ensure_item_lookup_cache(xidb)
    local key = normalize_item_name(name)
    if key == '' then
        return nil
    end
    return item_lookup_cache.by_name[key]
end

local function append_recipe_result(result_name, recipe)
    local key = normalize_recipe_name(result_name)
    if key == '' then
        return
    end

    recipes_by_result[key] = recipes_by_result[key] or { }
    recipes_by_result[key][#recipes_by_result[key] + 1] = recipe
end

local function append_recipe_ingredient(ingredient_name, recipe)
    local key = normalize_item_name(M.ingredient_to_lookup_name(ingredient_name))
    if key == '' then
        return
    end

    recipes_by_ingredient[key] = recipes_by_ingredient[key] or { }
    recipes_by_ingredient[key][#recipes_by_ingredient[key] + 1] = recipe
end

local function ensure_recipes_loaded()
    if recipes_loaded then
        return
    end

    recipes_loaded = true
    recipes_by_result = { }
    recipes_by_ingredient = { }
    recipes_by_skill = { }

    for _, skill_name in ipairs(RECIPE_SKILLS) do
        local ok, recipe_data = pcall(require, 'recipes.' .. skill_name)
        if ok and type(recipe_data) == 'table' and type(recipe_data.by_name) == 'table' then
            recipes_by_skill[skill_name] = recipes_by_skill[skill_name] or { }
            for recipe_key, recipe in pairs(recipe_data.by_name) do
                if type(recipe) == 'table' then
                    append_recipe_result(recipe.name or recipe_key, recipe)
                    recipes_by_skill[skill_name][#recipes_by_skill[skill_name] + 1] = recipe
                    if type(recipe.ingredients) == 'table' then
                        for _, ingredient in ipairs(recipe.ingredients) do
                            append_recipe_ingredient(ingredient, recipe)
                        end
                    end
                end
            end
        end
    end

    for _, recipe_list in pairs(recipes_by_result) do
        table.sort(recipe_list, function(a, b)
            local a_level = tonumber(a.level) or 0
            local b_level = tonumber(b.level) or 0
            if a_level == b_level then
                local a_skill = tostring(a.skill or '')
                local b_skill = tostring(b.skill or '')
                return a_skill < b_skill
            end
            return a_level < b_level
        end)
    end

    for _, recipe_list in pairs(recipes_by_ingredient) do
        table.sort(recipe_list, function(a, b)
            local a_level = tonumber(a.level) or 0
            local b_level = tonumber(b.level) or 0
            if a_level == b_level then
                local a_skill = tostring(a.skill or '')
                local b_skill = tostring(b.skill or '')
                return a_skill < b_skill
            end
            return a_level < b_level
        end)
    end

    for _, recipe_list in pairs(recipes_by_skill) do
        table.sort(recipe_list, function(a, b)
            local a_level = tonumber(a.level) or 0
            local b_level = tonumber(b.level) or 0
            if a_level == b_level then
                local a_name = tostring(a.name or '')
                local b_name = tostring(b.name or '')
                return a_name < b_name
            end
            return a_level < b_level
        end)
    end
end

function M.get_recipes_for_item_name(item_name)
    ensure_recipes_loaded()
    local exact_key = normalize_recipe_name(item_name)
    local canonical_key = normalize_item_name(item_name)

    if exact_key == '' and canonical_key == '' then
        return { }
    end

    local merged = { }
    local seen = { }

    local function append_unique(source)
        if type(source) ~= 'table' then
            return
        end
        for _, recipe in ipairs(source) do
            if type(recipe) == 'table' and not seen[recipe] then
                seen[recipe] = true
                merged[#merged + 1] = recipe
            end
        end
    end

    append_unique(recipes_by_result[exact_key])
    if canonical_key ~= '' and canonical_key ~= exact_key then
        append_unique(recipes_by_result[canonical_key])
    end

    return merged
end

function M.get_recipes_using_item_name(item_name)
    ensure_recipes_loaded()
    local exact_key = normalize_recipe_name(item_name)
    local canonical_key = normalize_item_name(item_name)

    if exact_key == '' and canonical_key == '' then
        return { }
    end

    local merged = { }
    local seen = { }

    local function append_unique(source)
        if type(source) ~= 'table' then
            return
        end
        for _, recipe in ipairs(source) do
            if type(recipe) == 'table' and not seen[recipe] then
                seen[recipe] = true
                merged[#merged + 1] = recipe
            end
        end
    end

    append_unique(recipes_by_ingredient[exact_key])
    if canonical_key ~= '' and canonical_key ~= exact_key then
        append_unique(recipes_by_ingredient[canonical_key])
    end

    return merged
end

function M.get_recipes_for_item_entry(entry, display_name)
    local names = {
        display_name or '',
    }

    if type(entry) == 'table' then
        names[#names + 1] = entry.name or ''
        names[#names + 1] = entry.log_singular or ''
        names[#names + 1] = entry.log_plural or ''
    end

    local recipes = { }
    local used_in_recipes = { }
    local seen_recipes = { }
    local seen_used_in = { }

    local function append_unique(target, seen, source)
        if type(source) ~= 'table' then
            return
        end
        for _, recipe in ipairs(source) do
            if type(recipe) == 'table' and not seen[recipe] then
                seen[recipe] = true
                target[#target + 1] = recipe
            end
        end
    end

    for _, candidate_name in ipairs(names) do
        if candidate_name ~= '' then
            append_unique(recipes, seen_recipes, M.get_recipes_for_item_name(candidate_name))
            append_unique(used_in_recipes, seen_used_in, M.get_recipes_using_item_name(candidate_name))
        end
    end

    return recipes, used_in_recipes
end

local function recipe_subcraft_matches_skill_and_rank(recipe, skill_name, min_level, max_level)
    if type(recipe) ~= 'table' or type(recipe.subcraft) ~= 'table' then
        return false
    end

    local normalized_skill = tostring(skill_name or ''):lower()
    if normalized_skill == '' then
        return false
    end

    for _, subcraft_entry in ipairs(recipe.subcraft) do
        local entry_text = tostring(subcraft_entry or '')
        local entry_skill, entry_level = entry_text:match('^%s*(.-)%s*%((%d+)%)%s*$')
        if entry_skill then
            if entry_skill:lower() == normalized_skill then
                local level = tonumber(entry_level) or 0
                if level >= min_level and level <= max_level then
                    return true
                end
            end
        elseif entry_text:lower():match('^%s*' .. normalized_skill .. '%s*$') then
            return true
        end
    end

    return false
end

local function recipe_effective_level_for_skill(recipe, skill_name)
    if type(recipe) ~= 'table' then
        return 0
    end

    local normalized_skill = tostring(skill_name or ''):lower()
    local recipe_skill = tostring(recipe.skill or ''):lower()
    if normalized_skill ~= '' and recipe_skill == normalized_skill then
        return tonumber(recipe.level) or 0
    end

    if type(recipe.subcraft) == 'table' then
        for _, subcraft_entry in ipairs(recipe.subcraft) do
            local entry_text = tostring(subcraft_entry or '')
            local entry_skill, entry_level = entry_text:match('^%s*(.-)%s*%((%d+)%)%s*$')
            if entry_skill and entry_skill:lower() == normalized_skill then
                return tonumber(entry_level) or 0
            end
        end
    end

    return tonumber(recipe.level) or 0
end

function M.get_recipes_for_skill_and_rank(skill_name, rank)
    ensure_recipes_loaded()

    if type(skill_name) ~= 'string' or skill_name == '' then
        return { }
    end

    local source = recipes_by_skill[skill_name] or { }
    local min_level = 0
    local max_level = math.huge
    if type(rank) == 'table' then
        min_level = tonumber(rank.min) or 0
        max_level = tonumber(rank.max) or 0
    end

    local filtered = { }
    local seen = { }

    for _, recipe in ipairs(source) do
        local level = tonumber(recipe.level) or 0
        if level >= min_level and level <= max_level then
            filtered[#filtered + 1] = recipe
            seen[recipe] = true
        end
    end

    for other_skill, recipe_list in pairs(recipes_by_skill) do
        if other_skill ~= skill_name then
            for _, recipe in ipairs(recipe_list) do
                if not seen[recipe] and recipe_subcraft_matches_skill_and_rank(recipe, skill_name, min_level, max_level) then
                    filtered[#filtered + 1] = recipe
                    seen[recipe] = true
                end
            end
        end
    end

    table.sort(filtered, function(a, b)
        local a_level = recipe_effective_level_for_skill(a, skill_name)
        local b_level = recipe_effective_level_for_skill(b, skill_name)
        if a_level == b_level then
            local a_name = tostring(a.name or '')
            local b_name = tostring(b.name or '')
            if a_name == b_name then
                local a_main = tonumber(a.level) or 0
                local b_main = tonumber(b.level) or 0
                return a_main < b_main
            end
            return a_name < b_name
        end
        return a_level < b_level
    end)

    return filtered
end

function M.update_details_cache(xidb, deps)
    local sel_id = xidb.db.selected_id or -1
    local entry = xidb.db.items_by_id[sel_id]
    if entry == nil then
        M.details_cache.selected_id = sel_id
        M.details_cache.entry = nil
        M.details_cache.item_name = ''
        M.details_cache.tex_id = nil
        return
    end

    M.details_cache.selected_id = sel_id
    M.details_cache.entry = entry

    local item_name = entry.name or ''
    local name_lookup = deps.get_item_name_by_id(entry.id)
    if name_lookup and name_lookup ~= '' then
        item_name = name_lookup
    end
    M.details_cache.item_name = item_name

    local tex_id = nil
    if xidb.settings.show_icons[1] then
        local ok, tid = pcall(function()
            return deps.itemicon.load(entry.id)
        end)
        if ok and tid and type(tid) == 'number' then
            tex_id = tid
        elseif not ok then
            deps.print_error(('Failed to load texture for item %d'):fmt(entry.id))
        end
    end

    M.details_cache.tex_id = tex_id
end

return M