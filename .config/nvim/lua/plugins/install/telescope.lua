--=================================================================================================
--Нечеткий поиск по файлам
--https://github.com/nvim-telescope/telescope.nvim
--=================================================================================================
local function config()
  local telescope = require("telescope")
  telescope.setup({
    -- defaults = {
    -- 	path_display = {
    -- 		shorten = {
    -- 			len = 3,
    -- 			exclude = { 1, -1 },
    -- 		},
    -- 		truncate = true,
    -- 	},
    -- 	dynamic_preview_title = true,
    -- 	mappings = {
    -- 		n = {
    -- 			["<c-d>"] = require("telescope.actions").delete_buffer,
    -- 		},
    -- 		i = {
    -- 			["<c-d>"] = require("telescope.actions").delete_buffer,
    -- 		},
    -- 	},
    -- },
    extensions = {
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
    },
  })
  telescope.load_extension("fzf")
  telescope.load_extension("ui-select")
  telescope.load_extension("dap")
end

return {
  "nvim-telescope/telescope.nvim",
  version = false,
  dependencies = {
    --https://github.com/nvim-telescope/telescope-dap.nvim
    "nvim-telescope/telescope-dap.nvim",
    --https://github.com/nvim-telescope/telescope-fzf-native.nvim
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    --https://github.com/nvim-telescope/telescope-ui-select.nvim
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    config()
    local map = require("util").map
    local builtin = require('telescope.builtin')
    map("n", "<leader>ff", builtin.find_files, "Find file <Telescope>")
    map("n", "<leader>fg", builtin.live_grep, "Grep <Telescope>")
    map("n", "<leader>fb", builtin.buffers, "Find buffer <Telescope>")
    map("n", "<leader>fm", builtin.marks, "Find mark <Telescope>")
    map("n", "<leader>fh", builtin.help_tags, "Find help tags <Telescope>")
    map("n", "<leader>ft", builtin.keymaps, "Find keymaps <Telescope>")

    require("util").register_autocmd("LspAttach", {
    group = "telescope_lsp_keymap",
    callback = function(event)
      local opts = { buffer = event.buf }
      map("n", "<leader>fr", builtin.lsp_references, "Find references (LSP) <Telescope>", opts)
      map("n", "<leader>fs", builtin.lsp_document_symbols, "Find symbols (LSP) <Telescope>", opts)
      map("n", "<leader>fc", builtin.lsp_incoming_calls, "Find incoming calls (LSP) <Telescope>", opts)
      map("n", "<leader>fo", builtin.lsp_outgoing_calls, "Find outgoing calls (LSP) <Telescope>", opts)
      map("n", "<leader>fi", builtin.lsp_implementations, "Find implementations (LSP) <Telescope>", opts)
      map("n", "<leader>fx", function() builtin.diagnostics({ bufnr = 0 }) end, "Find errors (LSP) <Telescope>", opts)
      map("n", "<leader>fX", builtin.diagnostics, "Find errors all (LSP) <Telescope>", opts)
    end,
    })
  end,
}
