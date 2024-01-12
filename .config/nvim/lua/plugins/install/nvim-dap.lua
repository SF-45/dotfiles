--=================================================================================================
--DAP (Debug Adapter Protocol)
--https://github.com/mfussenegger/nvim-dap
--=================================================================================================
return {
  "mfussenegger/nvim-dap",
  lazy = true,
  config = function()
    local dap = require "dap"
    local map = require("util").map

    map("n", "<F5>", dap.continue, "Continue debugging <DAP>")
    map("n", "<F10>", dap.step_over, "Step over <DAP>")
    map("n", "<F11>", dap.step_into, "Step into <DAP>")
    map("n", "<F12>", dap.step_out, "Step out <DAP>")
    map("n", "<leader>Db", dap.toggle_breakpoint, "Toggle Debug breakpoint <DAP>")
    map("n", "<leader>DB", function()
      local condition = vim.fn.input "Breakpoint condition: "
      dap.set_breakpoint(condition)
    end, "Toggle Debug conditional Breakpoint <DAP>")
    map("n", "<F6>", dap.repl.open, "Open REPL <DAP>")
  end,
}
