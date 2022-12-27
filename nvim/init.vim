" General config
set encoding=utf-8
filetype plugin indent on  " detects filetypes, plugins, and indent files
syntax on  " syntax highlighting
set number  " Use line numbers
set nofoldenable  "disable folding
set nohlsearch   " do not highlight when search
set showmatch  " highlight matching parenthesis
let mapleader = ","  " set leader key
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.git/*,*/.DS_Store,*/.idea  " ignore certain files when using autocomplete
set scrolloff=5 " make cursor always have n lines above/below
set nowrap

" Search config
set ignorecase  " ignore case when search
set smartcase   " ... but only if using only lower case letters

" Minimal status line (filepath, modified flag)
set statusline=%F\ %m

" Tabs
set tabstop=4 " Display text with tabs as n columns
set expandtab  " Convert tab into spaces when using tab
set shiftwidth=4  " Indentation when using > and <
set smartindent " Syntax dependent indentation
set softtabstop=4 " How many columns to add when using TAB in insert mode
" Use :retab to apply those settings to new file!

" General key mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
inoremap jj <ESC>
"this makes python comments indent
inoremap # X<BS>#
nnoremap <space> za

" Comma motions
nmap di, f,dT,
nmap ci, f,cT,

" Move lines
no <down> ddp
no <up> ddkP

" Make Y behave like C, D, etc.
nnoremap Y y$

" Center on } and * and n and L/H/M
nnoremap } }zz
nnoremap { {zz
nnoremap * *zz
nnoremap n nzz
nnoremap N Nzz
nnoremap L Lzz
nnoremap H Hzz
nnoremap M Mzz
nnoremap M Mzz

" Keeps your cursor at the same position when doing J
nnoremap J mzJ`z

" Undo break points: when hitting u, only goes back to the last , or .
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Open vimrc file
nmap <leader>v :vsp<CR>:e $MYVIMRC<CR>
" Source vimrc
nmap <leader>s :source ~/.config/nvim/init.vim<CR>
" Call ctags
nmap <leader>t :!ctags -f .git/tags .<CR>
" Open file tree
nnoremap <leader>n :Lexplore<CR>
" Use previously yanked (e.g. when pasting multiple times)
vnoremap <C-P> "0p

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Pretty format JSON
com! FormatJSON %!python -m json.tool

" ----------------------------------
" PLUGINS
" ----------------------------------

call plug#begin()
Plug 'jiangmiao/auto-pairs'   "Smart auto pair brackets
Plug 'tomtom/tcomment_vim'  "commenting any language
Plug 'tpope/vim-surround'   "for html tags
Plug 'tpope/vim-repeat'     " make vim-surround repeatable
Plug 'nvie/vim-flake8'   " Python linting

" Colorscheme
Plug 'projekt0n/github-nvim-theme'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

" Improved Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Github Copilot
Plug 'github/copilot.vim'

" lsp-zero config (https://github.com/VonHeikemen/lsp-zero.nvim)
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-omni'

"  Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'VonHeikemen/lsp-zero.nvim'

call plug#end()

" ----------------------------------
" PLUGIN OPTIONS
" ----------------------------------
" Lua config
lua require("usr.lspconfig")
lua require("usr.treesitter")
lua require("usr.ls")

" Color scheme
colorscheme github_light
hi StatusLine ctermfg=235
hi StatusLineNc ctermfg=235
hi VertSplit ctermfg=235

" Flake8
autocmd FileType python map <buffer> <leader>f :call flake8#Flake8()<CR>

" Telescope
nnoremap <C-P> <cmd>Telescope git_files show_untracked=true<cr>
nnoremap <C-F> <cmd>Telescope live_grep<cr>

" tcomment options
nnoremap <leader>h :TCommentAs html<CR>
vnoremap <leader>h :TCommentAs html<CR>

" netrw settings
let g:netrw_banner=0
let g:netrw_winsize=20
let g:netrw_liststyle=3
let g:netrw_localrmdir='rm -r'

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

"Copy/pasting on Mac with Terminal.app
" Automatic set paste toggle when CMD+V in insert mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction
" Copy to system clipboard (for visual selection mapping a somewhat crazy hack
" is used to copy the content without copying the full line)
nmap <leader>c :.w !pbcopy<CR><CR>
vnoremap <silent> <leader>c :<CR>:let @a=@" \| execute "normal! vgvy" \| let res=system("pbcopy", @") \| let @"=@a<CR>

" ----------------------------------
" Autocmds
" ----------------------------------
function! CompileLatex()
  let git_root = s:find_git_root()
  let current_dir = getcwd()
  if (git_root == current_dir)
    let tex_file = expand('%:p')
    let aux_file = expand('%:p:r')
    let pdf_file = aux_file . '.pdf'
  else
    let tex_file = git_root . '/main.tex'
    let aux_file = git_root . '/main'
    let pdf_file = git_root . '/main.pdf'
  endif
  cd `=git_root`
  " exec '!pdflatex '.tex_file.' && biber '.aux_file. ' && pdflatex '.tex_file. ' && echo "Compilation successful!"'
  exec '!pdflatex ' . tex_file . ' && biber ' . aux_file . ' && pdflatex '.tex_file. ' && open ' . pdf_file
endfunction

" Execute current buffer with <leader>m
" autocmd FileType python nnoremap <buffer> <leader>m :w<CR>:exec '!python' shellescape(@%, 1)<cr>
augroup neovim_terminal
    autocmd!
    " Enter Terminal-mode (insert) automatically
    autocmd TermOpen * startinsert
    " Disables number lines on terminal buffers
    autocmd TermOpen * :set nonumber norelativenumber
    " allows you to use Ctrl-c on terminal window
    autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
augroup END

" Execute current buffer with <leader>m
autocmd FileType python nnoremap <leader>m :w<CR>:term python %<CR>
autocmd filetype c nnoremap <leader>m :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd filetype cpp nnoremap <leader>m :w <bar> exec '!g++ -Wall -g -std=c++11 '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd filetype tex nnoremap <leader>m :w <bar> exec '!latexmk -pdf -xelatex ' shellescape(@%, 1) '&& open '.shellescape('%:r').'.pdf' <CR>
autocmd filetype tex nnoremap <leader>m :call CompileLatex()<CR>
autocmd filetype sh nnoremap <leader>m :w<CR>:term source %<cr>

" Remove trailing white spaces after save
autocmd BufWritePre * %s/\s\+$//e

" Make sure Markdown syntax highlighting works not only for .markdown but also for .md
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc

" Other syntax highlighting fixes
au BufNewFile,BufFilePre,BufRead *.njk set syntax=html
au BufNewFile,BufFilePre,BufRead Dockerfile.* set syntax=dockerfile

" Use 2 spaces for HTML files
autocmd BufRead,BufNewFile *.htm,*.html setlocal tabstop=2 shiftwidth=2 softtabstop=2

"  python scripts with wrong indentation:
" :%s/^\s*/&&/g
" Remove all control characters in documents:
" :%s/[[:cntrl:]]//g
" Sort numerically with regex pattern
" :sort /.\{-}\ze\d/ n
