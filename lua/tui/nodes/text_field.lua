---@class TextField : BaseComponent
---@field private bufnr? integer
---@field public window_id? integer
---@field private parent? integer
---@field private label? string
---@field private border? Border
---@field private size? Size
---@field private position? Position
local M = {}

---@param textfield_options TextFieldOptions
---@return self
function M:new(textfield_options)
  local obj = {}
  setmetatable(obj, self)
  self.__index = self
  self.label = textfield_options.label
  self.size = textfield_options.size
  self.border = textfield_options.border
  self.position = textfield_options.position
  return self
end

---@class TextFieldOptions
---@field public border? Border
---@field public label? string
---@field public size? Size
---@field public position? Position
---@field public parent? integer

return M
