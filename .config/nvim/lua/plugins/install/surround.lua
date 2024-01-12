--=================================================================================================
--Автозакрытие ковычек, скобочек и всего такого
--https://github.com/kylechui/nvim-surround
--=================================================================================================
return {
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        move_cursor = false,
      }
    end,
  },
}
