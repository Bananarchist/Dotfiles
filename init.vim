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

call plug#begin(stdpath('data') . '/plugged')
	Plug 'neovim/nvim-lspconfig'
	Plug 'glepnir/lspsaga.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'mhartington/formatter.nvim'
call plug#end()


lua <<EOF
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

})
local lspconfig = require 'lspconfig'
lspconfig.elmls.setup{}
lspconfig.gopls.setup{}
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
local opts = { noremap=true, silent=true }
buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
EOF

nnoremap <silent> gh <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-p> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

nnoremap <silent> gl <cmd>Format<CR>
nnoremap <silent> gd <cmdp

"nnoremap <silent> gd <cmd>lua require('vim.lsp.buf.definition()<CR>', opts)
"buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	"nmap <silent> gd <Plug>(coc-definition)
	"nmap <silent> gi <Plug>(coc-implementations)
	"nmap <silent> gl <Plug>(coc-format)
	"nmap <silent> gr <Plug>(coc-references)

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
"set tabline=%!Tabline()

" CSV options
let g:csv_default_delim = ','
let g:csv_no_conceal = 1

