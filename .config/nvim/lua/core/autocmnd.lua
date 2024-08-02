local autocmd = require("util").register_autocmd
local map = require("util").map

autocmd("FileType", {
	group = "close_with_q",
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
    "TelescopePromptPrefix",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

autocmd("FileType", {
  group = "spellwrapon",
  pattern = {
    "gitcommit",
    "markdown",
  },
  callback = function ()
     vim.opt_local.spell = true
     vim.opt_local.wrap = true
  end
})

autocmd("LspAttach", {
  group = "default_lsp_attach",
  callback = function(event)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    local opts = { buffer = event.buf }
    map("n", "<leader>cd", vim.diagnostic.open_float, "Line Diagnostics <LSP>", opts)
    map("n", "]d", vim.diagnostic.goto_next, "Next diagnostics <LSP>", opts)
    map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostics <LSP>", opts)
    map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration <LSP>", opts)
    map("n", "gd", vim.lsp.buf.definition, "Goto Definition <LSP>", opts)
    map("n", "K", vim.lsp.buf.hover, "Hover <LSP>", opts)
    map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation <LSP>", opts)
    map("n", "<leader>ch", vim.lsp.buf.signature_help, "Signature Help <LSP>", opts)
    -- map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    -- map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    -- map("n", "<space>wl", function()
    -- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    map("n", "<leader>ct", vim.lsp.buf.type_definition, "Type Definition <LSP>", opts)
    map("n", "<leader>cr", vim.lsp.buf.rename, "Rename <LSP>", opts)
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action <LSP>", opts)
    map({ "n", "v" }, "<leader>cA", function()
      vim.lsp.buf.code_action({
        context = {
          only = {
            "source",
          },
          diagnostics = {},
        },
      })
    end, "Source Action <LSP>", opts)
    map("n", "gr", vim.lsp.buf.references, "Goto References <LSP>", opts)
    map("n", "<leader>cf", function()
      vim.lsp.buf.format({ async = true })
    end, "Format <LSP>", opts)
  end,
})
