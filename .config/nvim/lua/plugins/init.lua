require("util").map("n", "<leader>l", "<cmd>Lazy<cr>", "Lazy <Lazy>")
require("lazy").setup("plugins.install", {
  change_detection = {
    enabled = false,
    notify = false,     -- get a notification when changes are found
  },
  defaults = { lazy = false },
  --install = { colorscheme = { "tokyonight", "habamax" } },
  performance = {
    cache = {
      enabled = true,
      -- disable_events = {},
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        --[[ "matchit", ]]
        --[[ "matchparen", ]]
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        --"tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    size = { width = 0.9, height = 0.9 },
    border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
  },
  checker = {
    -- automatically check for plugin updates
    enabled = false,
  },
})
