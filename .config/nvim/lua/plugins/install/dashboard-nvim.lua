--=================================================================================================
--Стартовое окно
--https://github.com/nvimdev/dashboard-nvim?tab=readme-ov-file
--=================================================================================================
local function default_header()
  return {
    '', '', '',
    '███████╗ █████╗ ██████╗ ███████╗ ██████╗ ██╗  ██╗',
    '██╔════╝██╔══██╗██╔══██╗██╔════╝██╔═══██╗╚██╗██╔╝',
    '███████╗███████║██║  ██║█████╗  ██║   ██║ ╚███╔╝ ',
    '╚════██║██╔══██║██║  ██║██╔══╝  ██║   ██║ ██╔██╗ ',
    '███████║██║  ██║██████╔╝██║     ╚██████╔╝██╔╝ ██╗',
    '╚══════╝╚═╝  ╚═╝╚═════╝ ╚═╝      ╚═════╝ ╚═╝  ╚═╝',
    '', '', ''
  }
end
return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      disable_move = true,
      config = {
        header = default_header(),
        -- stylua: ignore
        center = {
          { action = "Neotree float", desc = " Find explore", icon = "󰙅 ", key = "e" },
          { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
          { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
          { action = [[lua require("telescope").extensions.projects.projects{}]], desc = " Projects", icon = " ", key = "p" },
          { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
          { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
          { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
          { action = 'lua require("persistence").load({ last = true })', desc = " Restore Last Session", icon = " ", key = "S" },
          { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
          { action = "qa", desc = " Quit", icon = " ", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
