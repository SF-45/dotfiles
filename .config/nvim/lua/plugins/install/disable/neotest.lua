--=================================================================================================
--Плагин для тестов
--https://github.com/nvim-neotest/neotest
--=================================================================================================
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-plenary",
  },
  lazy = true,
  ft = { "lua" },
  config = function()
    local map = require("util").map
    local neotest = require("neotest")
    neotest.setup {
      adapters = {
        require "neotest-plenary",
      },
    }

    map("n", "<leader>tt", function()
      neotest.run.run()
    end, "Run test <Neotest>")

    map("n", "<leader>tf", function()
      neotest.run.run(vim.fn.expand "%")
    end, "Run test current file <Neotest>")

    map("n", "<leader>ta", function()
      neotest.run.run "."
    end, "Run test (.) <Neotest>")

    map("n", "<leader>ts", function()
      neotest.run.stop()
    end, "Stop test <Neotest>")

    map("n", "<leader>tr", function()
      neotest.summary.toggle()
    end, "Summary (Toggle) <Neotest>")

    map("n", "<leader>to", function()
      neotest.output.open()
    end, "Open output <Neotest>")

    map("n", "<leader>tO", function()
      neotest.output_panel.toggle()
    end, "Output panel (Toggle) <Neotest>")

    map("n", "[c", function()
      neotest.jump.prev()
    end, "Prev test <Neotest>")

    map("n", "]c", function()
      neotest.jump.next()
    end, "Next test <Neotest>")
  end,
}
