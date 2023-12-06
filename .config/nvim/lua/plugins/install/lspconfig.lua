--=================================================================================================
--Настройка LSP серверов
--https://github.com/neovim/nvim-lspconfig
--=================================================================================================
local function get_capabilities()
  return require("cmp_nvim_lsp").default_capabilities()
end

local function setup_generic()
  local lspconfig = require("lspconfig")

  local generic_servers = {
    "gopls",
    "pyright",
    "clojure_lsp",
    "rust_analyzer",
    "bashls",
  }
  for _, client in ipairs(generic_servers) do
    lspconfig[client].setup {
      capabilities = get_capabilities(),
    }
  end
end

local function setup_lua()
  local lspconfig = require("lspconfig")
  lspconfig.lua_ls.setup({
    capabilities = get_capabilities(),
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
      },
    },
  })
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "hrsh7th/nvim-cmp",
      dependencies = { "hrsh7th/cmp-nvim-lsp" },
    },
  },
  config = function()
    setup_lua()
  end,
}
