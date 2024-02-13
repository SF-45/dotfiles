--=================================================================================================
--Подсветка синтаксиса
--https://github.com/nvim-treesitter/nvim-treesitter
--https://github.com/nvim-treesitter/nvim-treesitter-textobjects
--=================================================================================================
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = function()
      local ts_update = require("nvim-treesitter.install").update {
        with_sync = true,
      }
      ts_update()
    end,
    config = function()
      local ts_config = require "nvim-treesitter.configs"

      ts_config.setup {
        ensure_installed = {
          "vim",
          "vimdoc",
          "lua",
          "rust",
          "java",
          "javascript",
          "tsx",
          "kotlin",
          "python",
          "sql",
          "bash",
          "clojure",
          "scheme",
          "fennel",

          "markdown",
          "markdown_inline",

          "mermaid",

          "http",
          "query",

          "json",
          "html",
          "xml",
          "css",
          "yaml",
          "dot",
          "toml",
          "dockerfile",
          "gitignore",
          "gitcommit",
        },
        sync_install = false,
        auto_install = false,
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(
              vim.loop.fs_stat,
              vim.api.nvim_buf_get_name(buf)
            )
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-b>",
            node_incremental = "<C-b>",
            scope_incremental = false,
            node_decremental = "<C-m>",
          },
        },
        textobjects = {
          swap = {
            enable = true,
            swap_next = {
              ["<leader>man"] = "@parameter.inner",
              ["<leader>mfn"] = "@function.outer",
              ["<leader>mcn"] = "@class.outer",
            },
            swap_previous = {
              ["<leader>map"] = "@parameter.inner",
              ["<leader>mfp"] = "@function.outer",
              ["<leader>mcp"] = "@class.outer",
            },
          },
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["a="] = {
                query = "@assignment.outer",
                desc = "Select outer part of an assignment <Telescope>",
              },
              ["i="] = {
                query = "@assignment.inner",
                desc = "Select inner part of an assignment <Telescope>",
              },
              ["l="] = {
                query = "@assignment.lhs",
                desc = "Select left hand side of an assignment <Telescope>",
              },
              ["r="] = {
                query = "@assignment.rhs",
                desc = "Select right hand side of an assignment <Telescope>",
              },
              ["an"] = {
                query = "@block.outer",
                desc = "Select inner part of a block <Telescope>",
              },
              ["in"] = {
                query = "@block.inner",
                desc = "Select outer part of a block <Telescope>",
              },
              ["aa"] = {
                query = "@parameter.outer",
                desc = "Select outer part of a parameter/argument <Telescope>",
              },
              ["ia"] = {
                query = "@parameter.inner",
                desc = "Select inner part of a parameter/argument <Telescope>",
              },

              ["ai"] = {
                query = "@conditional.outer",
                desc = "Select outer part of a conditional <Telescope>",
              },
              ["ii"] = {
                query = "@conditional.inner",
                desc = "Select inner part of a conditional <Telescope>",
              },

              ["al"] = {
                query = "@loop.outer",
                desc = "Select outer part of a loop <Telescope>",
              },
              ["il"] = {
                query = "@loop.inner",
                desc = "Select inner part of a loop <Telescope>",
              },

              ["am"] = {
                query = "@call.outer",
                desc = "Select outer part of a function call <Telescope>",
              },
              ["im"] = {
                query = "@call.inner",
                desc = "Select inner part of a function call <Telescope>",
              },

              ["af"] = {
                query = "@function.outer",
                desc = "Select outer part of a method/function definition <Telescope>",
              },
              ["if"] = {
                query = "@function.inner",
                desc = "Select inner part of a method/function definition <Telescope>",
              },
              ["ac"] = {
                query = "@class.outer",
                desc = "Select outer part of a class <Telescope>",
              },
              ["ic"] = {
                query = "@class.inner",
                desc = "Select inner part of a class <Telescope>",
              },
            },
          },
        },
      }

      local parser_config =
          require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.tsx.filetype_to_parsername =
      { "javascript", "typescript.tsx" }
    end,
  },
}
