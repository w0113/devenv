" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
set incsearch       " Incremental search
set autowrite       " Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned
set mouse=a         " Enable mouse usage (all modes)

" This is used for easy plugin installation:
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Change leader to space key:
let mapleader="\<Space>"

" vim settings:
set encoding=utf-8   " Use UTF-8 as file encoding.
set t_Co=256         " Vim needs this setting to use colors.
set timeout          " Enable timeouts.
set timeoutlen=750   " Timeout for key combinations (in ms).
set ttimeoutlen=10   " Timeout for <ESC> key (in ms).

" General filetype settings:
set nu
set rnu
set tabstop=4
set shiftwidth=4
set noexpandtab

" Settings per filetype:
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 expandtab

" Highlight settings:
highlight LineNr ctermfg=Black ctermbg=Grey
highlight CursorLineNr cterm=bold ctermfg=Black ctermbg=Grey

" General bindings:
imap jj <ESC>
nnoremap <silent> ä :m .+1<CR>==
nnoremap <silent> ü :m .-2<CR>==
vnoremap <silent> ä :m '>+1<CR>gv=gv
vnoremap <silent> ü :m '<-2<CR>gv=gv
map <silent> <A-h> <C-w><
map <silent> <A-j> <C-w>-
map <silent> <A-k> <C-w>+
map <silent> <A-l> <C-w>> 

" Settings for airline
set noshowmode
set laststatus=2
let g:airline#extensions#syntastic#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tagbar#enabled=1
let g:airline_powerline_fonts=1

" Settings for CtrlP:
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=128
let g:ctrlp_map='<leader>p'
nnoremap <leader>o :CtrlPBuffer<CR>
nnoremap <leader><leader>o :b#<CR>
nnoremap <leader>l :CtrlPLine<CR>

" Settings for EasyMotion
map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_keys='asdklöqwertzuiopyxcvbnm,.-fghj'

" Settings for Expand-Region:
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Settings for NERDTree:
nmap <leader><leader>n :NERDTreeToggle<CR>

" Settings for syntastic:
let g:syntastic_ruby_mri_exec="~/.rbenv/shims/ruby"
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

" Settings for Tagbar:
let g:tagbar_autoclose=1
nmap <leader><leader>t :TagbarToggle<CR>

" Settings for vimux:
nmap <Leader>r :call VimuxPromptCommand()<CR>
nmap <Leader>rc :call VimuxCloseRunner()<CR>
nmap <Leader>rs :call VimuxRunCommand("clear; ./" . bufname("%"))<CR>
nmap <Leader>rz :call VimuxRunCommand("clear; ./" . bufname("%"))<CR>:call VimuxZoomRunner()<CR>

