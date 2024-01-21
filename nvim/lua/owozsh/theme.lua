function SetColor(color)
    color = color or 'solarized-flat'

    require("catppuccin").setup({
        -- no_italic = true,
        transparent_background = true
    })

    vim.opt.termguicolors = true

    vim.g.solarized_diffmode = 'high'

    vim.cmd.colorscheme(color)
end

SetColor()
