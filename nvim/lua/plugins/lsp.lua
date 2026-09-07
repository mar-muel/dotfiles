return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'pyrefly', 'rust_analyzer', 'gopls' },
        automatic_enable = false,
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Python
      vim.lsp.config('pyrefly', {
        capabilities = capabilities,
        cmd = { 'uvx', 'pyrefly@1.2.0', 'lsp' },
        root_markers = { 'uv.lock' },
      })
      vim.lsp.enable('pyrefly')

      -- Rust
      vim.lsp.config('rust_analyzer', {
        capabilities = capabilities,
        settings = {
          ['rust-analyzer'] = {
            check = {
              command = 'clippy',
            },
            diagnostics = {
              enable = true,
            }
          }
        }
      })
      vim.lsp.enable('rust_analyzer')

      -- Go
      vim.lsp.config('gopls', {
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
          },
        },
      })
      vim.lsp.enable('gopls')
    end,
  },
}
