---@class TextField
---@field private label string
---@field private default? string
local M = {}

---@class TextFieldOptions
---@field public label string
---@field public default? string

---@param options TextFieldOptions
function M:new(options)
  if not options.default then
    self.default = ""
  end
  self.label = options.label
end
