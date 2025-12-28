return {
  'projekt0n/github-nvim-theme',
  name = 'github-theme',
  lazy = false,
  priority = 1000,
  config = function()
    require('github-theme').setup({})
    vim.cmd('colorscheme github_light')

    -- Displays inactive buffer in light gray color
    vim.api.nvim_set_hl(0, 'StatusLineNc', { fg = '#909090' })
  end,
}
