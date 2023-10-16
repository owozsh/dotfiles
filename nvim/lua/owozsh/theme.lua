function SetColor(color)
    color = color or "kanagawa-dragon"

    vim.o.background = "dark"

    require("gruvbox").setup({
        italic = {
            strings = false,
            comments = true,
            operators = false,
            folds = false,
        },
        contrast = "hard", -- can be "hard", "soft" or empty string
        transparent_mode = true,
    })

    vim.cmd.colorscheme(color)

    vim.opt.cursorline = true

    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

SetColor()
