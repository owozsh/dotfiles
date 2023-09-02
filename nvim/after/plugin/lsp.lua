local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp.default_keymaps({ buffer = bufnr })
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

require("mason-lspconfig").setup {
	ensure_installed = {
		"elixirls",
		"volar",
		"tailwindcss",
		"pyright",
		"solargraph",
		"marksman",
		"ltex",
		"tsserver",
		"eslint",
		"dockerls",
		"docker_compose_language_service",
		"emmet_ls",
		"bashls",
		"clangd",
		"cssls",
		"jsonls",
		"lua_ls",
		"rust_analyzer"
	},
}

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
	mapping = {
		['<CR>'] = cmp.mapping.confirm({ select = false }),
		['<Tab>'] = cmp_action.luasnip_supertab(),
		['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
	},
	preselect = 'item',
	completion = {
		completeopt = 'menu,menuone,noinsert'
	},
})
