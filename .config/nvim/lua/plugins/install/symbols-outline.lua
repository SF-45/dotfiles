--=================================================================================================
--utLine для LSP
--https://github.com/simrat39/symbols-outline.nvim
--=================================================================================================
return {
  "simrat39/symbols-outline.nvim",
  config = function()
    require("symbols-outline").setup()

    local util = require("util")
    util.register_autocmd("LspAttach", {
    group = "symbols_outline_lsp_keymap",
    callback = function(event)
      local opts = { buffer = event.buf }
      util.map("n", "<leader>co", "<Cmd>SymbolsOutline<CR>", "Outline (LSP) <SymbolsOutline>", opts)
    end,
    })
  end
}
