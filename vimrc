:syntax enable
set relativenumber
cnoremap jk <C-C>
set autoindent
set wrap
set tabstop=4
set wildmenu
set showmatch
set incsearch
set hlsearch
set foldmethod=syntax
call plug#begin('~/.vim/plugged')
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'leafOfTree/vim-vue-plugin'
	Plug 'elmcast/elm-vim'
call plug#end()
let g:airline_powerline_fonts = 1
let g:elm_format_autosave = 1
