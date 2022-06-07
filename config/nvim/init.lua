local set = vim.opt

-- Settings
set.scrolloff = 3
set.relativenumber = true
set.number = true
set.signcolumn = "number"
set.wrap = true
set.showcmd = true
set.wildmenu = true
set.showmatch = true
set.incsearch = true
set.hlsearch = true
set.expandtab = true
set.shiftwidth = 2
vim.cmd [[
	syntax enable
	filetype plugin indent on
	hi StatusLeft ctermfg=81 ctermbg=235
	hi StatusRight ctermfg=49 ctermbg=235
	hi TabLineSel ctermfg=202 ctermbg=232
	hi TabLine ctermfg=247 ctermbg=239
	hi TabLineFill ctermfg=232 ctermbg=232
]]

-- make it beautiful
-- statusline
local sl_fg1 = "%#StatusLeft#"
local sl_fn = "%f" -- filename
local sl_mdro = "%M%R" -- modified/readonly
local sl_fg2 = "%#StatusRight#"
local sl_ftype = "[%{&filetype}.%{&fileformat}]"
local sl_bn = "%n" -- buffer number
local sl_linen = "%03l" -- line
local sl_col = "%02c" -- column
vim.o.statusline = sl_fg1 .. sl_fn .. sl_mdro .. "%=" .. sl_fg2 .. " " .. sl_ftype .. " " .. sl_bn .. ":" .. sl_linen .. ":" .. sl_col
vim.o.laststatus = 2

-- tabs
function Tabline()
  local t = ""
  for i = 1, vim.fn.tabpagenr('$') do
    -- local tab = i
    local windown = vim.fn.tabpagewinnr(i)
    local windows = vim.fn.tabpagewinnr(i, "$")
    local buffers = vim.fn.tabpagebuflist(i)
    local buffern = buffers[i]
    local name = vim.fn.bufname(buffern)
    local modified = vim.fn.getbufvar(buffern, "&mod")
    local wintext = ""
    local tabname = ""
    if windows > 1 then
      wintext = ", " .. (windows - 1) .. "..."
    else
      wintext = ""
    end
    if name ~= "" then
      tabname = vim.fn.fnamemodify(name, ":.")
    else
      tabname = "Untitled"
    end
    if modified then
      tabname = tabname .. "+"
    end

    t = t .. "%" .. (i - 1) .. "T"
    t = t .. (tab == vim.fn.tabpagenr() and '%#TabLineSel#' or '%#TabLine#')
    t = t .. " " .. (i - 1) .. ":"
    t = t .. "[" .. tabname .. wintext .. "] "


  end
  t = t .. "%#TabLineFill#"
  return t
end

-- vim.o.tabline = "%!" .. Tabline()

-- Plugin installation
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
-- Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'mhartington/formatter.nvim'
vim.call('plug#end')

-- IDE setup
require("nvim-treesitter.configs").setup {
  ensure_installed = "maintained",
  sync_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
}

local lspconfig = require("lspconfig")

local on_attach = function(_, bufnr)
  local function map(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local map_opts = { noremap = true, silent = true }

  map("n", "gl", "<cmd>lua vim.lsp.buf.formatting()<cr>", map_opts)
  map("n", "gD", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", map_opts)
  map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", map_opts)
  map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", map_opts)
  map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", map_opts)
  -- map("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", map_opts)
  -- map("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>", map_opts)
end

lspconfig.elixirls.setup({
  cmd = { "elixir-ls" },
  on_attach = on_attach,
  settings = {
    elixirLS = {
      -- dialyzerEnabled = false,
      -- fetchDeps = false
    }
  }
})


lspconfig.hls.setup({
  on_attach = on_attach
})

lspconfig.clojure_lsp.setup({
  on_attach = on_attach
})
lspconfig.golangci_lint_ls.setup({
  on_attach = on_attach,
})

lspconfig.cssls.setup({
  on_attach = on_attach
})
lspconfig.html.setup({
  on_attach = on_attach
})
lspconfig.eslint.setup({
  on_attach = on_attach
})

lspconfig.sumneko_lua.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false
      }
    }
  }
})
