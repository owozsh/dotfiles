vim.g.mapleader = "\\"

-- File Explorer
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<leader>s", ":update <CR>")
vim.keymap.set("n", "<leader><C-s>", ":so <CR>")
vim.keymap.set("n", "<leader>y", ":so <CR>")
vim.keymap.set("n", "<F9>", ":tabnew ~/.config/nvim/lua/owozsh <CR>")


-- Clipboard
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+yg_")
vim.keymap.set("n", "<leader>yy", "\"+yy")

-- Insert Blank Lines
vim.keymap.set("n", "<Space>", "O<ESC>")

-- Fast Delete Line
vim.keymap.set("n", "<M-d>", "dd")

-- Move Line
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==")
vim.keymap.set("i", "<M-j>", "<Esc>:m .+1<CR>==")
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv")

-- Alt-Shift Line Duplicate
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==")
vim.keymap.set("i", "<M-k>", "<Esc>:m .-2<CR>==")
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<S-M-j>", "yyp")
vim.keymap.set("n", "<S-M-k>", "yyP")

-- Fast Indenting
vim.keymap.set("n", "<Tab>", ">>")
vim.keymap.set("n", "<S-Tab>", "<<")
vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

-- Reloading Config
vim.keymap.set("n", "<leader>rr", ":luafile ~/.config/nvim/init.lua<CR>")
