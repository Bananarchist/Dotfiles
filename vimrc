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
function! AleStatus() abort
   let l:count = ale#statusline#Count(bufnr(''))
   let l:errors = l:count.error + l:count.style_error
   let l:other_notes = l:count.total - l:errors
   let l:error_txt = printf('%d❗️', l:errors)
   let l:other_txt = printf('%d❕', l:other_notes)
   return l:count.total == 0 ? '' : printf(
       \ '%s%s%s',
       \ l:errors > 0 ? l:error_txt : '',
       \ l:errors > 0 && l:other_notes > 0 ? ', ' : '',
       \ l:other_notes > 0 ? l:other_txt : ''
       \)
endfunction
hi User1 ctermfg=81 ctermbg=235
hi User2 ctermfg=49 ctermbg=235
set laststatus=2
set statusline=
set statusline=%1*
set statusline+=%f			" filename
set statusline+=%M%R			" modified/readonly
set statusline+=%=			" right align
set statusline+=%{AleStatus()}
set statusline+=%2*
set statusline+=\ 
set statusline+=[%{&filetype}.%{&fileformat}]
set statusline+=\ 
set statusline+=%n			" buffer number
set statusline+=:
set statusline+=%03l			" line
set statusline+=:
set statusline+=%02c			" column

"Ale options
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_insert_leave = 1
let g:ale_sign_error = '🔴'
let g:ale_sign_warning = '🟠'
let g:ale_sign_info = '🔎' 
let g:ale_change_sign_column_color = 0 
let g:ale_set_highlights = 0
"CSV options
let g:csv_default_delim = ','
let g:csv_no_conceal = 1
