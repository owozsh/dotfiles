vim.cmd [[
autocmd filetype tex nnoremap <F5> :w <bar> exec '!pdflatex -synctex=1 -interaction=nonstopmode %'<CR><CR>
]]
