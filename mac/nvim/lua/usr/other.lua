vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  group = curfile_augroup,
  callback = function ()
    local cur_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_create_autocmd({ 'WinClosed' }, {
      buffer = cur_buf,
      group = curfile_augroup,
      once = true,
      callback = function ()
        if vim.bo.filetype == 'TelescopePrompt' then return end
        vim.api.nvim_set_current_buf(vim.api.nvim_create_buf(true, false))
        vim.cmd('split')
      end,
    })
  end,
})
