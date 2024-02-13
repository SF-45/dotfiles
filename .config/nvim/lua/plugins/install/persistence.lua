--=================================================================================================
  --Менеджер сессий
  --https://github.com/folke/persistence.nvim
--=================================================================================================
return {
  "folke/persistence.nvim",
  lazy = true,
  event = "BufReadPre",
  opts = {
    options = {
      "buffers",
      "curdir",
      "tabpages",
      "winsize",
      "help",
      "globals",
      "skiprtp",
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session <Persistence>" },
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session <Persistence>" },
    { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session <Persistence>" },
  },
}
