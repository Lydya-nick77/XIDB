local imgui = require('imgui')
local fonts = require('fonts')
local ffi = require('ffi')
local d3d8 = require('d3d8')
local zones = require('zones')

local C = ffi.C

local M = { }

local map_texture_by_path = { }
local map_texture_by_zone = { }
local map_dimensions_by_path = { }
local map_options_by_zone = { }
local zones_by_area_cache = { }
local MAP_EXTENSIONS = { '.jpg', '.jpeg', '.png', '.bmp' }

local function read_u16be(bytes, index)
    local a, b = bytes:byte(index, index + 1)
    if not a or not b then
        return nil
    end
    return (a * 256) + b
end

local function read_u32be(bytes, index)
    local a, b, c, d = bytes:byte(index, index + 3)
    if not a or not b or not c or not d then
        return nil
    end
    return (((a * 256) + b) * 256 + c) * 256 + d
end

local function read_u32le(bytes, index)
    local a, b, c, d = bytes:byte(index, index + 3)
    if not a or not b or not c or not d then
        return nil
    end
    return (((d * 256) + c) * 256 + b) * 256 + a
end

local function get_image_dimensions_from_jpeg(path)
    local f = io.open(path, 'rb')
    if not f then
        return nil, nil
    end

    local ok, width, height = pcall(function()
        local data = f:read('*a') or ''
        if #data < 4 or data:byte(1) ~= 0xFF or data:byte(2) ~= 0xD8 then
            return nil, nil
        end

        local i = 3
        while i <= #data - 9 do
            if data:byte(i) == 0xFF then
                local marker = data:byte(i + 1)
                if marker and marker ~= 0xFF and marker ~= 0x00 then
                    if marker == 0xD9 or marker == 0xDA then
                        break
                    end

                    local segment_len = read_u16be(data, i + 2)
                    if not segment_len or segment_len < 2 then
                        return nil, nil
                    end

                    local is_sof = (marker >= 0xC0 and marker <= 0xC3)
                        or (marker >= 0xC5 and marker <= 0xC7)
                        or (marker >= 0xC9 and marker <= 0xCB)
                        or (marker >= 0xCD and marker <= 0xCF)

                    if is_sof then
                        local h = read_u16be(data, i + 5)
                        local w = read_u16be(data, i + 7)
                        if w and h and w > 0 and h > 0 then
                            return w, h
                        end
                        return nil, nil
                    end

                    i = i + 2 + segment_len
                else
                    i = i + 1
                end
            else
                i = i + 1
            end
        end

        return nil, nil
    end)

    f:close()
    if not ok then
        return nil, nil
    end

    return width, height
end

local function get_image_dimensions(path)
    if map_dimensions_by_path[path] ~= nil then
        local cached = map_dimensions_by_path[path]
        return cached.width, cached.height
    end

    local f = io.open(path, 'rb')
    if not f then
        map_dimensions_by_path[path] = { width = nil, height = nil }
        return nil, nil
    end

    local header = f:read(64) or ''
    f:close()

    local width = nil
    local height = nil

    -- PNG: width/height are 32-bit big-endian in IHDR.
    if #header >= 24 and header:sub(1, 8) == '\137PNG\r\n\26\n' then
        width = read_u32be(header, 17)
        height = read_u32be(header, 21)
    -- BMP: width/height are little-endian in BITMAPINFOHEADER.
    elseif #header >= 26 and header:sub(1, 2) == 'BM' then
        width = read_u32le(header, 19)
        height = read_u32le(header, 23)
        if height and height < 0 then
            height = math.abs(height)
        end
    -- JPEG: dimensions are stored in SOF markers.
    elseif #header >= 2 and header:byte(1) == 0xFF and header:byte(2) == 0xD8 then
        width, height = get_image_dimensions_from_jpeg(path)
    end

    if width and height and width > 0 and height > 0 then
        map_dimensions_by_path[path] = { width = width, height = height }
        return width, height
    end

    map_dimensions_by_path[path] = { width = nil, height = nil }
    return nil, nil
end

local function normalize_area_name(name)
    return (tostring(name or ''):match('^%s*(.-)%s*$') or '')
end

local function zone_name_to_slug(zone_name)
    local slug = tostring(zone_name or '')
    slug = slug:gsub("'", "")
    slug = slug:lower()
    slug = slug:gsub("[^%w]+", "_")
    slug = slug:gsub("^_+", "")
    slug = slug:gsub("_+$", "")
    return slug
end

local function build_map_path_candidates(zone_name)
    local addon_path = ''
    if addon and addon.path then
        addon_path = tostring(addon.path)
    end

    local base = ('%sassets/maps/'):fmt(addon_path)
    local raw_name = tostring(zone_name or '')
    
    if raw_name == '' then
        return { }
    end
    
    local no_apostrophe = raw_name:gsub("'", '')
    local underscored = raw_name:gsub('%s+', '_')
    local slug = zone_name_to_slug(raw_name)

    local stems = {
        raw_name,
        no_apostrophe,
        underscored,
        no_apostrophe:gsub('%s+', '_'),
        slug,
    }

    local seen = { }
    local candidates = { }
    local extensions = MAP_EXTENSIONS

    for _, stem in ipairs(stems) do
        local normalized_stem = tostring(stem or ''):match('^%s*(.-)%s*$') or ''
        if normalized_stem ~= '' and not seen[normalized_stem] then
            seen[normalized_stem] = true
            for _, ext in ipairs(extensions) do
                candidates[#candidates + 1] = ('%s%s%s'):fmt(base, normalized_stem, ext)
            end
        end
    end

    return candidates
end

local SUFFIX_PATTERNS = nil

local function get_suffix_patterns()
    if SUFFIX_PATTERNS then
        return SUFFIX_PATTERNS
    end
    
    local suffixes = { '' }
    for i = 1, 12 do
        suffixes[#suffixes + 1] = ('_%d'):fmt(i)
        suffixes[#suffixes + 1] = ('-%d'):fmt(i)
        suffixes[#suffixes + 1] = (' %d'):fmt(i)
        suffixes[#suffixes + 1] = ('(%d)'):fmt(i)
    end
    
    SUFFIX_PATTERNS = suffixes
    return suffixes
end

local function build_map_option_candidates(zone_name)
    local addon_path = ''
    if addon and addon.path then
        addon_path = tostring(addon.path)
    end

    local base = ('%sassets/maps/'):fmt(addon_path)
    local raw_name = tostring(zone_name or '')
    
    if raw_name == '' then
        return { }
    end
    
    local no_apostrophe = raw_name:gsub("'", '')
    local underscored = raw_name:gsub('%s+', '_')
    local slug = zone_name_to_slug(raw_name)

    local stems = {
        raw_name,
        no_apostrophe,
        underscored,
        no_apostrophe:gsub('%s+', '_'),
        slug,
    }

    local suffixes = get_suffix_patterns()
    local seen = { }
    local candidates = { }
    local extensions = MAP_EXTENSIONS

    for _, stem in ipairs(stems) do
        local normalized_stem = tostring(stem or ''):match('^%s*(.-)%s*$') or ''
        if normalized_stem ~= '' then
            for _, suffix in ipairs(suffixes) do
                local with_suffix = normalized_stem .. suffix
                for _, ext in ipairs(extensions) do
                    local path = ('%s%s%s'):fmt(base, with_suffix, ext)
                    local key = path:lower()
                    if not seen[key] then
                        seen[key] = true
                        candidates[#candidates + 1] = path
                    end
                end
            end
        end
    end

    return candidates
end

local function file_exists(path)
    local f = io.open(path, 'rb')
    if f ~= nil then
        f:close()
        return true
    end
    return false
end

local function load_texture_from_file(path)
    if map_texture_by_path[path] ~= nil then
        return map_texture_by_path[path]
    end

    local d3d8dev = d3d8.get_device()
    if not d3d8dev then
        return nil
    end

    local texture_ptr = ffi.new('IDirect3DTexture8*[1]')
    local hr = C.D3DXCreateTextureFromFileA(d3d8dev, path, texture_ptr)
    if hr ~= C.S_OK or texture_ptr[0] == nil then
        return nil
    end

    local ok, texture_id = pcall(function()
        return tonumber(ffi.cast('uint32_t', texture_ptr[0]))
    end)

    if not ok or not texture_id then
        return nil
    end

    map_texture_by_path[path] = texture_id
    return texture_id
end

local function get_map_options_for_zone(zone_name)
    if map_options_by_zone[zone_name] ~= nil then
        return map_options_by_zone[zone_name]
    end

    local options = { }
    local option_candidates = build_map_option_candidates(zone_name)
    local option_index = 0

    for _, path in ipairs(option_candidates) do
        if file_exists(path) then
            option_index = option_index + 1
            options[#options + 1] = {
                label = ('Map %d'):fmt(option_index),
                path = path,
            }
        end
    end

    map_options_by_zone[zone_name] = options
    return options
end

local function try_get_zone_map(zone_name)
    -- Check zone-based cache first (instant retrieval)
    if map_texture_by_zone[zone_name] then
        return map_texture_by_zone[zone_name]
    end

    -- Fallback: Try local files if DAT extraction failed
    local candidates = build_map_path_candidates(zone_name)
    for _, candidate_path in ipairs(candidates) do
        if file_exists(candidate_path) then
            local texture_id = load_texture_from_file(candidate_path)
            if texture_id then
                return texture_id, candidate_path
            end
        end
    end

    return nil, candidates[1]
end

local function get_zones_for_area(area_name)
    local target_area = normalize_area_name(area_name)
    if target_area == '' then
        return { }
    end

    local cache_key = target_area:lower()
    if zones_by_area_cache[cache_key] ~= nil then
        return zones_by_area_cache[cache_key]
    end

    local list = { }
    local seen = { }

    for _, zone in ipairs(zones.list or { }) do
        if type(zone) == 'table' then
            local zone_area = normalize_area_name(zone.area)
            local zone_name = tostring(zone.name or '')
            if zone_area ~= '' and zone_name ~= '' then
                local zone_area_lower = zone_area:lower()
                local zone_name_lower = zone_name:lower()
                if zone_area_lower == cache_key and not seen[zone_name_lower] then
                    seen[zone_name_lower] = true
                    list[#list + 1] = zone_name
                end
            end
        end
    end

    table.sort(list, function(a, b)
        return a:lower() < b:lower()
    end)

    zones_by_area_cache[cache_key] = list
    return list
end

local function draw_centered_message(text)
    local content = tostring(text or '')
    local available_width, available_height = imgui.GetContentRegionAvail()
    local text_width = fonts.MeasureText(content, 18, fonts.SCALES.LARGE)
    local text_height = nil

    fonts.WithFont(18, function()
        text_height = imgui.GetTextLineHeight()
    end)

    text_height = text_height or imgui.GetTextLineHeight()

    local start_x = imgui.GetCursorPosX()
    local start_y = imgui.GetCursorPosY()
    local x_offset = math.max(0, (available_width - text_width) / 2)
    local y_offset = math.max(0, (available_height - text_height) / 2)

    imgui.SetCursorPosX(start_x + x_offset)
    imgui.SetCursorPosY(start_y + y_offset)
    fonts.TextPx(content, 18, fonts.SCALES.LARGE)
end

function M.render(ctx)
    local state = ctx.state
    local selected_area = normalize_area_name(ctx.get_current_subcategory_name())
    local is_area_selected = (state.selected_subcategory_index > 1 and selected_area ~= '' and selected_area ~= 'Select Sub Category')

    if is_area_selected then
        local area_key = selected_area:lower()
        if state.selected_map_area_key ~= area_key then
            state.selected_map_area_key = area_key
            state.selected_map_zone_index = 1
        end
    else
        state.selected_map_area_key = nil
    end

    imgui.BeginChild('xidb_maps_zones_list', { 280, -1, }, true)
        fonts.Title('Zones')
        imgui.Separator()

        if not is_area_selected then
            fonts.TextWrappedPx('Select an area in Sub Category to list zones.', fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE)
        else
            local zones_for_area = get_zones_for_area(selected_area)

            if #zones_for_area == 0 then
                fonts.TextWrappedPx('No zones found for this area.', fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE)
            else
                if state.selected_map_zone_index < 1 or state.selected_map_zone_index > #zones_for_area then
                    state.selected_map_zone_index = 1
                end

                fonts.WithFont(18, function()
                    for i, zone_name in ipairs(zones_for_area) do
                        local label = ('%s##map_zone_%d'):fmt(zone_name, i)
                        if imgui.Selectable(label, state.selected_map_zone_index == i) then
                            state.selected_map_zone_index = i
                        end
                    end
                end)
            end
        end
    imgui.EndChild()

    imgui.SameLine()

    imgui.BeginChild('xidb_maps_zone_display', { 0, -1, }, true)
        fonts.Title('Map Preview')
        imgui.Separator()

        if not is_area_selected then
            fonts.TextWrappedPx('Choose an area to preview maps.', fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE)
        else
            local zones_for_area = get_zones_for_area(selected_area)
            if #zones_for_area == 0 then
                fonts.TextWrappedPx('No map available.', fonts.COLORS.WHITE, 18, fonts.SCALES.LARGE)
            else
                if state.selected_map_zone_index < 1 or state.selected_map_zone_index > #zones_for_area then
                    state.selected_map_zone_index = 1
                end

                local selected_zone = zones_for_area[state.selected_map_zone_index]
                if state.selected_map_preview_zone ~= selected_zone then
                    state.selected_map_preview_zone = selected_zone
                    state.selected_map_preview_index = 1
                end

                local map_options = get_map_options_for_zone(selected_zone)
                fonts.RecipeName(selected_zone)
                if #map_options > 0 then
                    if state.selected_map_preview_index == nil then
                        state.selected_map_preview_index = 1
                    end
                    if state.selected_map_preview_index < 1 or state.selected_map_preview_index > #map_options then
                        state.selected_map_preview_index = 1
                    end

                    local combo_width = 260
                    imgui.SameLine()
                    local current_x = imgui.GetCursorPosX()
                    local avail_width = imgui.GetContentRegionAvail()
                    imgui.SetCursorPosX(current_x + math.max(0, avail_width - combo_width))
                    imgui.SetNextItemWidth(combo_width)
                    local selected_option = map_options[state.selected_map_preview_index]
                    fonts.WithFont(18, function()
                        if imgui.BeginCombo('##xidb_map_variant', selected_option.label, ImGuiComboFlags_None) then
                            for i, option in ipairs(map_options) do
                                local is_selected = (state.selected_map_preview_index == i)
                                if imgui.Selectable(option.label, is_selected) then
                                    state.selected_map_preview_index = i
                                end
                                if is_selected then
                                    imgui.SetItemDefaultFocus()
                                end
                            end
                            imgui.EndCombo()
                        end
                    end)
                end
                imgui.Separator()

                local texture_id = nil
                local selected_path = nil
                if #map_options > 0 then
                    selected_path = map_options[state.selected_map_preview_index].path
                    texture_id = load_texture_from_file(selected_path)
                else
                    texture_id, selected_path = try_get_zone_map(selected_zone)
                end
                if texture_id then
                    local available_width, available_height = imgui.GetContentRegionAvail()
                    local draw_width = available_width
                    local draw_height = available_height

                    local source_width, source_height = nil, nil
                    if selected_path and selected_path ~= '' then
                        source_width, source_height = get_image_dimensions(selected_path)
                    end

                    if source_width and source_height then
                        local scale = math.min(available_width / source_width, available_height / source_height)
                        if scale > 0 then
                            draw_width = math.max(1, source_width * scale)
                            draw_height = math.max(1, source_height * scale)
                        end
                    end

                    local start_x = imgui.GetCursorPosX()
                    local start_y = imgui.GetCursorPosY()
                    local x_offset = math.max(0, (available_width - draw_width) / 2)
                    local y_offset = math.max(0, (available_height - draw_height) / 2)
                    imgui.SetCursorPosX(start_x + x_offset)
                    imgui.SetCursorPosY(start_y + y_offset)
                    imgui.Image(texture_id, { draw_width, draw_height }, { 0, 0 }, { 1, 1 }, { 1, 1, 1, 1 }, { 0, 0, 0, 0 })
                else
                    draw_centered_message('No map image found for this zone yet.')
                end
            end
        end
    imgui.EndChild()
end

return M
