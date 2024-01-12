--=================================================================================================
--Сниппеты
--https://github.com/L3MON4D3/LuaSnip
--=================================================================================================
return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
 -- dependencies = { "honza/vim-snippets" },
  config = function()
    local map = require("util").map
    local ls = require "luasnip"

    ls.config.set_config {
      updateevents = "TextChanged,TextChangedI",
    }

    map({ "i", "s" }, "<C-k>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, "Somthing <LuaSnip>")

    map({ "i", "s" }, "<C-j>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, "Somthing <LuaSnip>")

    map("i", "<C-l>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, "Somthing <LuaSnip>")


    map("i", "<C-h>", function()
      if ls.choice_active() then
        ls.change_choice(-1)
      end
    end, "Somthing <LuaSnip>")

    require("luasnip.loaders.from_snipmate").lazy_load()

    require("luasnip.loaders.from_lua").lazy_load {
      paths = "~/.config/nvim/snippets/",
    }
  end,
}
