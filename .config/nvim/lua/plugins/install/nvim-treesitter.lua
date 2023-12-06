--=================================================================================================
--Подсветка синтаксиса
--https://github.com/nvim-treesitter/nvim-treesitter
--=================================================================================================
local function config()
  local map = require("util").map
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "vim", "vimdoc", "css", "scss", "bash", "html", "java", "javascript", "xml" },
    sync_install = false,
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
  })
end


return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    config()
  end,
}
