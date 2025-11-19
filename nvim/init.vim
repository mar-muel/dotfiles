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
set softtabstop=4 " How many columns to add when using TAB in insert mode
" Use :retab to apply those settings to new file!

" Use system Python
let g:python3_host_prog = '/usr/bin/python3'

" General key mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
inoremap jj <ESC>
" "this makes python comments indent
" inoremap # X<BS>#
" nnoremap <space> za

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

" allow moving left and right in insert mode
inoremap <C-l> <Right>
inoremap <C-h> <Left>
inoremap <C-o> <Esc>o

" Open vimrc file
nmap <leader>v :vsp<CR>:e $MYVIMRC<CR>
" Source vimrc
nmap <leader>s :source ~/.config/nvim/init.vim<CR>
" Call ctags
" nmap <leader>t :!ctags -f .git/tags .<CR>
" Open file tree
nnoremap <leader>n :Lexplore<CR>
" Use previously yanked (e.g. when pasting multiple times)
vnoremap <C-P> "0p

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Pretty format JSON
com! FormatJSON %!python3 -m json.tool

" ----------------------------------
" PLUGINS
" ----------------------------------
" Automatically install vim Plug if needed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'windwp/nvim-autopairs'  " Smart auto pair brackets
Plug 'numToStr/Comment.nvim'  " Comment in any language
Plug 'tpope/vim-surround'     " enables to edit surrounding brackets, tags, etc.
Plug 'tpope/vim-repeat'       " make vim-surround repeatable
Plug 'nvie/vim-flake8'        " Python linting

" Colorscheme
Plug 'projekt0n/github-nvim-theme'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }

" Improved Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" LSP
Plug 'neovim/nvim-lspconfig'   " manages launching/interactions with lsps
Plug 'hrsh7th/nvim-cmp'        " autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp'    " LSP source for nvim-cmp

"  Snippets
Plug 'L3MON4D3/LuaSnip', {'tag': 'v1.2.1', 'do': 'make install_jsregexp'}   " Snippets plugin
Plug 'saadparwaiz1/cmp_luasnip'                                             " Snippets source for nvim-cmp
Plug 'rafamadriz/friendly-snippets'                                         " Additional snippets

" Mason
Plug 'williamboman/mason.nvim'

" Null-ls
Plug 'jose-elias-alvarez/null-ls.nvim'

" Git worktrees
Plug 'ThePrimeagen/git-worktree.nvim'

call plug#end()

" ----------------------------------
" PLUGIN OPTIONS
" ----------------------------------
" Lua config
lua require("usr.lspconfig")
lua require("usr.treesitter")
lua require("usr.telescope")
lua require("usr.null_ls")

" Autopairs
lua require("nvim-autopairs").setup {}

" Load friendly snippets
lua require("luasnip.loaders.from_vscode").load()

" Color scheme
colorscheme github_light
hi StatusLine ctermfg=235
hi StatusLineNc ctermfg=235
hi VertSplit ctermfg=235

" Flake8
let g:flake8_cmd='/opt/homebrew/bin/flake8'
autocmd FileType python map <buffer> <leader>f :call flake8#Flake8()<CR>

" Telescope
nnoremap <C-P> <cmd>lua require('usr.telescope').project_files()<CR>
nnoremap <leader>q <cmd>lua require('telescope.builtin').find_files({ cwd = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h') })<CR>
nnoremap <C-P> <cmd>lua require('usr.telescope').project_files()<CR>
nnoremap <C-F> <cmd>Telescope live_grep<cr>
nnoremap <C-B> <cmd>lua require('telescope.builtin').git_bcommits()<CR>

" lsp
nnoremap <leader>g <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <leader>d <cmd>lua vim.diagnostic.open_float()<CR>
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
lua vim.diagnostic.config({signs = true, virtual_text = true})

" tcomment options
lua require('Comment').setup()

" netrw
let g:netrw_banner=0
let g:netrw_winsize=20
let g:netrw_liststyle=3
let g:netrw_localrmdir='rm -r'
nnoremap <leader>e <cmd>vsp<CR><cmd>Ex %:p:h<CR>

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

" Mason
lua require("mason").setup()

" Git worktrees
lua require("telescope").load_extension("git_worktree")
nnoremap <C-t> <cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
lua require("git-worktree").setup({ update_on_change_command = "lua require('usr.telescope').project_files()" })

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

" Open GitHub at any line
function! GbrowseWrapper()
  lua require('usr.custom').gbrowse()
endfunction
nnoremap <leader>gb :call GbrowseWrapper()<CR>

"  python scripts with wrong indentation:
" :%s/^\s*/&&/g
" Remove all control characters in documents:
" :%s/[[:cntrl:]]//g
" Sort numerically with regex pattern
" :sort /.\{-}\ze\d/ n
