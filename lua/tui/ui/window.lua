TextField = require("tui.nodes.text_field")

---@class Widnow
---@field private bufnr? integer
---@field private window? integer
local M = {}

---@param options Options
---@param extra_options ExtraOptions
---@return self
function M:new(options, extra_options)
  local obj = {}
  setmetatable(obj, self)
  self.__index = self
  self.bufnr = vim.api.nvim_create_buf(false, true)
  self.window = vim.api.nvim_open_win(self.bufnr, extra_options.enter_to_window, {
    relative = 'editor',
    width = options.size.width,
    height = options.size.height,
    row = options.position.row,
    col = options.position.col,
    style = 'minimal',
    title = {
      { options.title.text, options.title.highlight }
    },
    title_pos = options.title.position,
    border = options.border,
  })
  return obj
end

---@class Options
---@field public size Size
---@field public position Position
---@field public title Title | nil
---@field public border? Border

---@class ExtraOptions
---@field public insert_on_init boolean
---@field public enter_to_window boolean

---@class Size
---@field public width integer
---@field public height integer

---@class Title
---@field public text? string
---@field public highlight? string
---@field public position? TitlePosition

---@class Position
---@field public row integer
---@field public col integer

---@alias TitlePosition
---| '"center"'
---| '"left"'
---| '"right"'

---@alias Border
---| '"none"'
---| '"single"'
---| '"rounded"'
---| '"double"'
---| '"shadow"'
---| '"solid"'

---@param node TextField
function M:append_node(node)

end

return M
