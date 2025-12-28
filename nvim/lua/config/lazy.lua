-- ============================================
-- Bootstrapping lazy.nvim
-- ============================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- ============================================
-- General config
-- ============================================
vim.opt.number = true           -- Line numbers
vim.opt.relativenumber = false  -- Relative line numbers off
vim.opt.scrolloff = 5           -- Keep 5 lines above/below cursor
vim.opt.wrap = false            -- No line wrapping
vim.opt.showmatch = true        -- Highlight matching brackets
vim.opt.foldenable = false      -- Disable code folding
vim.opt.wildignore:append({ '*/tmp/*', '*.so', '*.swp', '*.zip', '*/.git/*', '*/.DS_Store', '*/.idea' })

-- Search
vim.opt.hlsearch = false     -- Don't highlight search results
vim.opt.ignorecase = true    -- Case insensitive search
vim.opt.smartcase = true     -- Unless using capitals

-- Tabs & Indentation
vim.opt.tabstop = 4       -- Display tabs as 4 spaces
vim.opt.shiftwidth = 4    -- Indent by 4 spaces with >> and <<
vim.opt.expandtab = true  -- Convert tabs to spaces
vim.opt.autoindent = true -- Copy indent from current line when starting new line

-- Statusline
vim.opt.statusline = '%F %m'

-- Leader
vim.g.mapleader = ','

-- Netrw (file explorer)
vim.g.netrw_banner = 0            -- Hide banner
vim.g.netrw_winsize = 25          -- Window size
vim.g.netrw_liststyle = 3         -- Tree view
vim.g.netrw_hide = 0              -- Show all files

-- ============================================
-- Steup lazy.nvim
-- ============================================
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "github_light", "habamax" } },
  checker = { enabled = true, notify = false },
})
