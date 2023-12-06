--=================================================================================================
--Интеграция с браузером
--https://github.com/glacambre/firenvim
--=================================================================================================
return {
  'glacambre/firenvim',

  -- Lazy load firenvim
  -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
  lazy = not vim.g.started_by_firenvim,
  build = function()
    require("lazy").load { plugins = "firenvim", wait = true }
    vim.fn["firenvim#install"](0)
  end,
  config = function()
    vim.g.firenvim_config = {
      globalSettings = { alt = "all" },
      localSettings = {
        [".*"] = {
          cmdline  = "neovim",
          content  = "text",
          priority = 0,
          selector = "textarea",
          takeover = "never"
        }
      }
    }

    require("util").register_autocmd("UIEnter", {
      group = "firenvim",
      callback = function(event)
        local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
        if client ~= nil and client.name == "Firenvim" then
          vim.o.laststatus = 0
        end
      end
    })
  end,
}
