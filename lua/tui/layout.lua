---@class Window
---@field private bufnr? integer
---@field private window_id? integer
---@field private width? integer
---@field private height? integer
local M = {}

---@class WindowOptions
---@field public size Size | "50%" | string
---@field public border? "single" | "rounded" | "double" | "none"
---@field public window_pos? WindowPosition | Position
---@field public title? string[][]
---@field public instant_insert? boolean
---@field public highlight? string
---@field public enter_to_window? boolean

---@class Size
---@field public width? integer
---@field public height? integer

---@class Position
---@field public row integer
---@field public col integer

---@alias WindowPosition
---| '"topleft"'
---| '"topcenter"'
---| '"topright"'
---| '"centerleft"'
---| '"center"'
---| '"centerright"'
---| '"bottomleft"'
---| '"bottomcenter"'
---| '"bottomright"'

---@param obj? WindowOptions
---@return Window
function M:new(obj)
  obj = obj or {}
  ---@type Window
  local object = {}
  local ui = vim.api.nvim_list_uis()[1]
  local width = 0
  local height = 0
  setmetatable(object, self)
  self.__index = self
  self.bufnr = vim.api.nvim_create_buf(false, true)
  if type(obj.size) == "string" then
    width = math.floor(ui.width / 100 * obj.size:gmatch("[0-9]+")())
    height = math.floor(ui.height / 100 * obj.size:gmatch("[0-9]+")())
    self.width = width
    self.height = height
    print(self.width .. ' ' .. self.height)
  else
    self.width = obj.size.width
    self.height = obj.size.height
  end
  return object
end

return M
