local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })
    lsp.buffer_autoformat()
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
        "emmet_language_server",
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

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
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

require('nvim-ts-autotag').setup()
