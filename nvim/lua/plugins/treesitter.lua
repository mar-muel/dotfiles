return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    local parsers = { 'python', 'javascript', 'json', 'go', 'rust', 'lua', 'markdown' }
    require('nvim-treesitter').install(parsers):wait(30000)

    require('nvim-treesitter').setup({
      highlight = { enable = true },
      indent = { enable = false },
    })
  end,
}
