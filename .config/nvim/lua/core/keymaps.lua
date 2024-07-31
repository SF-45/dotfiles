--| CHAR | MODE                                                   |
--|------|--------------------------------------------------------|
--| n    | Normal                                                 |
--| v    | Visual and Select                                      |
--| s    | Select                                                 |
--| x    | Visual                                                 |
--| o    | Operator-pending                                       |
--| !    | Insert and Command-line                                |
--| i    | Insert                                                 |
--| l    | ":lmap" mappings for Insert, Command-line and Lang-Arg |
--| c    | Command-line                                           |
--| t    | Terminal-Job                                           |

local map = require("util").map
local opts = { noremap = true }
local copyTable = require("util").copyTable

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, "Inspect Pos")
map("n", "<leader>ut", ":!$TERM & disown<CR>", "Open alacritty")

----------------------------------------------------------------------------------
-- Window
----------------------------------------------------------------------------------
-- Operations
map("n", "<leader>ww", "<C-W>p", "Other window", opts)
map("n", "<leader>wd", "<C-W>c", "Delete window", opts)
map("n", "<leader>w-", "<C-W>s", "Split window below", opts)
map("n", "<leader>w|", "<C-W>v", "Split window right", opts)
map("n", "<leader>-", "<C-W>s", "Split window below", opts)
map("n", "<leader>|", "<C-W>v", "Split window right", opts)

-- Move to window using the <ctrl> hjkl
map("n", "<C-h>", "<C-w>h", "Go to left window", opts)
map("n", "<C-j>", "<C-w>j", "Go to lower window", opts)
map("n", "<C-k>", "<C-w>k", "Go to upper window", opts)
map("n", "<C-l>", "<C-w>l", "Go to right window", opts)


-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", "Increase window height")
map("n", "<C-Down>", "<cmd>resize -2<cr>", "Decrease window height")
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", "Decrease window width")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", "Increase window width")

----------------------------------------------------------------------------------
-- Buffers
----------------------------------------------------------------------------------
map("n", "<leader>bb", "<cmd>e #<cr>", "Switch to Other Buffer")
map("n", "<leader>`", "<cmd>e #<cr>", "Switch to Other Buffer")
map("n", "<leader>bd", ":bd<cr>", "Delete Buffer")
map("n", "<leader>qq", ":bd<cr>", "Delete Buffer")

map("n", "<leader>bn", ":bn<cr>", "Next Buffer")
map("n", "<S-l>", ":bn<cr>", "Next Buffer")
map("n", "]b", ":bn<cr>", "Next Buffer")

map("n", "<leader>bp", ":bp<cr>", "Prev Buffer")
map("n", "<S-h>", ":bp<cr>", "Prev Buffer")
map("n", "[b", ":bp<cr>", "Prev Buffer")

map("n", "<leader>bD", function()
  local bufs = vim.api.nvim_list_bufs()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, i in ipairs(bufs) do
    if i ~= current_buf then
      vim.api.nvim_buf_delete(i, {})
    end
  end
end, "Delete Other Buffers")

----------------------------------------------------------------------------------
-- Tab
----------------------------------------------------------------------------------
map("n", "<leader><tab>l", "<cmd>tablast<cr>", "Last Tab")
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", "First Tab")
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", "New Tab")
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", "Next Tab")
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", "Close Tab")
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", "Previous Tab")

----------------------------------------------------------------------------------
-- Improvements
----------------------------------------------------------------------------------
-- better up/down
local optsExt = copyTable(opts)
optsExt.expr = true
optsExt.silent = true
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", "Down", optsExt)
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", "Up", optsExt)
-- bettor indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
-- faster scroll
map({ "n", "x" }, "<C-e>", "2<C-e>", "Scroll down", { noremap = true, silent = true })
map({ "n", "x" }, "<C-y>", "2<C-y>", "Scroll up", { noremap = true, silent = true })

----------------------------------------------------------------------------------
-- Misc
----------------------------------------------------------------------------------
-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", "Escape and clear hlsearch")
-- Escape with jj
map("i", "jj", "<Esc>", "Escape")
-- quit
map("n", "<leader>qa", "<cmd>qa<cr>", "Quit")
-- quit and save all
map("n", "<leader>qA", "<cmd>xa<cr>", "Quit And Save All")
-- discard changes
map("n", "<leader>qe", "<cmd>e!<cr>", "Discard changes")
-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", "Move down")
map("n", "<A-k>", "<cmd>m .-2<cr>==", "Move up")
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", "Move down")
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", "Move up")
map("v", "<A-j>", ":m '>+1<cr>gv=gv", "Move down")
map("v", "<A-k>", ":m '<-2<cr>gv=gv", "Move up")
-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", "Save file")
map("n", "<leader>qw", ":wa<CR>", "Save All")
-- Quickfix
map("n", "<leader>xl", "<cmd>lopen<cr>", "Location List")
map("n", "<leader>xq", "<cmd>copen<cr>", "Quickfix List")
--LSP
map("n", "<leader>cl", "<cmd>LspInfo<cr>", "Lsp Info")
