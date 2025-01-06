local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local function map(mode, lhs, rhs, description)
	vim.keymap.set(mode, lhs, rhs, { silent = true, noremap = true, desc = description })
end

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)
vim.opt.termguicolors = true
vim.g.mapleader = "\\"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

require("lazy").setup({
	spec = {
		{ "norcalli/nvim-colorizer.lua" },
		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
		{
			"stevearc/oil.nvim",
			opts = {},
			dependencies = { { "echasnovski/mini.icons", opts = {} } },
		},
		{
			"olimorris/onedarkpro.nvim",
			priority = 1000, -- Ensure it loads first
		},
		{
			"rose-pine/neovim",
			name = "rose-pine",
			opts = {
				styles = {
					italic = false,
					transparency = true,
				},
			},
			lazy = false,
			priority = 1000,
		},
		{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
		{ "sainnhe/gruvbox-material", priority = 1000 },
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = function()
				require("nvim-autopairs").setup({
					disable_filetype = { "TelescopePrompt", "vim" },
				})
			end,
		},
		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				"hrsh7th/cmp-buffer", -- source for text in buffer
				"hrsh7th/cmp-path", -- source for file system paths
				{
					"L3MON4D3/LuaSnip",
					version = "v2.*",
					-- install jsregexp (optional!).
					build = "make install_jsregexp",
				},
				"rafamadriz/friendly-snippets",
				"onsails/lspkind.nvim", -- vs-code like pictograms
			},
			config = function()
				local cmp = require("cmp")
				local lspkind = require("lspkind")
				local luasnip = require("luasnip")

				require("luasnip.loaders.from_vscode").lazy_load()

				cmp.setup({
					snippet = {
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},
					mapping = cmp.mapping.preset.insert({
						["<C-d>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),
						["<C-Space>"] = cmp.mapping.complete(),
						["<C-e>"] = cmp.mapping.close(),
						["<CR>"] = cmp.mapping.confirm({
							behavior = cmp.ConfirmBehavior.Replace,
							select = true,
						}),
					}),
					sources = cmp.config.sources({
						{ name = "nvim_lsp" },
						{ name = "luasnip" },
						{ name = "buffer" },
						{ name = "path" },
					}),
				})

				vim.cmd([[
      set completeopt=menuone,noinsert,noselect
      highlight! default link CmpItemKind CmpItemMenuDefault
    ]])
			end,
		},
		{
			"williamboman/mason.nvim",
			dependencies = {
				"williamboman/mason-lspconfig.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",
			},
			config = function()
				require("mason").setup()

				require("mason-lspconfig").setup({
					automatic_installation = true,
					ensure_installed = {
						"cssls",
						"eslint",
						"html",
						"jsonls",
						"pyright",
						"tailwindcss",
					},
				})

				require("mason-tool-installer").setup({
					ensure_installed = {
						"prettier",
						"stylua", -- lua formatter
						"isort", -- python formatter
						"black", -- python formatter
						"pylint",
						"eslint_d",
					},
				})
			end,
		},
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			keys = {
				{
					"<leader>?",
					function()
						require("which-key").show({ global = false })
					end,
					desc = "Buffer Local Keymaps (which-key)",
				},
			},
		},
		{
			"neovim/nvim-lspconfig",
			event = { "BufReadPre", "BufNewFile" },
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				{ "folke/neodev.nvim", opts = {} },
			},
			config = function()
				local nvim_lsp = require("lspconfig")
				local mason_lspconfig = require("mason-lspconfig")

				local protocol = require("vim.lsp.protocol")

				local on_attach = function(client, bufnr)
					-- format on save
					if client.server_capabilities.documentFormattingProvider then
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = vim.api.nvim_create_augroup("Format", { clear = true }),
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format()
							end,
						})
					end
				end

				local capabilities = require("cmp_nvim_lsp").default_capabilities()

				mason_lspconfig.setup_handlers({
					function(server)
						nvim_lsp[server].setup({
							capabilities = capabilities,
						})
					end,
					["cssls"] = function()
						nvim_lsp["cssls"].setup({
							on_attach = on_attach,
							capabilities = capabilities,
						})
					end,
					["tailwindcss"] = function()
						nvim_lsp["tailwindcss"].setup({
							on_attach = on_attach,
							capabilities = capabilities,
						})
					end,
					["html"] = function()
						nvim_lsp["html"].setup({
							on_attach = on_attach,
							capabilities = capabilities,
						})
					end,
					["jsonls"] = function()
						nvim_lsp["jsonls"].setup({
							on_attach = on_attach,
							capabilities = capabilities,
						})
					end,
					["eslint"] = function()
						nvim_lsp["eslint"].setup({
							on_attach = on_attach,
							capabilities = capabilities,
						})
					end,
					["pyright"] = function()
						nvim_lsp["pyright"].setup({
							on_attach = on_attach,
							capabilities = capabilities,
						})
					end,
				})
			end,
		},
		{
			"stevearc/conform.nvim",
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				local conform = require("conform")

				conform.setup({
					formatters_by_ft = {
						javascript = { "prettier" },
						typescript = { "prettier" },
						javascriptreact = { "prettier" },
						typescriptreact = { "prettier" },
						css = { "prettier" },
						html = { "prettier" },
						json = { "prettier" },
						yaml = { "prettier" },
						markdown = { "prettier" },
						lua = { "stylua" },
						python = { "isort", "black" },
					},
					format_on_save = {
						lsp_fallback = true,
						async = false,
						timeout_ms = 1000,
					},
				})

				vim.keymap.set({ "n", "v" }, "<leader>f", function()
					conform.format({
						lsp_fallback = true,
						async = false,
						timeout_ms = 1000,
					})
				end, { desc = "Format file or range (in visual mode)" })
			end,
		},
		{
			"lewis6991/gitsigns.nvim",
			config = function()
				local gitsigns = require("gitsigns")
				gitsigns.setup({
					signs = {
						add = { text = "│" },
						change = { text = "│" },
						delete = { text = "_" },
						topdelete = { text = "‾" },
						changedelete = { text = "~" },
						untracked = { text = "┆" },
					},
					signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
					numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
					linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
					word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
					watch_gitdir = {
						interval = 1000,
						follow_files = true,
					},
					attach_to_untracked = true,
					current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
					current_line_blame_opts = {
						virt_text = true,
						virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
						delay = 1000,
						ignore_whitespace = false,
					},
					current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
					sign_priority = 6,
					update_debounce = 100,
					status_formatter = nil, -- Use default
					max_file_length = 40000, -- Disable if file is longer than this (in lines)
					preview_config = {
						-- Options passed to nvim_open_win
						border = "single",
						style = "minimal",
						relative = "cursor",
						row = 0,
						col = 1,
					},
				})
			end,
		},
		{
			"lukas-reineke/indent-blankline.nvim",
			main = "ibl",
			---@module "ibl"
			---@type ibl.config
			opts = {},
		},
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.6",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				require("telescope").setup()

				-- set keymaps
				local keymap = vim.keymap

				keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
				keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find recent files" })
				keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find string in cwd" })
				keymap.set(
					"n",
					"<leader>fs",
					"<cmd>Telescope git_status<cr>",
					{ desc = "Find string under cursor in cwd" }
				)
				keymap.set("n", "<leader>fc", "<cmd>Telescope git commits<cr>", { desc = "Find todos" })
			end,
		},
		{
			"akinsho/toggleterm.nvim",
			version = "*",
			config = function()
				require("toggleterm").setup({
					size = 10,
					open_mapping = [[<F7>]],
					shading_factor = 2,
					direction = "float",
					float_opts = {
						border = "curved",
						highlights = {
							border = "Normal",
							background = "Normal",
						},
					},
				})
			end,
		},
	},
	install = {
		colorscheme = { "habamax" },
		missing = true,
	},
	checker = {
		enabled = true,
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

-- setup plugins

require("colorizer").setup()
require("ibl").setup({ indent = { char = "." } })
require("oil").setup({
	keymaps = {
		["g?"] = { "actions.show_help", mode = "n" },
		["<CR>"] = "actions.select",
		["<C-v>"] = { "actions.select", opts = { vertical = true } },
		["<C-x>"] = { "actions.select", opts = { horizontal = true } },
		["<C-t>"] = { "actions.select", opts = { tab = true } },
		["<C-p>"] = "actions.preview",
		["<C-c>"] = { "actions.close", mode = "n" },
		["<C-l>"] = "actions.refresh",
		["-"] = { "actions.parent", mode = "n" },
		["_"] = { "actions.open_cwd", mode = "n" },
		["`"] = { "actions.cd", mode = "n" },
		["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
		["gs"] = { "actions.change_sort", mode = "n" },
		["gx"] = "actions.open_external",
		["g."] = { "actions.toggle_hidden", mode = "n" },
		["g\\"] = { "actions.toggle_trash", mode = "n" },
	},
})

-- Add blank lines
map("n", " ", "O<ESC>")
map("n", "<enter>", "o<ESC>")

-- Buffer
map("n", "<leader>s", "<CMD>update<CR>", "Save buffer")

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

-- File explorer
map("n", "<leader>e", function()
	require("oil").toggle_float()
end, "File Explorer")

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

-- Colorscheme
vim.cmd("colorscheme onedark")
