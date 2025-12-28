require("config.lazy")

-- ============================================
-- Key mappings
-- ============================================
-- Quick escape
vim.keymap.set('i', 'jj', '<Esc>')

-- Window navigation with auto-split
local function win_move(key)
  local curwin = vim.fn.winnr()
  vim.cmd('wincmd ' .. key)
  if curwin == vim.fn.winnr() then
    if key:match('[hl]') then
      vim.cmd('wincmd v')
    else
      vim.cmd('wincmd s')
    end
    vim.cmd('wincmd ' .. key)
  end
end

vim.keymap.set('n', '<C-h>', function() win_move('h') end)
vim.keymap.set('n', '<C-j>', function() win_move('j') end)
vim.keymap.set('n', '<C-k>', function() win_move('k') end)
vim.keymap.set('n', '<C-l>', function() win_move('l') end)

-- Reload config
vim.keymap.set('n', '<leader>s', ':luafile ~/.config/nvim/init.lua<CR>')

-- Telescope
vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<C-f>', '<cmd>Telescope live_grep<CR>')
vim.keymap.set('n', '<C-b>', '<cmd>Telescope git_bcommits<CR>')
vim.keymap.set('n', '<leader>q', function()
  require('telescope.builtin').find_files({ cwd = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h') })
end)

-- Git blame
local function show_blame_temporarily()
  vim.cmd('GitBlameEnable')
  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'InsertEnter' }, {
    once = true,
    callback = function()
      vim.cmd('GitBlameDisable')
    end
  })
end

vim.keymap.set('n', '<leader>b', show_blame_temporarily)
vim.keymap.set('n', '<leader>ob', '<cmd>GitBlameOpenFileURL<CR>')

-- Copy to system clipboard
vim.keymap.set('n', '<leader>c', '"+yy')
vim.keymap.set('v', '<leader>c', '"+y')

-- LSP
vim.keymap.set('n', '<leader>g', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)

-- LSP diagnostic config
vim.diagnostic.config({ signs = true, virtual_text = true })

-- Center on movements
vim.keymap.set('n', '}', '}zz')
vim.keymap.set('n', '{', '{zz')
vim.keymap.set('n', '*', '*zz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', 'L', 'Lzz')
vim.keymap.set('n', 'H', 'Hzz')
vim.keymap.set('n', 'M', 'Mzz')

-- Keep cursor position when joining lines
vim.keymap.set('n', 'J', 'mzJ`z')

-- Make Y behave like C, D, etc.
vim.keymap.set('n', 'Y', 'y$')

-- Comma motions
vim.keymap.set('n', 'di,', 'f,dT,', { remap = true })
vim.keymap.set('n', 'ci,', 'f,cT,', { remap = true })

-- Set undo break points for certain characters
vim.keymap.set('i', ',', ',<c-g>u')
vim.keymap.set('i', '.', '.<c-g>u')
vim.keymap.set('i', '!', '!<c-g>u')
vim.keymap.set('i', '?', '?<c-g>u')

-- Insert mode navigation
vim.keymap.set('i', '<C-l>', '<Right>')
vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-o>', '<Esc>o')

-- Open vimrc
vim.keymap.set('n', '<leader>v', ':vsp<CR>:e $MYVIMRC<CR>')

-- File explorer
vim.keymap.set('n', '<leader>e', ':Lexplore<CR>')

-- Sudo save
vim.keymap.set('c', 'w!!', 'w !sudo tee > /dev/null %')


vim.g.pyindent_open_paren = vim.opt.shiftwidth

-- ============================================
-- Autocmds
-- ============================================
-- Help opens in current window instead of split
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  callback = function()
    vim.cmd('only')
  end,
})

-- Netrw window navigation override
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'netrw',
  callback = function()
    vim.keymap.set('n', '<C-l>', function() win_move('l') end, { buffer = true })
  end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

-- Immediately start in insert mode in terminal (e.g. when running pdb)
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.cmd('startinsert')
  end,
})

-- Execute current buffer with <leader>m
local execute_commands = {
  python = ':w<CR>:term python %<CR>',
  c = ':w <bar> exec "!gcc " . shellescape(expand("%")) . " -o " . shellescape(expand("%:r")) . " && ./" . shellescape(expand("%:r"))<CR>',
  cpp = ':w <bar> exec "!g++ -Wall -g -std=c++11 " . shellescape(expand("%")) . " -o " . shellescape(expand("%:r")) . " && ./" . shellescape(expand("%:r"))<CR>',
  sh = ':w<CR>:term source %<CR>',
}

for filetype, command in pairs(execute_commands) do
  vim.api.nvim_create_autocmd('FileType', {
    pattern = filetype,
    callback = function()
      vim.keymap.set('n', '<leader>m', command, { buffer = true })
    end,
  })
end

-- Filetype settings
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufFilePre', 'BufRead' }, {
  pattern = '*.md',
  command = 'set filetype=markdown.pandoc',
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufFilePre', 'BufRead' }, {
  pattern = '*.njk',
  command = 'set syntax=html',
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.htm', '*.html' },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- ============================================
-- Functions
-- ============================================
-- Open current file on GitHub at current line/range
local function open_github_url(mode)
  local file = vim.fn.expand('%')
  local line_range

  if mode == 'v' then
    -- Visual mode: get selected line range
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    line_range = string.format('%d-%d', start_line, end_line)
  else
    -- Normal mode: get current line
    line_range = tostring(vim.fn.line('.'))
  end

  -- Get current branch
  local branch = vim.fn.systemlist('git rev-parse --abbrev-ref HEAD')[1]

  -- Check if branch exists on remote
  vim.fn.system('git rev-parse --verify origin/' .. branch .. ' 2>/dev/null')

  local cmd
  if vim.v.shell_error == 0 then
    -- Branch exists remotely, use it
    cmd = string.format('gh browse --branch %s %s:%s', branch, file, line_range)
  else
    -- Branch doesn't exist remotely, use default branch
    cmd = string.format('gh browse %s:%s', file, line_range)
  end

  vim.fn.system(cmd)

  if vim.v.shell_error ~= 0 then
    vim.notify('Failed to open GitHub URL. Is gh installed?', vim.log.levels.ERROR)
  end
end

vim.keymap.set('n', '<leader>gb', function() open_github_url('n') end)
vim.keymap.set('v', '<leader>gb', function() open_github_url('v') end)

-- ============================================
-- Commands
-- ============================================
-- Pretty format JSON
vim.api.nvim_create_user_command('FormatJSON', '%!/usr/bin/python3 -m json.tool', {})
