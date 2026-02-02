-- Collection of Godot plugins and functions. This file must only be loaded when the environment variable
-- "NVIM_USE_GODOT" is set.
--
-- Also the following settings in Godot must be set (maybe needed to enable "Advanced Settings"):
-- Text Editor > External > Use External Editor = On
-- Text Editor > External > Exec Path = /usr/local/bin/nvim (Path to nvim executable)
-- Text Editor > External > Exec Flags =
--   --server {project}/server.pipe --remote-send "<C-\><C-N>:e {file}<CR>:call cursor({line}+1,{col})<CR>"
--
-- Then make sure that nvim is running and was started with a CWD inside the Godot project, before starting Godot.
--
-- When you want to use DAP for debugging, also make sure to enable "Debug with External Editor", see:
-- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#godot-gdscript

if not os.getenv("NVIM_USE_GODOT") then
  return {}
end

-- Function to find Godot project root directory
local function find_godot_project_root()
  local cwd = vim.fn.getcwd()
  local search_paths = { "", "/.." }

  for _, relative_path in ipairs(search_paths) do
    local project_file = cwd .. relative_path .. "/project.godot"
    if vim.uv.fs_stat(project_file) then
      return cwd .. relative_path
    end
  end

  return nil
end

-- Function to check if server is already running
local function is_server_running(project_path)
  local server_pipe = project_path .. "/server.pipe"
  return vim.uv.fs_stat(server_pipe) ~= nil
end

-- Function to start Godot server if needed
local function start_godot_server_if_needed()
  local godot_project_path = find_godot_project_root()

  if godot_project_path and not is_server_running(godot_project_path) then
    vim.fn.serverstart(godot_project_path .. "/server.pipe")
    return true
  end

  return false
end

-- Main execution
start_godot_server_if_needed()

return {
  { "habamax/vim-godot" },
  { "skywind3000/asyncrun.vim" },
  { "teatek/gdscript-extended-lsp.nvim", opts = { view_type = "floating" } },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gdscript = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "gdscript",
        "gdshader",
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "gdtoolkit",
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      dap.adapters.godot = {
        type = "server",
        host = "127.0.0.1",
        port = 6006,
      }
      dap.configurations.gdscript = {
        {
          type = "godot",
          request = "launch",
          name = "Launch scene",
          project = "${workspaceFolder}",
        },
      }
    end,
  },
}
