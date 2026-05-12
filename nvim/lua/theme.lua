vim.o.termguicolors = true
vim.o.background = "dark"
require("gruvbox").setup({
  bold = false,
  italic = {
    comments = false,
    emphasis = false,
    folds = false,
    operators = false,
    strings = false
  },
  transparent_mode = true
})
vim.cmd.colorscheme("gruvbox")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })

