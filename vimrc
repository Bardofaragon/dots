syntax on

set noerrorbells

set tabstop=4 softtabstop=4 shiftwidth=4
set expandtab
set smartindent
filetype indent on 
set encoding=utf-8
set fileencoding=utf-8

source $VIMRUNTIME/macros/matchit.vim
set backspace=indent,eol,start
set lazyredraw
set hidden
set autoread
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set updatetime=50
let mapleader = ","
let g:mapleader = ","
let g:user_emmet_leader_key=','
noremap \ ,
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey
call plug#begin('~/.vim/plugged')

" Plug 'itchyny/lightline.vim'
Plug 'rust-lang/rust.vim'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'editorconfig/editorconfig-vim'
Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'vim-airline/vim-airline'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'vim-airline/vim-airline-themes'
Plug 'jparise/vim-graphql'
Plug 'vim-utils/vim-man'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]
Plug 'mbbill/undotree'
Plug 'mattn/emmet-vim'
Plug 'sainnhe/gruvbox-material'
Plug 'preservim/nerdtree'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'jiangmiao/auto-pairs'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ap/vim-css-color'      
" Plug 'psf/black', { 'branch': 'stable' }

" Plug 'hail2u/vim-css3-syntax'
call plug#end()

let g:gruvbox_contrast_dark = 'hard'
    if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
let g:gruvbox_invert_selection='0'

colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derive_root='true'
endif

noremap <leader>q :bp<CR>
noremap <leader>w :bn<CR>
set scrolloff=3

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard', 'find %s -type f']
let g:netrw_browse_split=2
let g:netrw_banner=0
let g:netrw_winsize=25

let g:ctrlp_use_caching=0

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <leader>u :UndotreeShow<cr>
nnoremap <Leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
imap jk <Esc>

au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead .babelrc set filetype=json

map <C-n> :NERDTreeToggle<CR>

let g:airline#extensions#tabline#enabled = 1

if exists("loaded_matchit")
    let b:match_ignorecase=0
    let b:match_words =
     \  '<:>,' .
     \  '<\@<=!--:-->,'.
     \  '<\@<=?\k\+:?>,'.
     \  '<\@<=\([^ \t>/]\+\)\%(\s\+[^>]*\%([^/]>\|$\)\|>\|$\):<\@<=/\1>,'.
     \  '<\@<=\%([^ \t>/]\+\)\%(\s\+[^/>]*\|$\):/>'
endif

" set listchars=tab:→\ ,space:·bsp:␣,trail:•,eol:¶,precedes:«,extends:»
" nmap <leader>r :set list<CR>
let g:indent_guides_enable_on_vim_startup = 1

autocmd BufRead,BufNewFile *.htm,*.html,*.js,*.json,*.yml,*.ts setlocal tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab

let g:EditorConfig_exclude_patterns = ['fugitive://.*']
command! -nargs=0 Prettier :CocCommand prettier.formatFile

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
set belloff=all

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

" augroup black_on_save
"   autocmd!
"   autocmd BufWritePre *.py Black
" augroup end
