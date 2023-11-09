vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
    view = {
        width = 50,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
    update_focused_file = {
        enable = true,
    },
})

vim.keymap.set('n', '<leader>e', ":NvimTreeToggle<CR>", {})
