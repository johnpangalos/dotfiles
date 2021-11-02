call plug#begin('~/.vim/plugged')

" Vim improvement plugins
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-sensible'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree'

" Buffer Management and search
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'

Plug 'bluz71/vim-moonfly-colors'

call plug#end()

"""""""""""""""""""""""""""""""""""
"
" General config
"
"""""""""""""""""""""""""""""""""""
let mapleader = ","
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set number
set mouse=a
set backupcopy=yes
set termguicolors

" map leader x to close extra windows
noremap <Leader>x :ccl <bar> lcl<CR>

" map leader y and p to paste buffer
set clipboard+=unnamedplus

" set grep to ripgrep and remove need for flags
set grepprg=rg\ --hidden\ --vimgrep\ --smart-case\ --follow

"""""""""""""""""""""""""""""""""""
"
" Color scheme
"
"""""""""""""""""""""""""""""""""""
" Make comments italics and gray
" highlight Comment cterm=italic gui=italic guifg=gray ctermfg=gray

colorscheme moonfly

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Set background to be the same as terminal
" highlight Normal guibg=none ctermbg=none

"""""""""""""""""""""""""""""""""""
"
" Color scheme
"
"""""""""""""""""""""""""""""""""""
" Don't use non standard characters in the status bar
let g:airline_symbols_ascii = 1

"""""""""""""""""""""""""""""""""""
"
" JSX
"
"""""""""""""""""""""""""""""""""""
let g:jsx_ext_required = 0

augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
    au BufNewFile,BufRead *.tsx set filetype=typescript.tsx
augroup END

"""""""""""""""""""""""""""""""""""
"
" Splits
"
"""""""""""""""""""""""""""""""""""
set hidden
set splitbelow
set splitright 

"""""""""""""""""""""""""""""""""""
"
" Configuring Nerd Tree
"
"""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>
map <Leader>n :NERDTreeFocus<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""""""""""""""""""""""""
"
" Configuring fzf
"
"""""""""""""""""""""""""""""""""""
nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>f :Rg<CR>
" Don't match file name on search (super annoying)
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

"""""""""""""""""""""""""""""""""""
"
" Nerd commenter config
"
"""""""""""""""""""""""""""""""""""
let g:NERDSpaceDelims = 1

"""""""""""""""""""""""""""""""""""
"
" Configuring TreeSitter
"
"""""""""""""""""""""""""""""""""""
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
}
EOF

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
