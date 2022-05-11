-- Returns the require for use in `config` parameter of packer's use and expects the name of the config file
function get_config(name)
	return string.format('require("config/%s")', name)
end

-- Bootstrap packer.nvim
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
                                install_path})
end

-- Only continue when we could load packer.nvim
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Plugins
return packer.startup(function(use)
  -- System
  use {'nvim-treesitter/nvim-treesitter', config = get_config('treesitter'), run = ':TSUpdate'}
  use {'nvim-treesitter/nvim-treesitter-textobjects'}
  use {'wbthomason/packer.nvim'}

  -- Visual
  use {'EdenEast/nightfox.nvim', config = get_config('colorscheme')}
  use {'lewis6991/gitsigns.nvim', config = get_config('gitsigns')}
  use {'lukas-reineke/indent-blankline.nvim', config = get_config('indent-blankline')}
  use {'nvim-lualine/lualine.nvim', config = get_config('lualine'), requires = {'kyazdani42/nvim-web-devicons'}}

  -- Usability
  --use {'easymotion/vim-easymotion', config = get_config('easymotion')}
  use {'famiu/bufdelete.nvim'}
  use {'justinmk/vim-sneak', config = get_config('sneak')}
  use {'nvim-telescope/telescope.nvim', config = get_config('telescope'), requires = {{'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}, {'kyazdani42/nvim-web-devicons'}}}

  -- Tools
  use {'kyazdani42/nvim-tree.lua', config = get_config('tree'), requires = {'kyazdani42/nvim-web-devicons'}}
  use {'mbbill/undotree', config = get_config('undotree')}
  use {'simrat39/symbols-outline.nvim', config = get_config('outline')}

  -- General coding
  use {'tpope/vim-endwise'}
  use {'tpope/vim-surround'}

  -- Testing
  use {'vim-test/vim-test', config = get_config('test'), requires = {'tpope/vim-dispatch'}}

  -- Completion
  use {'f3fora/cmp-spell'}
  use {'hrsh7th/cmp-buffer'}
  use {'hrsh7th/cmp-cmdline'}
  use {'hrsh7th/cmp-nvim-lsp'}
  use {'hrsh7th/cmp-nvim-lua'}
  use {'hrsh7th/cmp-path'}
  use {'hrsh7th/nvim-cmp', config = get_config('cmp'), requires = {'neovim/nvim-lspconfig'}}
  use {'onsails/lspkind.nvim'}

  -- Snippets
  use {'L3MON4D3/LuaSnip', config = get_config('luasnip'), requires = {'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets'}}

  -- Git
  use {'tpope/vim-fugitive', config = get_config('fugitive')}
  use {'junegunn/gv.vim', cmd = {'GV'}}

  -- Ruby
  use {'tpope/vim-rails', ft = {'ruby'}}
  use {'vim-ruby/vim-ruby', ft = {'ruby'}}
  use {'tpope/vim-bundler'}

  -- Other
  use {'aserebryakov/vim-todo-lists'}
 
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    packer.sync()
  end
end)
