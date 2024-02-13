--=================================================================================================
--Анимация отступов
--https://github.com/echasnovski/mini.indentscope
--=================================================================================================
return {
  "echasnovski/mini.indentscope",
  config = function()
    require("mini.indentscope").setup {
      symbol = "│",
      options = { try_as_border = true },
    }
    local autocmd = require("util").register_autocmd

    autocmd("FileType", {
      group = "disable_indentscope",
      pattern = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,

    })
  end
}
