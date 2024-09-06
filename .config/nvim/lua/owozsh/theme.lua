function SetColor(color)
    color = color or 'gruvbox'

    vim.opt.termguicolors = true
    vim.opt.background = 'dark'

    require("rose-pine").setup({
        styles = {
            bold = false,
            italic = false,
            transparency = false,
        },
    })

    require("gruvbox").setup({
        bold = true,
        italic = {
            strings = false,
            emphasis = true,
            comments = true,
            operators = false,
            folds = true,
        },
        contrast = "", -- can be "hard", "soft" or empty string
        transparent_mode = true,
    })



    vim.cmd.colorscheme(color)
end

SetColor()
