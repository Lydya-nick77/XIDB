local M = {}

local function get_resource_manager()
    return AshitaCore:GetResourceManager()
end

local function get_item_by_id(resources, id)
    local ok, item = pcall(function()
        if type(resources.GetItemById) == 'function' then
            return resources:GetItemById(id)
        end
        if type(resources.GetItemByID) == 'function' then
            return resources:GetItemByID(id)
        end
        return nil
    end)

    if not ok then
        return nil
    end

    return item
end

function M.get_item_name_by_id(id)
    if id == nil then
        return nil
    end

    local resources = get_resource_manager()
    if resources == nil then
        return nil
    end

    local ok, value = pcall(function()
        return resources:GetString('items.names', id)
    end)
    if ok and type(value) == 'string' and value ~= '' then
        return value
    end

    local item = get_item_by_id(resources, id)
    if item == nil then
        return nil
    end

    if type(item) == 'table' and type(item.Name) == 'table' then
        local candidate = item.Name[1] or item.Name[0] or item.Name[2]
        if type(candidate) == 'string' and candidate ~= '' then
            return candidate
        end
    end

    local probes = {
        function() return item.Name and item.Name[1] end,
        function() return item.Name and item.Name:get() end,
        function() return tostring(item.Name) end,
        function() return tostring(item) end,
    }

    for _, probe in ipairs(probes) do
        local ok_probe, probe_value = pcall(probe)
        if ok_probe and type(probe_value) == 'string' and probe_value ~= '' then
            return probe_value
        end
    end

    return nil
end

function M.get_item_description_by_id(id)
    if id == nil then
        return nil
    end

    local resources = get_resource_manager()
    if resources == nil then
        return nil
    end

    local ok, value = pcall(function()
        return resources:GetString('items.descriptions', id)
    end)
    if ok and type(value) == 'string' and value ~= '' then
        return value
    end

    local item = get_item_by_id(resources, id)
    if item == nil then
        return nil
    end

    if type(item) == 'table' and type(item.Description) == 'table' then
        return item.Description[1] or item.Description[0] or item.Description[2]
    end

    local probes = {
        function() return item.Description and item.Description[1] end,
        function() return item.Description and item.Description:get() end,
        function() return tostring(item.Description) end,
        function() return tostring(item) end,
    }

    for _, probe in ipairs(probes) do
        local ok_probe, probe_value = pcall(probe)
        if ok_probe and type(probe_value) == 'string' and probe_value ~= '' then
            return probe_value
        end
    end

    return nil
end

function M.get_item_logname_by_id(id, field)
    if id == nil or field == nil then
        return nil
    end

    local resources = get_resource_manager()
    if resources == nil then
        return nil
    end

    local item = get_item_by_id(resources, id)
    if item == nil then
        return nil
    end

    if type(item) == 'table' and type(item[field]) == 'table' then
        return item[field][1] or item[field][0] or item[field][2]
    end

    local probes = {
        function() return item[field] and item[field][1] end,
        function() return item[field] and item[field]:get() end,
        function() return tostring(item[field]) end,
    }

    for _, probe in ipairs(probes) do
        local ok_probe, probe_value = pcall(probe)
        if ok_probe and type(probe_value) == 'string' and probe_value ~= '' then
            return probe_value
        end
    end

    return nil
end

return M
