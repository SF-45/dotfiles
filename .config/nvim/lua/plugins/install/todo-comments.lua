--=================================================================================================
--Находит и перечисляет все комментарии TODO, HACK, BUG и т. д. в вашем проекте и загружает их в список для просмотра.
--https://github.com/folke/todo-comments.nvim
--=================================================================================================
return {
  "folke/todo-comments.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("todo-comments").setup {
      keywords = {
        TODO = {
          alt = { "todo" },
        },
      },
      search = {
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--hidden",
        },
      },
    }

    local map = require("util").map
    map("n", "]t", function()
      require("todo-comments").jump_next()
    end, "Next todo comment <TODO>")

    map("n", "[t", function()
      require("todo-comments").jump_prev()
    end, "Previous todo comment <TODO>")

    map("n", "<leader>ft", ":TodoTelescope<CR>", "find todos in project <TODO>")
  end,
}
