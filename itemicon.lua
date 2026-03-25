local ffi = require('ffi')
local d3d8 = require('d3d8')
local C = ffi.C

-- Simple texture cache to avoid creating textures repeatedly.
local texture_cache = {}

-- Releases all cached textures (best-effort).
local function clear_texture_cache()
    for id, tex in pairs(texture_cache) do
        if tex ~= nil then
            pcall(function()
                if tex.Release then tex:Release() end
            end)
        end
        texture_cache[id] = nil
    end
end

-- Loads and returns an item texture by item id.
-- Returns the Direct3D texture object on success, nil otherwise.
local function xidb_load_item_texture(item_id)
    if not item_id then return nil end
    if texture_cache[item_id] then
        return texture_cache[item_id].id
    end

    local ok, resources = pcall(function() return AshitaCore:GetResourceManager() end)
    if not ok or not resources then return nil end

    local ok2, item = pcall(function() return resources:GetItemById(item_id) end)
    if not ok2 or not item then return nil end
    if not item.Bitmap or not item.ImageSize or item.ImageSize == 0 then
        return nil
    end

    local d3d8dev = d3d8.get_device()
    if not d3d8dev then return nil end
    local texture_ptr = ffi.new('IDirect3DTexture8*[1]')
    local hr = C.D3DXCreateTextureFromFileInMemoryEx(
        d3d8dev,
        item.Bitmap,
        item.ImageSize,
        0xFFFFFFFF,
        0xFFFFFFFF,
        1,
        0,
        C.D3DFMT_A8R8G8B8,
        C.D3DPOOL_MANAGED,
        C.D3DX_DEFAULT,
        C.D3DX_DEFAULT,
        0xFF000000,
        nil,
        nil,
        texture_ptr
    )
    if hr ~= C.S_OK then
        return nil
    end

    local ok, num = pcall(function() return tonumber(ffi.cast('uint32_t', texture_ptr[0])) end)
    if not ok or not num then
        -- store the raw pointer but don't return an id
        texture_cache[item_id] = { tex = texture_ptr[0], id = nil }
        return nil
    end

    texture_cache[item_id] = { tex = texture_ptr[0], id = num }
    return num
end

ashita.events.register('unload', 'xidb_itemicon_unload', function ()
    clear_texture_cache()
end)

return {
    load = xidb_load_item_texture,
    clear = clear_texture_cache,
}
