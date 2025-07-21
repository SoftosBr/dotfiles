return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local config = require("lualine")
    config.setup({
      theme = 'wal',
    })
  end
}
