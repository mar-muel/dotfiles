return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  branch = 'main',
  lazy = false,
  config = function()
    local parsers = { 'python', 'javascript', 'json', 'go', 'rust', 'lua', 'markdown', 'markdown_inline', 'svelte', 'typescript', 'tsx', 'css', 'html' }
    require('nvim-treesitter').install(parsers)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'python', 'javascript', 'json', 'go', 'rust', 'lua', 'markdown', 'svelte', 'typescript', 'typescriptreact', 'css', 'html' },
      callback = function() vim.treesitter.start() end,
    })
  end,
}
