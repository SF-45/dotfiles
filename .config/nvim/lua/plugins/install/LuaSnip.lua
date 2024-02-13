--=================================================================================================
--Сниппеты
--https://github.com/L3MON4D3/LuaSnip
--=================================================================================================
--=================================================================================================
--Наборы сниппетов
--https://github.com/rafamadriz/friendly-snippets
--=================================================================================================
return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
 -- dependencies = { "rafamadriz/friendly-snippets" },
 dependencies = { "honza/vim-snippets" },
  config = function()
    local map = require("util").map
    local ls = require "luasnip"

    ls.config.set_config {
      updateevents = "TextChanged,TextChangedI",
    }


    map({ "i", "s" }, "<Tab>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, "Next element <LuaSnip>")

    map({ "i", "s" }, "<S-Tab>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, "Prev element <LuaSnip>")
    -- map({ "i", "s" }, "<C-h>", function()
    --   if ls.jumpable(-1) then
    --     ls.jump(-1)
    --   end
    -- end, "Prev element <LuaSnip>")
    --
    -- map({ "i", "s" }, "<C-l>", function()
    --   if ls.expand_or_jumpable() then
    --     ls.expand_or_jump()
    --   end
    -- end, "Next element <LuaSnip>")

    map("i", "<C-j>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, "Choose Next vraiable <LuaSnip>")


    map("i", "<C-k>", function()
      if ls.choice_active() then
        ls.change_choice(-1)
      end
    end, "Choose Prev vraiable <LuaSnip>")

    require("luasnip.loaders.from_snipmate").lazy_load()
    -- require("luasnip.loaders.from_vscode").lazy_load()

    require("luasnip.loaders.from_lua").lazy_load {
      paths = { "~/.config/nvim/snippets/" },
    }
  end,
}
