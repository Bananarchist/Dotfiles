" Mainsettings?
set scrolloff=3				" Scroll three lines from end
set relativenumber			" Use relative line numbers
set number 				" Use cursor line number
set signcolumn=number
set wrap
set showcmd
set wildmenu
set showmatch
set incsearch
set hlsearch
syntax enable
filetype plugin indent on

" Plugins
call plug#begin(stdpath('data') . '/plugged')
	Plug 'neovim/nvim-lspconfig'
	Plug 'glepnir/lspsaga.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'mhartington/formatter.nvim'
call plug#end()


" IDE setup
lua << EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = { "elm", "go", "html", "css", "javascript", "vim", "lua", "yaml", "bash", "json" },
	ignore_install = {},
	highlight = {
		enabled = true,
		disable = {},
		additional_vim_regex_highlighting = false,
	},
}
require'lspsaga'.init_lsp_saga({
	error_sign = '🔴',
	warn_sign = '🟠',
	hint_sign = '?',
	infor_sign = ';',
	code_action_prompt = {
		enable = false,
		sign = false,
	},
})
local lspconfig = require 'lspconfig'
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	local opts = { noremap=true, silent=true }
	buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

local servers = { 'elmls', 'gopls' }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		}
	}
end

require'formatter'.setup({
	filetype = {
		elm = {
			function() 
				return {
					exe = "elm-format ",
					args = {"--stdin"},
					stdin = true
				}
			end
		},
		css = {
			function() 
				return {
					exe = "prettier",
					args = {"--stdin-filepath", vim.fn.fnamescape(vim.api.nvim_buf_get_name(0)), "--single-quote"},
					stdin = true
				}
			end
		},
	}
})

EOF


nnoremap <silent> gl <cmd>Format<CR>
nnoremap <silent>K :Lspsaga hover_doc<CR>


" statusline
hi User1 ctermfg=81 ctermbg=235
hi User2 ctermfg=49 ctermbg=235
set laststatus=2
set statusline=sl()
set statusline=%1*
set statusline+=%f			" filename
set statusline+=%M%R			" modified/readonly
set statusline+=%=			" right align
set statusline+=%2*
set statusline+=\ 
set statusline+=[%{&filetype}.%{&fileformat}]
set statusline+=\ 
set statusline+=%n			" buffer number
set statusline+=:
set statusline+=%03l			" line
set statusline+=:
set statusline+=%02c			" column

hi TabLineSel ctermfg=202 ctermbg=232
hi TabLine ctermfg=247 ctermbg=239
hi TabLineFill ctermfg=232 ctermbg=232
function Tabline()
	let t = ''
	for i in range(tabpagenr('$'))
		" to do: shorten filenames longer than some number
		let tab = i+1
		let window_number = tabpagewinnr(tab)
		let window_list = tabpagewinnr(tab, "$")
		let buffer_list = tabpagebuflist(tab)
		let buffer_number = buffer_list[window_number-1]
		let buffer_name = bufname(buffer_number)
		let is_modified = getbufvar(buffer_number, "&mod")
		let wintext = '' "'' . (window_list > 1 ? ' (' . (window_list - 1) . '...)' : '')
		let tabname = buffer_name != '' ? fnamemodify(buffer_name, ':.') : 'Untitled'
		if is_modified 
			let tabname .= '+'
		endif

		let t .= '%' . tab . 'T'
		let t .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
		" let t .= tab . '#'
		let t .= ' ' . tabname .  wintext . ' ' 

	endfor
	let t .= '%#TabLineFill#'
	return t
endfunction
set tabline=%!Tabline()

" CSV options
let g:csv_default_delim = ','
let g:csv_no_conceal = 1

