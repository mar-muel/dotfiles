local M = {}

-- GitHub browser function to open current file/line in GitHub web interface
M.gbrowse = function()
  -- Check if in a git repository
  local git_check = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null")
  if vim.v.shell_error ~= 0 then
    vim.notify("Not a git repository", vim.log.levels.WARN, { title = "gh browse" })
    return
  end

  -- Get current branch
  local branch = vim.fn.system("git branch --show-current"):gsub("\n", "")

  -- Get relative file path
  local filename = vim.fn.expand("%:p:~:.")

  -- Get current line number
  local lnum = vim.api.nvim_win_get_cursor(0)[1]

  -- Check if there's a file open
  if filename == "" then
    vim.notify("No filename", vim.log.levels.ERROR, { title = "gh browse" })
    return
  end

  -- Run gh browse command
  local cmd = { "gh", "browse", "-b", branch, filename .. ":" .. lnum }
  local result = vim.fn.system(cmd)

  -- Check if gh browse succeeded
  if vim.v.shell_error ~= 0 then
    vim.notify("Gbrowse error: " .. result, vim.log.levels.ERROR, { title = "gh browse" })
  else
    vim.notify("Opening GitHub...", vim.log.levels.INFO, { title = "gh browse" })
  end
end

return M
