Window = require("tui.utils.layout")

---@class Input
local M = {}

---@class InputOptions
---This will be th size for width only. NOTE: height always will be 1.
---@field public size integer
---@field public prompt string
---@field public border? "rounded" | "single" | "double" | "none"
---This will be a funcion that will be executed when <CR> will be pressed. args are [text] only.
---@field public callback function

---@param options InputOptions
function M:new(options)

end
