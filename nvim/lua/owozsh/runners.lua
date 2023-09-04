vim.cmd [[
autocmd filetype tex nnoremap <F5> :w <bar> exec '!pdflatex %'<CR><CR>
]]
