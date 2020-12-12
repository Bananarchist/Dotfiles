syntax enable
set scrolloff=5				" Scroll three lines from end
set relativenumber			" Use relative line numbers
set number 				" Use cursor line number
cnoremap jk <C-C>
filetype plugin indent on
autocmd FileType elm setlocal shiftwidth=2 tabstop=2
set wrap
set cursorline				" But only for command mode
set cursorcolumn 			" But only for command mode
set wildmenu
set showmatch
set incsearch
set hlsearch
call plug#begin('~/.vim/plugged')
	Plug 'sheerun/vim-polyglot'
	Plug 'dense-analysis/ale'
	Plug 'mattn/emmet-vim'
call plug#end()

" statusline
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
set statusline=sl()
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

"tabline
function! Tabline()
	let t = ''
	for i in range(tabpagenr('$'))
		let tab = i+1
		let windown = tabpagewinnr(tab)
		let windows = tabpagewinnr(tab, "$")
		let buffers = tabpagebuflist(tab)
		let buffern = buffers[windown-1]
		let name = bufname(buffern)
		let modified = getbufvar(buffern, "&mod")
		let wintext = '' . (windows > 1 ? (', ' . (windows - 1)) . '...' : '')
		let tabname = name != '' ? fnamemodify(name, ':.') : 'Untitled'
		if modified 
			let tabname .= '+'
		endif

		let t .= '%' . tab . 'T'
		let t .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
		let t .= ' ' . tab . ':'
		let t .= '[' . tabname .  wintext . '] '


	endfor
	let t .= '%#TabLineFill#'
	return t
endfunction
hi TabLineSel ctermfg=202 ctermbg=232
hi TabLine ctermfg=247 ctermbg=239
hi TabLineFill ctermfg=232 ctermbg=232
set tabline=%!Tabline()

"Mode indicators/opts
if version >= 700
	au InsertEnter * set nocursorline nocursorcolumn
	au InsertLeave * set cursorline cursorcolumn
endif
 

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
