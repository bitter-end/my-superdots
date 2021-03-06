set encoding=utf-8
let s:this_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" vim-plug
call plug#begin('~/.vim/plugged')


Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run the install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'


let g:LanguageClient_serverCommands = {
    \ 'sh': ['bash-language-server', 'start'],
    \ 'c': ['clangd-9'],
    \ 'cpp': ['clangd-9'],
\ }

Plug 'davidhalter/jedi-vim'
" to disable docstring window:
" autocmd FileType python setlocal completeopt-=preview


" Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
" Plug 'tpope/vim-rails', { 'for' : 'ruby' }

" Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'vim-scripts/SyntaxRange', { 'for': 'markdown' }
Plug 'SirVer/ultisnips', { 'tag': '3.1' } " they changed the way snippets are loaded/edited in 3.2
Plug 'honza/vim-snippets'
Plug 'd0c-s4vage/vim-morph'
Plug 'd0c-s4vage/pfp-vim', { 'on': [ 'PfpInit', 'PfpParse' ] }

" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/deoplete.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif
" let g:deoplete#enable_at_startup = 1


" Plug 'kien/ctrlp.vim' - no longer supported; use:
Plug 'ctrlpvim/ctrlp.vim'

Plug 'ervandew/supertab'
Plug 'nvie/vim-flake8', { 'for': 'python' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'Lokaltog/vim-easymotion'
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
" Instead of tpope/vim-fugitive, test this git solution out:
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes', { 'do': ':AirlineTheme tomorrow'}
Plug 'airblade/vim-gitgutter'
Plug 'lifepillar/vim-solarized8'
Plug 'godlygeek/tabular'
Plug 'dhruvasagar/vim-table-mode', { 'for': 'markdown' }


call plug#end()


let mapleader = ","

set laststatus=2

" exe "source ".s:this_dir."/after/colors/jellybeans.vim"

if (&term =~ '^xterm' && &t_Co == 256)
  set t_ut='' | set ttyscroll=1
endif
set list


