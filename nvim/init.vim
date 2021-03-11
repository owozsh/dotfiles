call plug#begin()
	Plug 'terryma/vim-multiple-cursors'
	Plug 'mattn/emmet-vim'
	Plug 'sheerun/vim-polyglot'
	Plug 'morhetz/gruvbox'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'mcchrish/nnn.vim'
	Plug 'arthurxavierx/vim-unicoder'
	Plug 'dhruvasagar/vim-table-mode'
	Plug 'm-pilia/vim-smarthome'
call plug#end()

" emmet
let g:user_emmet_leader_key=','

" theme
syntax on
colorscheme gruvbox
set cursorline
"hi clear CursorLineNR
"hi clear LineNR
"hi LineNR guibg=NONE
"hi Normal guibg=NONE ctermbg=NONE
"hi CursorLine ctermfg=white


" Shortcuts
autocmd filetype java nnoremap <F5> :w <bar> exec '!javac %' <CR> :tabnew % <bar> term java %< <CR>
autocmd filetype c nnoremap <F5> :w <bar> exec '!gcc -o %< %' <CR> :tabnew % <bar> term ./%< <CR>
autocmd filetype tex nnoremap <F5> :w <bar> exec 'autocmd filetype tex nnoremap <F4> :w <bar> exec '!pdflatex % ; zathura %<.pdf'<CR>

nnoremap <F2> :NnnPicker %:p:h<CR>
nnoremap <F3> :tabnew <bar> term <CR>
nnoremap <F4> :tabnew % <CR>
nnoremap <F8> :e ~/uwu/org/.org.md <CR>
nnoremap <F9> :e ~/.config/nvim/init.vim <CR>
nnoremap <F10> :tabnew <bar> term tetris <CR>

noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt

" Leave terminal mode with esc
tnoremap <Esc> <C-\><C-n>

" nvim settings
autocmd TermOpen * startinsert
"set hidden
set number
set relativenumber
set mouse=a
set tabstop=2
set softtabstop=2
set shiftwidth=2
"set noruler
"set laststatus=0
"set noshowcmd
set cmdheight=1
set fdm=indent
set nofoldenable
set clipboard+=unnamedplus

nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

" smart home/end
nmap <silent><Home> :call smarthome#SmartHome('n')<cr>
nmap <silent><End> :call smarthome#SmartEnd('n')<cr>
imap <silent><Home> <C-r>=smarthome#SmartHome('i')<cr>
imap <silent><End> <C-r>=smarthome#SmartEnd('i')<cr>
vmap <silent><Home> <Esc>:call smarthome#SmartHome('v')<cr>
vmap <silent><End> <Esc>:call smarthome#SmartEnd('v')<cr>

" NNN
let g:nnn#command = 'nnn -C -c'
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }

" autocomplete
let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-python']
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
