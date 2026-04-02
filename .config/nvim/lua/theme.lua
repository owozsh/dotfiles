require("rose-pine").setup({
    styles = {
      bold = true,
      italic = true,
      transparency = true,
  },
})

vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd.colorscheme("flexoki")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })

