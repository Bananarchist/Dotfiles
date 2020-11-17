syntax enable
set scrolloff=5   " Scroll three lines from end
set relativenumber " Use relative line numbers
set number " Use cursor line number
cnoremap jk <C-C>
filetype plugin indent on
autocmd FileType elm setlocal shiftwidth=2 tabstop=2
set wrap
set tabstop=4
set wildmenu
set showmatch
set incsearch
set hlsearch
call plug#begin('~/.vim/plugged')
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'sheerun/vim-polyglot'
	Plug 'dense-analysis/ale'
	Plug 'mattn/emmet-vim'
call plug#end()
"Airline options
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
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
