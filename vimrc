" Disable Vi compatibility
set nocompatible

" This is used for easy plugin installation:
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has('autocmd')
	filetype plugin indent on
endif

" Keep undo history between restarts.
if has('persistent_undo')
	call system('mkdir -p "${HOME}/.vimundo/"')
	set undodir=~/.vimundo/
	set undofile
	" Remove all undo files which were not accessed in the last 180 days.
	call system('find "${HOME}/.vimundo/" -type f -atime +180 -print0 | xargs -0 rm -f')
endif

" Vim suggested options.
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
set incsearch       " Incremental search
set autowrite       " Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned
set mouse=a         " Enable mouse usage (all modes)

" Change leader to space key:
let mapleader="\<Space>"

" vim settings:
set encoding=utf-8  " Use UTF-8 as file encoding.
set t_Co=256        " Enable vim colors.
set timeout         " Enable timeouts.
set timeoutlen=750  " Timeout for key combinations (in ms).
set ttimeoutlen=10  " Timeout for <ESC> key (in ms).

" General filetype settings:
set nu
set rnu
set tabstop=4
set shiftwidth=4
set noexpandtab

" Settings per filetype:
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 expandtab

" Enable matchit plugin:
runtime macros/matchit.vim

" Highlight settings:
highlight LineNr ctermfg=Grey ctermbg=Black
highlight CursorLineNr cterm=bold ctermfg=Grey ctermbg=Black

" General bindings:
" Use jj as alternative for escape.
imap jj <ESC>
" Move current or selected lines up and down.
nnoremap <silent> ä :m .+1<CR>==
nnoremap <silent> ü :m .-2<CR>==
vnoremap <silent> ä :m '>+1<CR>gv=gv
vnoremap <silent> ü :m '<-2<CR>gv=gv

" TODO: Not working correctly:
"map <silent> <C-Left> <C-w><
"map <silent> <C-Down> <C-w>-
"map <silent> <C-Up> <C-w>+
"map <silent> <C-Right> <C-w>>

" Yank current line without leading and trailing whitespaces.
nnoremap <leader>yy ^yg_
" Delete current line without leading and trailing whitespaces,
" then delete the complete line without writing into a register.
nnoremap <leader>dd ^dg_"_dd

" Run the current line through bash/ruby
nnoremap !b !!bash<CR>
nnoremap !r !!ruby<CR>

" Settings for airline
set noshowmode
set laststatus=2
let g:airline_theme='luna'
let g:airline#extensions#syntastic#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tagbar#enabled=1
let g:airline_powerline_fonts=1

" Settings for CtrlP:
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=128
let g:ctrlp_map='<leader>p'
let g:ctrlp_working_path_mode='rw'  " Needed for CtrlP to change root accordingly.
nnoremap <leader>o :CtrlPBuffer<CR>
nnoremap <leader><leader>o :b#<CR>
nnoremap <leader>l :CtrlPLine<CR>

" Settings for EasyMotion
map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_keys='asdklöqwertzuiopyxcvbnm,.-fghj'

" Settings for Expand-Region:
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
call expand_region#custom_text_objects({'a]':1, 'ab':1, 'aB':1,})
call expand_region#custom_text_objects('ruby', {'im':0, 'am':0, 'iM':0, 'aM':0})

" Settings for NERDTree:
nmap <leader><leader>n :NERDTreeToggle<CR>
let g:NERDTreeChDirMode=2  " Needed for CtrlP to change root accordingly.

" Settings for syntastic:
let g:syntastic_ruby_mri_exec="~/.rbenv/shims/ruby"
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

" Settings for Tagbar:
let g:tagbar_autoclose=1
nmap <leader><leader>t :TagbarToggle<CR>

" Settings for Undotree:
nnoremap <leader><leader>u :UndotreeToggle<CR>

" Settings for vimux:
nmap <leader>r :call VimuxRunCommand("clear; ./" . bufname("%"))<CR>
nmap <leader>rz :call VimuxRunCommand("clear; ./" . bufname("%"))<CR>:call VimuxZoomRunner()<CR>
nmap <leader>rc :call VimuxPromptCommand()<CR>
nmap <leader>rcz :call VimuxPromptCommand()<CR>:call VimuxZoomRunner()<CR>
nmap <leader>rl :call VimuxRunLastCommand()<CR>
nmap <leader>rlz :call VimuxRunLastCommand()<CR>:call VimuxZoomRunner()<CR>
nmap <leader>rr :call VimuxRunCommand("clear; find '" . getcwd() . "' -maxdepth 1 -type f -executable -exec '{}' \\\\;")<CR>
nmap <leader>rrz :call VimuxRunCommand("clear; find '" . getcwd() . "' -maxdepth 1 -type f -executable -exec '{}' \\\\;")<CR>:call VimuxZoomRunner()<CR>
nmap <leader>rq :call VimuxCloseRunner()<CR>

