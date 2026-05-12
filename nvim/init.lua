local function map(mode, lhs, rhs, description)
	vim.keymap.set(mode, lhs, rhs, { silent = true, noremap = true, desc = description })
end

vim.opt.termguicolors = true
vim.g.mapleader = "\\"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.undofile = true

vim.pack.add({
	"https://github.com/norcalli/nvim-colorizer.lua",
	-- 'https://github.com/windwp/nvim-autopairs',
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/nvim-tree/nvim-tree.lua",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/ellisonleao/gruvbox.nvim",

	-- nvim-cmp deps
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/saadparwaiz1/cmp_luasnip",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/nvim-cmp",

	-- nvim-lspconfig deps
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	"https://github.com/folke/lazydev.nvim",

	-- LSP setup
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/windwp/nvim-ts-autotag",
	"https://github.com/rachartier/tiny-inline-diagnostic.nvim",
})

-- setup plugins

require("colorizer").setup()
require("ibl").setup({ indent = { char = "." } })

-- Add blank lines
map("n", " ", "O<ESC>")
map("n", "<enter>", "o<ESC>")

-- Buffer
map("n", "<leader>s", "<CMD>w<CR>", "Save buffer")

-- Line manipulation
map("n", "<tab>", ">>")
map("n", "<s-tab>", "<<")
map("v", "<tab>", ">gv")
map("v", "<s-tab>", "<gv")

map("n", "<A-j>", ":m .+1<CR>==")
map("n", "<A-k>", ":m .-2<CR>==")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

map("n", "<A-J>", "yyp")
map("v", "<A-J>", "y`>p")

map("n", "<A-K>", "yyP")
map("v", "<A-J>", "y`<P")

-- Window Navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-j>", "<C-w>j")

-- Resize Windows
map("n", "<C-Left>", "<cmd>vertical resize -15<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +15<CR>")
map("n", "<C-Up>", "<cmd>resize -5<CR>")
map("n", "<C-Down>", "<cmd>resize +5<CR>")

-- Clipboard
map("n", "<leader>y", '"+y', "Copy to clipboard")
map("v", "<leader>y", '"+y', "Copy to clipboard")
map("n", "<leader>Y", '"+Y', "Copy line to clipboard")

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-P>", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>c", builtin.colorscheme, { desc = "Colorscheme" })
vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>'", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
vim.keymap.set("n", "<leader>o", builtin.oldfiles, { desc = "Oldfiles" })
vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Definitions" })
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "References" })

vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { desc = "References" })

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })
vim.keymap.set("n", "<leader>qf", vim.lsp.buf.code_action, { desc = "LSP Quick Fix" })

vim.o.scrolloff = 999

vim.keymap.set("n", "]g", ":Gitsigns next_hunk<CR>", { desc = "Go to next Git hunk" })
vim.keymap.set("n", "[g", ":Gitsigns prev_hunk<CR>", { desc = "Go to previous Git hunk" })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
	callback = function()
		vim.cmd("silent! EslintFixAll")
	end,
})

require("theme")

require("telescope").setup()

-- set keymaps
local keymap = vim.keymap

keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fs", "<cmd>Telescope git_status<cr>", { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope git commits<cr>", { desc = "Find todos" })

-- set keymaps
local keymap = vim.keymap

keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fs", "<cmd>Telescope git_status<cr>", { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope git commits<cr>", { desc = "Find todos" })

require("nvim-tree").setup({})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	view = {
		width = 40,
	},
	filters = {
		dotfiles = false,
	},
	update_focused_file = {
		enable = true,
	},
	renderer = {
		indent_width = 2,
	},
})

local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})

require("lazydev").setup({
	library = {
		{ path = "luvit-meta/library", words = { "vim%.uv" } },
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local bufnr = ev.buf
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
		end

		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
		map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
		map("gt", vim.lsp.buf.type_definition, "[G]oto [T]ype definition")
		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		-- Telescope integration
		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

		-- Create the :Format command
		vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
			vim.lsp.buf.format()
		end, { desc = "Format current buffer with LSP" })
	end,
})

-- Initialize Mason
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "gopls", "pyright", "eslint" },
})

require("nvim-ts-autotag").setup({
	opts = {
		enable_close = true,
		enable_rename = true,
		enable_close_on_slash = false,
	},
})

require("tiny-inline-diagnostic").setup()
vim.diagnostic.config({ virtual_text = false })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

require("conform").setup({
	formatters_by_ft = {
		go = { "goimports", "gofumpt" },
		lua = { "stylua" },
		typescript = { "oxfmt", "oxlint" },
		typescriptreact = { "oxfmt", "oxlint" },
		javascript = { "oxfmt", "oxlint" },
		javascriptreact = { "oxfmt", "oxlint" },
		rust = { "rustfmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		Isp_fallback = true,
	},
})
