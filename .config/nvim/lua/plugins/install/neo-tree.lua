--=================================================================================================
--Файловый менеджер
--https://github.com/nvim-neo-tree/neo-tree.nvim
--=================================================================================================
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    local neo_conf = {
      close_if_last_window = true,
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
      },
    }

    neo_conf.filesystem = {
      filtered_items = {
        visible = true, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          --"node_modules"
        },
        hide_by_pattern = { -- uses glob style patterns
          --"*.meta",
          --"*/src/*/tsconfig.json",
        },
        always_show = { -- remains visible even if other settings would normally hide it
          --".gitignored",
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          --".DS_Store",
          --"thumbs.db"
        },
        never_show_by_pattern = { -- uses glob style patterns
          --".null-ls_*",
        },
      },
      follow_current_file = {
        enabled = false,                      -- This will find and focus the file in the active buffer every time
        -- the current file is changed while the tree is open.
        leave_dirs_open = false,              -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      group_empty_dirs = false,               -- when true, empty folders will be grouped together
      hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
      -- in whatever position is specified in window.position
      -- "open_current",  -- netrw disabled, opening a directory opens within the
      -- window like netrw would, regardless of window.position
      -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
      use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
      -- instead of relying on nvim autocmd events.
      commands = {}                   -- Add a custom command or override a global one using the same function name

    }
    neo_conf.document_symbols = {
      follow_cursor = false,
      client_filters = "first",
      renderers = {
        root = {
          { "indent" },
          { "icon",  default = "C" },
          { "name",  zindex = 10 },
        },
        symbol = {
          { "indent",    with_expanders = true },
          { "kind_icon", default = "?" },
          {
            "container",
            content = {
              { "name",      zindex = 10 },
              { "kind_name", zindex = 20, align = "right" },
            }
          }
        },
      },
      window = {
        mappings = {
          ["<cr>"] = "jump_to_symbol",
          ["o"] = "jump_to_symbol",
          ["A"] = "noop", -- also accepts the config.show_path and config.insert_as options.
          ["d"] = "noop",
          ["y"] = "noop",
          ["x"] = "noop",
          ["p"] = "noop",
          ["c"] = "noop",
          ["m"] = "noop",
          ["a"] = "noop",
          ["/"] = "filter",
          ["f"] = "filter_on_submit",
        },
      },
      custom_kinds = {
        -- define custom kinds here (also remember to add icon and hl group to kinds)
        -- ccls
        -- [252] = 'TypeAlias',
        -- [253] = 'Parameter',
        -- [254] = 'StaticMethod',
        -- [255] = 'Macro',
      },
      kinds = {
        Unknown = { icon = "?", hl = "" },
        Root = { icon = "", hl = "NeoTreeRootName" },
        File = { icon = "󰈙", hl = "Tag" },
        Module = { icon = "", hl = "Exception" },
        Namespace = { icon = "󰌗", hl = "Include" },
        Package = { icon = "󰏖", hl = "Label" },
        Class = { icon = "󰌗", hl = "Include" },
        Method = { icon = "󰊕", hl = "Function" },
        Property = { icon = "󰆧", hl = "@property" },
        Field = { icon = "󰆧", hl = "@field" },
        Constructor = { icon = "", hl = "@constructor" },
        Enum = { icon = "󰒻", hl = "@number" },
        Interface = { icon = "", hl = "Type" },
        Function = { icon = "󰊕", hl = "Function" },
        Variable = { icon = "", hl = "@variable" },
        Constant = { icon = "", hl = "Constant" },
        String = { icon = "󰀬", hl = "String" },
        Number = { icon = "󰎠", hl = "Number" },
        Boolean = { icon = "", hl = "Boolean" },
        Array = { icon = "󰅪", hl = "Type" },
        Object = { icon = "󰅩", hl = "Type" },
        Key = { icon = "󰌋", hl = "" },
        Null = { icon = "", hl = "Constant" },
        EnumMember = { icon = "", hl = "Number" },
        Struct = { icon = "󰌗", hl = "Type" },
        Event = { icon = "", hl = "Constant" },
        Operator = { icon = "󰆕", hl = "Operator" },
        TypeParameter = { icon = "󰊄", hl = "Type" },

        -- ccls
        -- TypeAlias = { icon = ' ', hl = 'Type' },
        -- Parameter = { icon = ' ', hl = '@parameter' },
        -- StaticMethod = { icon = '󰠄 ', hl = 'Function' },
        -- Macro = { icon = ' ', hl = 'Macro' },
      }
    }
    require("neo-tree").setup(neo_conf)


    local map = require("util").map
    map("n", "<leader>e", ":Neotree float reveal<CR>", "NeoTree float <NeoTree>")
    map("n", "<leader>E", ":Neotree left toggle<CR>", "NeoTree <NeoTree>")
    map("n", "<leader>o", ":Neotree float git_status<CR>", "NeoTree git_status <NeoTree>")
    map("n", "<leader>s", ":Neotree right toggle reveal source=document_symbols<CR>", "NeoTree Document Symbols <NeoTree>")


  end,
}
