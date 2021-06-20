call plug#begin('~/.vim/plugged')

" Vim improvement plugins
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-sensible'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/fountain.vim'
Plug 'junegunn/goyo.vim'
Plug 'evanleck/vim-svelte', {'branch': 'main'}

" Theme
Plug 'sainnhe/gruvbox-material'

" Buffer Management and search
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Linting and Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'rodrigore/coc-tailwind-intellisense', {'do': 'npm install'}

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

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

" map leader x to close extra windows
noremap <Leader>x :ccl <bar> lcl<CR>

" map leader y and p to paste buffer
set clipboard+=unnamedplus

" set grep to ripgrep and remove need for flags
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

"""""""""""""""""""""""""""""""""""
" 
" Theming
"
"""""""""""""""""""""""""""""""""""
set termguicolors
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_transparent_background = 1
colorscheme gruvbox-material 

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
" Configuring COC
"
"""""""""""""""""""""""""""""""""""
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

nmap <leader>do <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

let g:svelte_preprocessor_tags = [
  \ { 'name': 'ts', 'tag': 'script', 'as': 'typescript' }
  \ ]
let g:svelte_preprocessors = ['ts']

"""""""""""""""""""""""""""""""""""
"
" Writing
"
"""""""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.fountain set filetype=fountain
au BufRead,BufNewFile *.md set spell spelllang=en_us
au BufRead,BufNewFile *.fountain set spell spelllang=en_us

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF

"""""""""""""""""""""""""""""""""""
"
" Configuring Coc vim
"
"""""""""""""""""""""""""""""""""""

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
