--=================================================================================================
--Файловый менеджер
--https://github.com/nvim-neo-tree/neo-tree.nvim
--=================================================================================================
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()

    local map = require("util").map
    map("n", "<leader>E", ":Neotree float reveal<CR>", "NeoTree float <NeoTree>")
    map("n", "<leader>e", ":Neotree left toggle<CR>", "NeoTree <NeoTree>")
    map("n", "<leader>o", ":Neotree float git_status<CR>", "NeoTree git_status <NeoTree>")
  end,
}
