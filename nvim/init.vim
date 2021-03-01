call plug#begin()
	Plug 'terryma/vim-multiple-cursors'
	Plug 'mattn/emmet-vim'
	Plug 'sheerun/vim-polyglot'
	Plug 'morhetz/gruvbox'
	Plug 'arcticicestudio/nord-vim'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'scrooloose/nerdtree'
	Plug 'ryanoasis/vim-devicons'
	Plug 'dylanaraps/wal.vim'
	Plug 'm-pilia/vim-smarthome'
call plug#end()

" emmet
let g:user_emmet_leader_key=','

" theme
syntax on
colorscheme gruvbox
hi clear CursorLineNR
hi clear LineNR
hi LineNR guibg=NONE
hi Normal guibg=NONE ctermbg=NONE
hi CursorLine ctermfg=white

" Shortcuts
" autocmd filetype cpp nnoremap <F6> :w <bar> exec '!g++ -o %< %' <CR> :term ./%< <CR>
autocmd filetype cpp nnoremap <F4> :w <bar> exec '!g++ -o %< %' <CR> :!gnome-terminal --tab -- zsh -c 'g++ -o %< %; ./%<; exec zsh'<CR>
autocmd filetype tex nnoremap <F4> :w <bar> exec '!pdflatex % ; zathura %<.pdf'<CR>
autocmd filetype java nnoremap <F4> :w <bar> exec '!javac %' <CR> :!gnome-terminal --tab -- zsh -c 'java %<; exec zsh'<CR>

" nvim settings
set hidden
set number
set relativenumber
set mouse=a
set tabstop=2
set softtabstop=2
set shiftwidth=2
set noruler
set laststatus=0
set noshowcmd
set cmdheight=1
set fdm=indent
set nofoldenable
set clipboard+=unnamedplus

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" smart home/end
nmap <silent><Home> :call smarthome#SmartHome('n')<cr>
nmap <silent><End> :call smarthome#SmartEnd('n')<cr>
imap <silent><Home> <C-r>=smarthome#SmartHome('i')<cr>
imap <silent><End> <C-r>=smarthome#SmartEnd('i')<cr>
vmap <silent><Home> <Esc>:call smarthome#SmartHome('v')<cr>
vmap <silent><End> <Esc>:call smarthome#SmartEnd('v')<cr>

" nerdtree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

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
