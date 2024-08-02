--=================================================================================================
--Diff для гита
--https://github.com/sindrets/diffview.nvim
--=================================================================================================
return {
  "sindrets/diffview.nvim",
  lazy = true,
  cmd = {
    "DiffviewOpen",
  },
  keys = {
    "<leader>gdo",
    "<leader>gdO",
    "<leader>gdc",
    "<leader>gdf",
  },
  config = function()
    local map = require("util").map
    map("n", "<leader>gdo", ":DiffviewOpen origin<CR>", "Open diff origin <Diffview>")
    map("n", "<leader>gdO", ":DiffviewOpen <CR>", "Open diff <Diffview>")
    map("n", "<leader>gdc", ":DiffviewClose <CR>", "Close diff <Diffview>")
    map("n", "<leader>gdf", ":DiffviewFileHistory % <CR>", "File History <Diffview>")
  end,

}
