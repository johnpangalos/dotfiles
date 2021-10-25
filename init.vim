call plug#begin('~/.vim/plugged')

" Vim improvement plugins
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-sensible'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree'

" Buffer Management and search
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'dense-analysis/ale'

Plug 'vim-airline/vim-airline'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

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
" Configuring Ale
"
"""""""""""""""""""""""""""""""""""
let g:ale_fixers = {
  \ 'typescript': ['eslint', 'prettier'],
  \ 'javascript': ['eslint', 'prettier'],
  \ 'go': ['gofmt', 'goimports'],
  \ 'markdown': ['prettier'],
  \ 'json': ['prettier'],
  \ 'yaml': ['prettier'],
\}

let g:ale_linters = {
  \'typescript': ['tsserver', 'eslint'],
  \'javascript': ['eslint'],
  \ 'go': ['golint', 'govet', 'gopls'],
\}

let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1

nmap <Leader>d :ALEGoToDefinition<CR>
nmap <Leader>i :ALEHover<CR>
nmap <Leader>r :ALERename<CR>

let g:ale_floating_preview = 1
let g:ale_detail_to_floating_preview = 1
let g:ale_cursor_detail = 1

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
