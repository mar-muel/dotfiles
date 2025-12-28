return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({})
    end,
  },
  {
    'tpope/vim-surround',
  },
  {
    'tpope/vim-repeat',
  },
  {
    'Vimjas/vim-python-pep8-indent',
    ft = 'python',
  },
}
