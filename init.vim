call plug#begin()
	Plug 'owozsh/amora'
	Plug 'morhetz/gruvbox'
	Plug 'altercation/vim-colors-solarized'
	Plug 'arcticicestudio/nord-vim'
	Plug 'chriskempson/base16-vim'

	Plug 'lervag/vimtex'

	Plug 'mg979/vim-visual-multi', {'branch': 'master'}
	Plug 'm-pilia/vim-smarthome'
	Plug 'voldikss/vim-floaterm'
	Plug 'Raimondi/delimitMate'
	Plug 'mcchrish/nnn.vim'

	Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
	Plug 'dhruvasagar/vim-table-mode'
	Plug 'arthurxavierx/vim-unicoder'
	Plug 'dkarter/bullets.vim'
	Plug 'junegunn/goyo.vim'

	Plug 'mattn/emmet-vim'
	Plug 'ap/vim-css-color'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'sheerun/vim-polyglot'
	Plug 'uiiaoo/java-syntax.vim'
call plug#end()

" emmet
let g:user_emmet_leader_key=','

" multi
let g:VM_maps = {}
let g:VM_mouse_mappings = 1
let g:VM_maps["Select Cursor Down"] = '<C-j>'
let g:VM_maps["Select Cursor Up"]   = '<C-j>'

" Shortcuts
autocmd filetype java nnoremap <F5> :w <bar> exec '!javac %' <CR> :tabnew % <bar> term java %< <CR>
autocmd filetype c nnoremap <F5> :w <bar> tabnew % <bar> term gcc % -o %< && ./%< <CR>
autocmd filetype cpp nnoremap <F5> :w <bar> tabnew % <bar> term g++ % -o %< && ./%< <CR>
autocmd filetype python nnoremap <F5> :w <bar> tabnew % <bar> term python3 % <CR>
autocmd filetype tex nnoremap <F5> :w <bar> exec '!pdflatex %'<CR><CR>
autocmd filetype tex nnoremap <F6> :w <bar> exec '!evince %<.pdf &'<CR><CR>

nnoremap <F2> :NnnPicker %:p:h<CR>
nnoremap <F3> :tabnew % <bar> term<CR>
nnoremap <F4> :tabnew % <CR>
nnoremap <F7> :FloatermNew --autoclose=1 --height=0.6 --width=0.8 spt <CR>
nnoremap <F9> :tabnew ~/.config/nvim/init.vim <CR>
nnoremap <F10> :FloatermNew --autoclose=1 --height=0.8 --width=0.6 vitetris <CR>
nnoremap <F12> :FloatermToggle! <CR>

nnoremap <CR> o<Esc>
nnoremap <Space> O<Esc>
nnoremap <M-d> dd

ab #i# #include <stdio.h><CR><CR>int main()

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
tnoremap <leader><Esc> <C-\><C-n>

nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

nnoremap <S-M-j> yyp
nnoremap <S-M-k> yyP

nnoremap <Tab> >>
nnoremap <S-Tab> <<
vmap <Tab> >gv
vmap <S-Tab> <gv

noremap <Leader>s :update<CR>

nnoremap <leader>g :Goyo<CR>

"""" nvim settings
" for coc
set hidden
set updatetime=300
set shortmess+=c
map q: <Nop>
nnoremap Q <nop>
autocmd TermOpen * startinsert
set number
set relativenumber
set mouse=a
set clipboard+=unnamedplus
set autochdir

" smart home/end
nmap <silent><Home> :call smarthome#SmartHome('n')<cr>
nmap <silent><End> :call smarthome#SmartEnd('n')<cr>
imap <silent><Home> <C-r>=smarthome#SmartHome('i')<cr>
imap <silent><End> <C-r>=smarthome#SmartEnd('i')<cr>
vmap <silent><Home> <Esc>:call smarthome#SmartHome('v')<cr>
vmap <silent><End> <Esc>:call smarthome#SmartEnd('v')<cr>

" NNN
let g:nnn#command = 'nnn -C -o'
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }

" autocomplete
let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-python', 'coc-clangd', 'coc-java', 'coc-vimtex']

inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Java Syntax
highlight link javaIdentifier NONE

set noshowmode
set noruler
set laststatus=0
set noshowcmd
set cmdheight=1

" theme
syntax enable
colo solarized
set cursorline
