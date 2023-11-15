---@class Window
---@field private bufnr? integer
---@field private window_id? integer
---@field private width? integer
---@field private height? integer
---@field private insert? boolean
---@field private enter? boolean
---@field private pos? Position
---@field private title? string[][]
---@field private border? "single" | "rounded" | "double" | "none"
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
    ---@diagnostic disable-next-line
    width = math.floor(ui.width / 100 * obj.size:gmatch("[0-9]+")())
    ---@diagnostic disable-next-line
    height = math.floor(ui.height / 100 * obj.size:gmatch("[0-9]+")())
    self.width = width
    self.height = height
    print(self.width .. ' ' .. self.height)
  else
    self.width = obj.size.width
    self.height = obj.size.height
  end
  if type(obj.window_pos) == "string" then
    ---@diagnostic disable-next-line
    self.pos = self:position(obj.window_pos)
  else
    ---@diagnostic disable-next-line
    self.pos = obj.window_pos
  end
  self.enter = obj.enter_to_window or true
  self.insert = obj.instant_insert or true
  self.title = obj.title
  self.border = obj.border
  return object
end

---@param pos WindowPosition
---@return Position
function M:position(pos)
  ---@type integer
  local row, col
  local ui = vim.api.nvim_list_uis()[1]
  if pos == "center" then
    col = (ui.width / 2) - (self.width / 2)
    row = (ui.height / 2) - (self.height / 2)
  elseif pos == "topleft" then
    col = 0
    row = 0
  elseif pos == "topright" then
    col = (ui.width - self.width)
    row = 0
  elseif pos == "topcenter" then
    col = (ui.width / 2) - (self.width / 2)
    row = 0
  elseif pos == "centerleft" then
    col = 0
    row = (ui.height / 2) - (self.height / 2)
  elseif pos == "bottomleft" then
    col = 0
    row = (ui.height - self.height)
  elseif pos == "centerright" then
    col = (ui.width - self.width)
    row = (ui.height / 2) - (self.height / 2)
  elseif pos == "bottomright" then
    col = (ui.width - self.width)
    row = (ui.height - self.height)
  end
  ---@type Position
  return {
    row = row,
    col = col,
  }
end

function M:connect()
  self.window_id = vim.api.nvim_open_win(self.bufnr, self.enter, {
    relative = 'editor',
    width = self.width,
    height = self.height,
    col = self.pos.col,
    row = self.pos.row,
    style = 'minimal',
    title = self.title,
    border = self.border,
  })
  if self.insert then
    vim.cmd.startinsert()
  end
end

return M
