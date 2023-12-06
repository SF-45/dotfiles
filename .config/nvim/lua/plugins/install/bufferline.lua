--=================================================================================================
--Вкладки
--https://github.com/akinsho/bufferline.nvim
--=================================================================================================
local function config()
  require("bufferline").setup({
    options = {
      --mode = "buffers",
      always_show_bufferline = false,
      close_command = function(n)
        require("mini.bufremove").delete(n, false)
      end,
      right_mouse_command = function(n)
        require("mini.bufremove").delete(n, false)
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-Tree",
          separator = false,
          text_align = "left",
          highlight = "Directory",
        },
      },
      diagnostics = "nvim_lsp",
      indicator = {
        icon = "  ", -- this should be omitted if indicator style is not 'icon'
        style = "icon",
      },
      sort_by = "insert_at_end",
    },
  })
end

return {

  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    config()
    local map = require("util").map
    map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", "Prev buffer <BufferLine>")
    map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", "Next buffer <BufferLine>")
    map("n", "<S-Right>", "<cmd>BufferLineMoveNext<cr>", "Move buffer right <BufferLine>")
    map("n", "<S-Left>", "<cmd>BufferLineMovePrev<cr>", "Move buffer right <BufferLine>")

    map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", "Prev buffer <BufferLine>")
    map("n", "]b", "<cmd>BufferLineCycleNext<cr>", "Next buffer <BufferLine>")
    map("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", "Toggle pin <BufferLine>")
    map("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", "Delete non-pinned buffers <BufferLine>")
    map("n", "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", "Delete other buffers <BufferLine>")
  end,
}
