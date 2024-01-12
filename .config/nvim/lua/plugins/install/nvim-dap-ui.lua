--=================================================================================================
--DAP UI
--https://github.com/rcarriga/nvim-dap-ui
--=================================================================================================
return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  lazy = true,
  keys = {
    "<leader>Du",
    "<leader>DU",
  },
  config = function()
    local dapui = require "dapui"
    local map = require("util").map

    dapui.setup()

    map("n", "<leader>Du", function()
      dapui.toggle { layout = 2 }
    end, "Toggle Simple Debug ui, I mainly use it to run tests <DAP UI>")

    map("n", "<leader>DU", dapui.toggle, "Toggle Full Debug ui <DAP UI>")
  end,
}
