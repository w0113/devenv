
call plug#begin('~/.config/nvim/plugged/')
Plug 'airblade/vim-gitgutter'
"Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'godlygeek/tabular'
Plug 'gregsexton/gitv', {'on': ['Gitv']}
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'easymotion/vim-easymotion'
Plug 'majutsushi/tagbar', {'on': ['TagbarToggle']}
Plug 'mbbill/undotree', {'on': ['UndotreeToggle']}
Plug 'michaeljsmith/vim-indent-object'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle']}
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails', {'for': 'ruby'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes.git'
Plug 'vim-ruby/vim-ruby.git', {'for': 'ruby'}
Plug 'w0113/vim-textobj-rubyblock.git'
call plug#end()

