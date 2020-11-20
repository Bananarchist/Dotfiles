syntax enable
set scrolloff=5				" Scroll three lines from end
set relativenumber			" Use relative line numbers
set number 				" Use cursor line number
cnoremap jk <C-C>
filetype plugin indent on
autocmd FileType elm setlocal shiftwidth=2 tabstop=2
set wrap
set wildmenu
set showmatch
set incsearch
set hlsearch
call plug#begin('~/.vim/plugged')
	Plug 'sheerun/vim-polyglot'
	Plug 'dense-analysis/ale'
	Plug 'mattn/emmet-vim'
call plug#end()

"statusline
set laststatus=2
set statusline=
set statusline+=%n			" buffer number
set statusline+=:\ 
set statusline+=%f			" filename
set statusline+=%M%R			" modified/readonly
set statusline+=%=			" right align
set statusline+=%l			" line
set statusline+=:
set statusline+=%c			" column

"Ale options
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_insert_leave = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_sign_info = '🔎' 
let g:ale_change_sign_column_color = 0 
let g:ale_set_highlights = 0
"CSV options
let g:csv_default_delim = ','
let g:csv_no_conceal = 1
