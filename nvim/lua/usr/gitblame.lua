local M = {}

require('gitblame').setup {
     --Note how the `gitblame_` prefix is omitted in `setup`
    enabled = false,
    date_format = '%r',
    use_blame_commit_file_urls = true,
}

function M.show_blame_temporarily()
    vim.cmd('GitBlameEnable')
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'InsertEnter' }, {
        once = true,
        callback = function()
            vim.cmd('GitBlameDisable')
        end
    })
end

return M
