
" Installation of vim on Ubuntu 16:
" sudo apt-get install vim-gnome-py2
" then enable usage of python instead of Python3:
" sudo update-alternatives --set vim /usr/bin/vim.gnome-py2

" Plugin info from:
" https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/

" Get Vundle working...
"
set nocompatible " Dont use vi features
filetype off     " Needed for vundle to work
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" reload files changed outside vim
set autoread 

" This is the Vundle package, which can be found on GitHub.
" For GitHub repos, you specify plugins using the
" 'user/repository' format
Plugin 'gmarik/vundle'
" Run pathogen in order to directly git clone into bundle folder
execute pathogen#infect()

" We could also add repositories with a ".git" extension
" Plugin 'scrooloose/nerdtree.git'

" To get plugins from Vim Scripts, you can reference the plugin
" by name as it appears on the site
"Plugin 'Buffergator'
Plugin 'wombat256.vim'           "Color scheme
Plugin 'valloric/youcompleteme'  "Code completion
Plugin 'tmhedberg/SimpylFold'    "Dont fold based on indents only
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'    "Check syntax on every save
"Plugin 'nvie/vim-flake8'        "Check PEP8 standard
Plugin 'scrooloose/nerdtree'     "Filetree
Plugin 'jistr/vim-nerdtree-tabs' "Tabs
Plugin 'tpope/vim-fugitive'      "Git integration
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
				 "Status bar showing git branch/virualenv etc
"Plugin 'bling/vim-airline'       "Light-weight version of powerline
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'Raimondi/delimitMate'    "Automatically close brackets
Plugin 'heavenshell/vim-pydocstring'  "type :Pydocstring or enter <C-l> for docstring to appear
Plugin 'jeffkreeftmeijer/vim-numbertoggle' " Relative numbers

" Nerdtree options
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
" remap opening of nerdtree from :NERDTree to something more simple
let mapleader = ","
nmap <leader>nt :NERDTree<cr>

" Powerline options
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

" SimpylFold options
let g:SimpylFold_docstring_preview=1

" Youcompleteme options
let g:ycm_autoclose_preview_window_after_insertion = 1

" This is used to show make airline appear
set laststatus=2

" use syntax highlighting
syntax on
let python_highlight_all=1
filetype indent plugin on

" encoding is utf 8
set encoding=utf-8
set fileencoding=utf-8
set fileformat=unix

" tab whitespace for python dev PEP8
au BufNewFile,BufRead *.py
	\ set tabstop=4 |
	\ set softtabstop=4 |
	\ set shiftwidth=4 |
	\ set textwidth=79 |
	\ set expandtab |
	\ set autoindent 

" Web dev indents
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |

"Color scheme
set t_Co=256
color wombat256mod

set number " Show line numbers
set tw=79  " width of document
set nowrap " dont automatically wrap
set colorcolumn=80
highlight ColorColumn ctermbg=233

" ----------------------------------------------------------------------------
" Key remapping

" Split shortcuts (this remaps commands in normal mode)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" save with ctrl+s
nmap <c-s> :w<CR>

" Run current python file
nnoremap <buffer> <F9> :w <bar> :exec '!python' shellescape(@%, 1)<cr>

"... and remap the za command to space bar to use folding
nnoremap <space> za

"-----------------------------------------------------------------------------

" Use system clipboard
set clipboard=unnamed

" Enable folding
set foldmethod=indent
set foldlevel=99

"python with virtualenv support
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
"EOF

