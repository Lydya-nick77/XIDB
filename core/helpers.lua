local M = {}

function M.trim(value)
    if type(value) ~= 'string' then
        return ''
    end

    return value:match('^%s*(.-)%s*$') or ''
end

function M.lower(value)
    return string.lower(M.trim(value))
end

function M.table_text(value)
    if type(value) == 'table' then
        return M.trim(value[1] or value[2] or value[3] or '')
    end

    if value == nil then
        return ''
    end

    return M.trim(tostring(value))
end

function M.to_number(value, fallback)
    if type(value) == 'number' then
        return value
    end

    local num = tonumber(value)
    if num == nil then
        return fallback or 0
    end

    return num
end

return M
