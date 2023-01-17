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
  use {'famiu/bufdelete.nvim'}
  use {'justinmk/vim-sneak', config = get_config('sneak')}
  use {
    'nvim-telescope/telescope.nvim',
    config = get_config('telescope'),
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
      {'kyazdani42/nvim-web-devicons'}
    }
  }

  -- Tools
  use {'folke/trouble.nvim', config = get_config('trouble'), requires = {'kyazdani42/nvim-web-devicons'}}
  use {'kyazdani42/nvim-tree.lua', config = get_config('tree'), requires = {'kyazdani42/nvim-web-devicons'}}
  use {'mbbill/undotree', config = get_config('undotree')}
  use {'simrat39/symbols-outline.nvim', config = get_config('outline')}

  -- General coding
  use {'ray-x/lsp_signature.nvim', config = get_config('lsp-signature')}
  use {'RRethy/nvim-treesitter-endwise', config = get_config('endwise')}
  use {'tpope/vim-surround'}
  --use {'windwp/nvim-autopairs', config = get_config('autopairs')}

  -- Testing
  use {'vim-test/vim-test', config = get_config('test'), requires = {'tpope/vim-dispatch'}}

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    config = get_config('lsp-zero'),
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      -- Snippet Collection (Optional)
      {'rafamadriz/friendly-snippets'},
    }
  }

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
