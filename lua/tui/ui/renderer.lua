---@param node BaseComponent
---@param options Options
---@param extra_options ExtraOptions
return function(node, options, extra_options)
  options = vim.tbl_extend('keep', options, require("tui.config.defaults"))
  node.window_id = vim.api.nvim_open_win(node.bufnr, extra_options.enter_to_window, {
    relative = 'window',
    win = node.parent,
    border = node.border,
    width = node.size.width,
    height = node.size.height,
    row = node.position.row,
    col = node.position.col,
    title = node.title and {
      { node.title.text, node.title.highlight }
    } or nil,
    title_pos = node.title.position,
    style = 'minimal',
  })
end
