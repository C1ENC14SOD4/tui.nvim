---@class Window
---@field public bufnr? integer
---@field public window_id? integer
---@field private width? integer
---@field private height? integer
---@field private insert? boolean
---@field private enter? boolean
---@field private pos? Position
---@field private title? Title
---@field private border? Border
---@field private focusable? boolean
local M = {}

---@class WindowOptions
---You can use percentage from 0 to 10. Example "100%" or "30%", which will
---generate a window with given percentage.
---@field public size Size | string
---@field public border? Border
---@field public window_pos? WindowPosition | Position
---@field public title? string | Title
---@field public instant_insert? boolean
---@field public enter_to_window? boolean
---@field public focusable? boolean

---@class Size
---@field public width? integer
---@field public height? integer

---@class Position
---@field public row integer
---@field public col integer

---@class Title
---@field public text string
---@field public position? "left" | "center" | "right"
---@field public highlight? string

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

---@alias Border
---| '"rounded"'
---| '"single"'
---| '"double"'
---| '"none"'
---| '"shadow"'

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
  self.enter = false or obj.enter_to_window
  self.insert = false or obj.instant_insert
  if type(obj.title) == "string" then
    self.title = {
      text = obj.title, ---@diagnostic disable-line
      position = "center",
      highlight = "Title"
    }
  else
    self.title = obj.title ---@diagnostic disable-line
  end
  self.border = obj.border
  self.focusable = obj.focusable
  return object
end

---@param pos WindowPosition
---@return Position
---@private
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
  elseif pos == "bottomcenter" then
    col = (ui.width / 2) - (self.width / 2)
    row = (ui.height - self.height)
  end
  ---@type Position
  return {
    row = row,
    col = col,
  }
end

function M:connect()
  local title = {}
  ---@type string | nil
  local pos = "center"
  if not self.title then
    title = nil
    pos = nil
  else
    table.insert(title, { ' ' .. self.title.text .. ' ', self.title.highlight })
  end
  self.window_id = vim.api.nvim_open_win(self.bufnr, self.enter, {
    relative = 'editor',
    width = self.width,
    height = self.height,
    col = self.pos.col,
    row = self.pos.row,
    style = 'minimal',
    title = title,
    title_pos = pos,
    border = self.border,
    focusable = false or self.focusable
  })
  if self.insert then
    vim.cmd.startinsert()
  end
end

return M
