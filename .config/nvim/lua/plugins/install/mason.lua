--=================================================================================================
--Установка lsp
--https://github.com/williamboman/mason.nvim
--=================================================================================================
return {
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup()
    local map = require("util").map
    map("n", "<leader>cm", "<cmd>Mason<cr>", "Mason <P>")
  end,
}
