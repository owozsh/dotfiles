function SetColor(color)
    color = color or 'tokyonight-night'
    vim.o.background = "dark"
    vim.cmd.colorscheme(color)
end

SetColor()
