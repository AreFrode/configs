" Config file for neovim
" Author: Are Frode Kvanum
" Date: 23.11.2020

let mapleader ="," 

"""""""""""""""""""
" Plug-in manager "
"""""""""""""""""""

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
    autocmd VimEnter * PlugInstall
endif

" Installation-block for plugins

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-commentary'

call plug#end()


"""""""""""""
" Nerd Tree "
"""""""""""""

map <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
if has('nvim')
    let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
else
    let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
endif

""""""""""""""""""
" Goyo/Limelight "
""""""""""""""""""

let g:limelight_conceal_ctermfg = 'gray'
map <leader>f :Goyo \| set linebreak<CR>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

"""""""""""
" Airline "
"""""""""""

let g:airline_powerline_fonts = 1                      " Enables powerline font
let g:airline#extensions#tabline#enabled = 1           " Display buffers when only one tab open
let g:airline#extensions#tabline#left_sep = ' '        " Format left tab seperator
let g:airline#extensions#tabline#right_sep = ' '       " Format right tab seperator
let g:airline#extensions#tabline#formatter = 'unique_tail_improved' " Path formatter 

let g:airline_theme='bubblegum'

"""""""""""""
" Syntastic "
"""""""""""""

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 2
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" let g:syntastic_error_symbol = "\u00a0\u2717"
" let g:syntastic_style_error_symbol = "S\u2717"
" let g:syntastic_warning_symbol = "\u00a0\u26A0"
" let g:syntastic_style_warning_symbol = "S\u26A0"

" let g:syntastic_python_checkers = ['pyflakes'] " Specify for python3

""""""""""""""
" Split view "
""""""""""""""

set splitbelow splitright

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"""""""""""""""""""""
" Documents / LaTeX "
"""""""""""""""""""""

" Compile document
map <leader>c :w! \| !pdflatex "<c-r>%"<CR>

" Open corresponding .pdf for preview
map <leader>p :!opout <c-r>%<CR><CR>

" Clean tex build files upon closing .tex file
autocmd VimLeave *.tex !texclear %

" Ensure .tex is read correctly
autocmd BufRead,BufNewFile *.tex set filetype=tex

"""""""""""""""""""
" Appearance/Misc "
"""""""""""""""""""

set nocompatible
filetype plugin on
syntax on
set encoding=utf-8

set wildmode=longest,list,full " Enable autocomplete

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " Disable autocomment on newline

set number relativenumber " Enable hybrid linenumbers

" Run xrdb whenever Xdefaults or Xresources are updated
autocmd BufRead,BufNewFile xresources,xdefaults set filetype=xdefaults
autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %

filetype plugin indent on
set tabstop=4    " show existing tab with 4 spaces width
set shiftwidth=4 " when indenting, use 4 spaces
set expandtab    " on pressing tab, insert 4 spaces
