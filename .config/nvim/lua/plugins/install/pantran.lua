--=================================================================================================
--Переводчик
--https://github.com/potamides/pantran.nvim
--=================================================================================================
local function config()
  require("pantran").setup({
    default_engine = "yandex",
    engines = {
      yandex = {
        default_source = "auto",
        default_target = "ru",
        fallback = {
          default_source = "auto",
          default_target = "ru",
        },
      },
      google = {
        default_source = "auto",
        default_target = "ru",
        fallback = {
          default_source = "auto",
          default_target = "ru",
        },
      },
    },
  })
end

return {
  "potamides/pantran.nvim",
  lazy = true,
  keys = {
    {"<leader>tr", desc = "Translate <Pantran>", mode = {"n", "x"}}
  },
  config = function()
    config()
    local map = require("util").map
    local pantran = require("pantran")
    map({ "n", "x" }, "<leader>tr", pantran.motion_translate, "Translate <Pantran>", { expr = true })
  end,
}
