local imgui = require('imgui')

local M = {}

function M.render(_, current_module)
    imgui.TextColored({ 0.95, 0.8, 0.35, 1.0 }, current_module)
    imgui.Spacing()
    imgui.TextWrapped('This module is not implemented yet. Select another Category.')
end

return M
