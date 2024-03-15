-- Open help view in a vertical split
vim.api.nvim_create_user_command("H", function(opts)
  local cmd = "vertical botright help"
  if opts["args"] then
    cmd = cmd .. " " .. opts["args"]
  end
  vim.cmd(cmd)
end, {complete = "help", desc = "Open help vertically", nargs = "*"})
