" Disable Vi compatibility (only needed by vim).
set nocompatible

" Enable syntax highlighting.
if !exists("g:syntax_on")
	syntax enable
endif

" Load indentation rules and plugins according to the detected filetype.
filetype plugin indent on

" Keep undo history between restarts.
if has('persistent_undo')
	" Make sure that the undo directory exists.
	call system('mkdir -p "${HOME}/.vimundo/"')
	" Remove all undo files which were not accessed in the last 180 days.
	call system('find "${HOME}/.vimundo/" -type f -atime +180 -print0 | xargs -0 rm -f')
	set undodir=~/.vimundo/
	set undofile
endif

" Use true-colors when possible.
if has('termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" Basic settings.
set encoding=utf-8  " Use UTF-8 as file encoding.
set timeout         " Enable timeouts.
set timeoutlen=750  " Timeout for key combinations (in ms).
set ttimeoutlen=10  " Timeout for <ESC> key (in ms).
"set updatetime=500  " Write swap file after this many milliseconds

" Enhance usability.
set autoread        " Automatically read files when changed on disk.
set autowrite       " Automatically save before commands like :next and :make.
set hidden          " Hide buffers when they are abandoned.
set history=10000   " Remember more commands.
set hlsearch        " Highlight all found matches.
set ignorecase      " Do case insensitive matching.
set incsearch       " Incremental search.
set mouse=a         " Enable mouse usage (all modes).
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set smartcase       " Do smart case matching.
set wildmenu        " Show all options when using tab-complete.

" Changes in insert mode.
set backspace=indent,eol,start
set formatoptions+=j

" Indentation and tab options.
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

" Visual aids.
set colorcolumn=81
set cursorline
set display+=lastline
set nu
set rnu
set scrolloff=1

" Change leader to space key.
let mapleader="\<Space>"

" Enable matchit plugin (only needed by vim).
runtime macros/matchit.vim

" Easy editing of the vimrc file.
augroup vim_reload
	autocmd!
	"autocmd BufWritePost $MYVIMRC source $MYVIMRC | AirlineRefresh
	autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
nnoremap <silent> <leader>v :edit $MYVIMRC<CR>

" Enable spell checking.
set nospell
nnoremap <silent> <leader><leader>s :setlocal spelllang=en_us spell!<CR>
nnoremap <silent> <leader><leader>d :setlocal spelllang=de_de spell!<CR>

" General bindings.
" Use jj as alternative for escape.
inoremap jj <ESC>

" Switch to last buffer.
nnoremap <silent> <leader><leader>b :bprevious<CR>

" Toggle paste mode.
set pastetoggle=<F9>
nnoremap <silent> <leader><leader>p :set paste!<CR>

" Use ß or leader+m for jumping to marks (easier on a german keyboard).
nnoremap ß `
xnoremap ß `
nnoremap <leader>m `
xnoremap <leader>m `

" Clear search highlights.
nnoremap <silent> <ESC><ESC> :nohlsearch \| match none \| 2match none<CR>

" Move current or selected lines up and down.
nnoremap <silent> Ä :m .+1<CR>==
nnoremap <silent> Ü :m .-2<CR>==
xnoremap <silent> Ä :m '>+1<CR>gv=gv
xnoremap <silent> Ü :m '<-2<CR>gv=gv

" Mappings for resizing windows.
noremap <Left> <C-w><
noremap <Down> <C-w>-
noremap <Up> <C-w>+
noremap <Right> <C-w>>

" Mappings for moving windows.
noremap <leader><Left> <C-w>H
noremap <leader><Down> <C-w>J
noremap <leader><Up> <C-w>K
noremap <leader><Right> <C-w>L

" Run the current line through bash/ruby.
nnoremap !b !!bash<CR>
nnoremap !r !!ruby<CR>

" List settings.
set lcs=eol:¶,tab:‣\ ,space:·,trail:·,extends:»,precedes:«,nbsp:␣
nnoremap <silent> <leader><leader>l :set list!<CR>

"" Folding settings.
"" TODO: Check functionality
"set foldclose=all     " Close folds if you leave them in any way
"set foldcolumn=1      " Show the foldcolumn
"set nofoldenable      " Turn off folding
"set foldlevel=0       " Autofold everything by default
"set foldmethod=syntax " Fold on the syntax
"set foldopen=all      " Open folds if you touch them in any way
"set foldminlines=8    " Only close folds with more then 8 lines
"set foldnestmax=3     " Max level to which folds are closed
"" Toggle folding
"nnoremap <silent> <leader>z :set foldenable!<CR>
"" Increment local foldnestmax by 1
"nnoremap <leader>zi :let &l:foldnestmax = &l:foldnestmax + 1<CR>:setlocal foldnestmax?<CR>
"" Decrement local foldnestmax by 1
"nnoremap <leader>zd :let &l:foldnestmax = &l:foldnestmax - 1<CR>:setlocal foldnestmax?<CR>

" Settings per filetype.
augroup filetype_settings
	autocmd!
	autocmd FileType html,python,ruby,yaml
		\ setlocal ts=2 sts=2 sw=2 et textwidth=120 colorcolumn=121
	autocmd FileType python setlocal foldmethod=indent
augroup END

" Neovim specific settings.
if has('nvim')
	set inccommand=nosplit  " Shows the effects of a command as you type.
endif

" Temp settings.
colorscheme evening

