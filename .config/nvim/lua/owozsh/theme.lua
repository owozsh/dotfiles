function SetColor(color)
    color = color or 'gruvbox'

    vim.opt.termguicolors = true

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
        transparent_mode = false,
    })

    vim.cmd.colorscheme(color)
end

SetColor()
