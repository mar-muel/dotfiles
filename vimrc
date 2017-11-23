" Various configs
syntax on
set nocompatible " Dont use vi features
set number  " Use line numbers
set history=100  " Use more memory 
"set hlsearch   "highlight when search
set showmatch  "highlight matching parenthesis
let mapleader = ","
set term=screen-256color
" set bg=dark
"set relativenumber
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     
set fillchars+=vert:\  " Get rid of | seperator 
" no sounds
set noeb vb t_vb=
au GUIEnter * set vb t_vb=
set scrolloff=5 " make cursor always have n lines above/below
set autochdir
set tags=.git/tags;

" Tabs
set nowrap
set tabstop=2 "Display text with tabs as n columns
set expandtab  "Convert tab into spaces when using tab
set shiftwidth=2  "Indentation when using > and <
set autoindent  "Applies current indentation to next line when hitting o or O
set smartindent "Syntax dependent indentation
set softtabstop=2 "How many columns to add when using TAB in insert mode
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
" Use :retab to apply those settings to new file!

" reload files changed outside vim
set autoread 

" Vundle
filetype off " Needed for vundle to work
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'
"Plugin 'Valloric/YouCompleteMe'  "auto-complete any language
"Plugin 'davidhalter/jedi-vim'
Plugin 'ctrlpvim/ctrlp.vim'  "file browsing
Plugin 'jiangmiao/auto-pairs'   "Smart auto pair brackets
Plugin 'flazz/vim-colorschemes' "Download all colorschemes
Plugin 'tomtom/tcomment_vim'  "commenting any language
Plugin 'tpope/vim-surround'   "for html tags
Plugin 'tpope/vim-repeat'     "make vim-surround repeatable
Plugin 'ervandew/supertab'  "Making ultisnips compatible with YCM
Plugin 'SirVer/ultisnips'   "Engine for snippets
Plugin 'honza/vim-snippets' " Snippets are separated from the engine

" Python stuff
Plugin 'heavenshell/vim-pydocstring' "Generate Python docstrings
Plugin 'tmhedberg/SimpylFold'  "Allows better folding in python

" JS stuff
Plugin 'pangloss/vim-javascript' " some js syntax highlighting 
Plugin 'mxw/vim-jsx' " jsx support
let g:jsx_ext_required = 0 " do allow js files to contain jsx jsx-code

call vundle#end() "required
filetype plugin indent on "required  

" key remappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
inoremap jj <ESC> 
"nnoremap <leader>m :!%:p<Enter>   "execute current file
"imap </ <C-X><C-O><C-X>  "doesn't work for some reason
"this makes python comments indent
inoremap # X<BS>#
nnoremap <space> za

" Set paste toggle in order to paste without messed up tab structure
set pastetoggle=<F10>
"OR use "+p or :set paste and after :set nopaste

" Comma motions
nmap di, f,dT,
nmap ci, f,cT,

" Move lines
no <down> ddp
no <up> ddkP

" Center on } and * and n and L/H/M
nmap } }zz
nmap { {zz
nmap * *zz
nmap n nzz
nmap L Lzz
nmap H Hzz
nmap M Mzz

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" open split panes to right and bottom
set splitbelow
set splitright

" Autopair options
" let g:AutoPairsFlyMode = 1

" Ctrlp options
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

" tcomment options
nnoremap <leader>ch :TCommentAs html<CR>
vnoremap <leader>ch :TCommentAs html<CR>

" YouCompleteMe options
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" supertab options
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0

" ultisnips options Trigger configuration 
let g:UltiSnipsSnippetsDir='~/.vim/snippets'
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'

" ultisnips allow html in js files
autocmd filetype javascript UltiSnipsAddFiletypes html

" SimpylFold options
set foldlevelstart=20  "Do not fold on start (only when using SimpylFold)

" Color scheme
colorscheme default

" Automatically source .vimrc on save
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Generate PyDocstring (default somehow not working)
nmap <silent> <C-I> <Plug>(pydocstring)

" Leader shortcuts
nmap <leader>v :vsp<CR>:e $MYVIMRC<CR>  " Shortcut to edit vimrc file
nmap <leader>s :w<CR>
nmap <leader>t :!ctags -f .git/tags .<CR> " Call ctags manually

" Run current python file with <leader>m
autocmd FileType python nnoremap <buffer> <leader>m :w<CR>:exec '!python' shellescape(@%, 1)<cr>
autocmd filetype c nnoremap <leader>m :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd filetype cpp nnoremap <leader>m :w <bar> exec '!g++ -Wall -g -std=c++11 '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd filetype tex nnoremap <leader>m :w <bar> exec '!latexmk -pdf' shellescape(@%, 1) '&& open '.shellescape('%:r').'.pdf' <CR>
" autocmd filetype tex nnoremap <leader>m :w <bar>:exec '!echo' shellescape('%:r')<CR>
" Turn off auto-insert for comments (avoiding auto-comment)
" augroup auto_comment
"   au!
"   au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" augroup END


" Window movement shortcuts
" move to the window in the direction shown, or create a new window
" Stolen from https://github.com/nicknisi/vim-workshop/blob/master/vimrc
map <C-h> :call WinMove('h')<cr>
map <C-j> :call WinMove('j')<cr>
map <C-k> :call WinMove('k')<cr>
map <C-l> :call WinMove('l')<cr>

function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

