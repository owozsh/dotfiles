function SetColor(color)
    color = color or 'neobones'

    vim.o.background = "dark"

    vim.opt.cursorline = true
    vim.g.solarized_diffmode = 'high'

    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    vim.cmd.colorscheme(color)
end

SetColor()
