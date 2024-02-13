--=================================================================================================
--Нечеткий поиск по файлам
--https://github.com/nvim-telescope/telescope.nvim
--=================================================================================================
local function config()
  local telescope = require("telescope")
  local telescope_actions = require("telescope.actions")
  local actions_state = require("telescope.actions.state")

  local actions = {}

  actions.xdg_open = function(promt_bufnr)
    local entry = actions_state.get_selected_entry()
    os.execute("xdg-open " .. entry.path .. " & disown")
  end
  telescope.setup({
    defaults = {
      path_display = { "smart" },
      file_ignore_patterns = {
        "node_modules",
        ".git/",
        "target/"
      },
      dynamic_preview_title = true,
      mappings = {
        n = {
          ["q"] = require("telescope.actions").close,
        },
        i = {
          ["<c-q>"] = require("telescope.actions").close,
        },
      },
    },
    pickers = {
      find_files = {
        hidden = true,
        opts = {
          "--smart-case",
        },
        mappings = {
          n = {
            ["<c-o>"] = {
              actions.xdg_open,
              type = "action"
            }
          },
          i = {
            ["<c-o>"] = {
              actions.xdg_open,
              type = "action"
            }
          }
        }
      },
      buffers = {
        sort_lastused = true,
        mappings = {
          n = {
            ["<c-d>"] = require("telescope.actions").delete_buffer,
          },
          i = {
            ["<c-d>"] = require("telescope.actions").delete_buffer,
          }
        },
      },
      live_grep = {
        additional_args = function(opts)
          return {
            "--hidden",
            "--smart-case",
          }
        end,
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      ["ui-select"] = {
        require("telescope.themes").get_ivy {},
      },
    },
  })
  telescope.load_extension("fzf")
  telescope.load_extension("ui-select")
  telescope.load_extension("dap")
  telescope.load_extension('projects')
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
    local autocmd = require("util").register_autocmd
    local builtin = require('telescope.builtin')
    local themes = require("telescope.themes")

    map("n", "<leader>ff", builtin.find_files, "Find file <Telescope>")
    map("n", "<leader>fg", builtin.live_grep, "Grep <Telescope>")
    map("n", "<leader>fc", function() builtin.builtin(themes.get_ivy()) end, "Telescope commands <Telescope>")
    map("n", "<leader>fq", builtin.quickfix, "Find quickfix <Telescope>")
    map("n", "<leader>fl", builtin.loclist, "Find in loc list <Telescope>")
    map("n", "<leader>fb", builtin.buffers, "Find buffer <Telescope>")
    map("n", "<leader><leader>", builtin.buffers, "Find buffer <Telescope>")
    map("n", "<leader>fB", builtin.current_buffer_fuzzy_find, "Find current buffer <Telescope>")
    map("n", "<leader>fM", builtin.marks, "Find mark <Telescope>")
    map("n", "<leader>fh", builtin.help_tags, "Find help tags <Telescope>")
    map("n", "<leader>fm", builtin.man_pages, "Find man pages <Telescope>")
    map("n", "<leader>fC", builtin.commands, "Find commands <Telescope>")
    map("n", "<leader>fk", builtin.keymaps, "Find keymaps <Telescope>")
    map("n", "z=", function() builtin.spell_suggest(themes.get_ivy()) end, "Find spell suggest <Telescope>", { noremap = true })

    map("n", "<leader>fF", builtin.git_files, "Find git file <Telescope>")
    map("n", "<leader>fGb", builtin.git_branches, "Find git branches <Telescope>")
    map("n", "<leader>fGc", builtin.git_commits, "Find git commits <Telescope>")
    map("n", "<leader>fGf", builtin.git_files, "Find git files <Telescope>")


    autocmd("LspAttach", {
      group = "telescope_lsp_keymap",
      callback = function(event)
        local opts = { buffer = event.buf }
        map("n", "<leader>fr", builtin.lsp_references, "Find references (LSP) <Telescope>", opts)
        map("n", "<leader>fs", builtin.lsp_document_symbols, "Find in document symbols (LSP) <Telescope>", opts)
        map("n", "<leader>fS", builtin.lsp_dynamic_workspace_symbols, "Find in workspace symbols (LSP) <Telescope>", opts)
        map("n", "<leader>fo", builtin.lsp_incoming_calls, "Find incoming calls (LSP) <Telescope>", opts)
        map("n", "<leader>fO", builtin.lsp_outgoing_calls, "Find outgoing calls (LSP) <Telescope>", opts)
        map("n", "<leader>fi", builtin.lsp_implementations, "Find implementations (LSP) <Telescope>", opts)
        map("n", "<leader>fx", function() builtin.diagnostics({ bufnr = 0 }) end, "Find errors (LSP) <Telescope>", opts)
        map("n", "<leader>fX", builtin.diagnostics, "Find errors all (LSP) <Telescope>", opts)
      end,
    })
  end,
}
