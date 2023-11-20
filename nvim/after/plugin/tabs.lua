local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.barbar_auto_setup = false

require('barbar').setup {
    animation = true,
    auto_hide = 1,
    tabpages = false,
    clickable = true,
    sidebar_filetypes = {
        NvimTree = true,
        undotree = { text = 'undotree' },
    },
}

map('n', '<C-g>', '<Cmd>BufferPick<CR>', opts)
map('n', '<A-l>', '<Cmd>BufferPick<CR>', opts)

map('n', '<A-h>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-l>', '<Cmd>BufferNext<CR>', opts)
map('n', '<A-H>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A-L>', '<Cmd>BufferMoveNext<CR>', opts)

map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
map('n', '<leader>c', '<Cmd>BufferClose<CR>', opts)
