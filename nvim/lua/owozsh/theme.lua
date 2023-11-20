function SetColor(color)
    color = color or 'solarized'

    vim.o.background = "light"

    vim.opt.cursorline = true
    vim.g.solarized_diffmode = 'high'

    vim.cmd.colorscheme(color)

    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

SetColor()
