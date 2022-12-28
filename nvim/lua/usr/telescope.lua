local M = {}

M.project_files = function()
  vim.fn.system('git rev-parse --is-inside-work-tree')
  if vim.v.shell_error == 0 then
    require("telescope.builtin").git_files({show_untracked = true})
  else
    require("telescope.builtin").find_files()
  end
end

return M
