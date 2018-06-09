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
	" Make sure that the undo directory exists.
	call system('mkdir -p "${HOME}/.vimundo/"')
	" Remove all undo files which were not accessed in the last 180 days.
	call system('find "${HOME}/.vimundo/" -type f -atime +180 -print0 | xargs -0 rm -f')
	set undodir=~/.vimundo/
	set undofile
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
set autoread       " Automatically read files when changed on disk
set encoding=utf-8 " Use UTF-8 as file encoding.
set t_Co=256       " Set vim colorspace to 256 colors.
set timeout        " Enable timeouts.
set timeoutlen=750 " Timeout for key combinations (in ms).
set ttimeoutlen=10 " Timeout for <ESC> key (in ms).
set wildmenu       " Show all options when using tab-complete.

" General filetype settings:
set nu
set rnu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set noexpandtab

" Visual aids:
set colorcolumn=81
set cursorline
set hlsearch

" Enable matchit plugin:
runtime macros/matchit.vim

" Enable spell checking:
set nospell
set spelllang=en_us
nnoremap <silent> <leader><leader>s :setlocal spell!<CR>

" Color settings:
" Set some color details depending on light or dark colorscheme
function! ColorschemeDetails() abort
	if &background == "light"
		highlight NonText term=NONE cterm=NONE ctermfg=14 ctermbg=15
		highlight SpecialKey term=NONE cterm=NONE ctermfg=14 ctermbg=15
		highlight IndentGuidesOdd ctermfg=14 ctermbg=15
		highlight IndentGuidesEven ctermfg=14 ctermbg=7
		highlight ALEErrorSign ctermfg=9 ctermbg=7
		highlight ALEWarningSign ctermfg=3 ctermbg=7
		highlight ALEInfoSign ctermfg=2 ctermbg=7
		highlight ALEStyleErrorSign ctermfg=9 ctermbg=7
		highlight ALEStyleWarningSign ctermfg=3 ctermbg=7
		highlight UndesiredCharacters ctermfg=14 ctermbg=9
		let g:airline_solarized_bg='light'
		let g:limelight_conceal_ctermfg=14
	else
		highlight NonText term=NONE cterm=NONE ctermfg=10 ctermbg=8
		highlight SpecialKey term=NONE cterm=NONE ctermfg=10 ctermbg=8
		highlight IndentGuidesOdd ctermfg=10 ctermbg=8
		highlight IndentGuidesEven ctermfg=10 ctermbg=0
		highlight ALEErrorSign ctermfg=9 ctermbg=0
		highlight ALEWarningSign ctermfg=3 ctermbg=0
		highlight ALEInfoSign ctermfg=2 ctermbg=0
		highlight ALEStyleErrorSign ctermfg=9 ctermbg=0
		highlight ALEStyleWarningSign ctermfg=3 ctermbg=0
		highlight UndesiredCharacters ctermfg=10 ctermbg=9
		let g:airline_solarized_bg='dark'
		let g:limelight_conceal_ctermfg=10
	endif
endfunction
augroup colorscheme_settings
	autocmd!
	autocmd VimEnter,Colorscheme * call ColorschemeDetails()
augroup END
" Set colorscheme
set background=dark
colorscheme solarized
" Toggle between dark and light colorscheme.
call togglebg#map("<F5>")

" General bindings:
" Use jj as alternative for escape.
inoremap jj <ESC>

" Toggle paste mode:
set pastetoggle=<F9>
nnoremap <silent> <leader><leader>p :set paste!<CR>

" Use ß or leader+m for jumping to marks (easier on a german keyboard):
nnoremap ß `
xnoremap ß `
nnoremap <leader>m `
xnoremap <leader>m `

" Find tabs and trailing whitespaces:
nnoremap <silent> <leader>s :2match UndesiredCharacters /\v(\t\|\s+$)/<CR>

" Clear search highlights:
nnoremap <silent> <ESC><ESC> :nohlsearch \| match none \| 2match none<CR>

" Move current or selected lines up and down.
nnoremap <silent> Ä :m .+1<CR>==
nnoremap <silent> Ü :m .-2<CR>==
xnoremap <silent> Ä :m '>+1<CR>gv=gv
xnoremap <silent> Ü :m '<-2<CR>gv=gv

" Mappings for resizing windows:
noremap <Left> <C-w><
noremap <Down> <C-w>-
noremap <Up> <C-w>+
noremap <Right> <C-w>>

" Mappings for moving windows:
noremap <leader><Left> <C-w>H
noremap <leader><Down> <C-w>J
noremap <leader><Up> <C-w>K
noremap <leader><Right> <C-w>L

" Run the current line through bash/ruby
nnoremap !b !!bash<CR>
nnoremap !r !!ruby<CR>

" List settings
set lcs=eol:¶,tab:‣\ ,space:·,trail:·,extends:»,precedes:«,nbsp:␣
nnoremap <silent> <leader><leader>l :set list!<CR>

" Folding settings
set foldclose=all     " Close folds if you leave them in any way
set foldcolumn=1      " Show the foldcolumn
set nofoldenable      " Turn off folding
set foldlevel=0       " Autofold everything by default
set foldmethod=syntax " Fold on the syntax
set foldopen=all      " Open folds if you touch them in any way
set foldminlines=8    " Only close folds with more then 8 lines
set foldnestmax=3     " Max level to which folds are closed
" Toggle folding
nnoremap <silent> <leader>z :set foldenable!<CR>
" Increment local foldnestmax by 1
nnoremap <leader>zi :let &l:foldnestmax = &l:foldnestmax + 1<CR>:setlocal foldnestmax?<CR>
" Decrement local foldnestmax by 1
nnoremap <leader>zd :let &l:foldnestmax = &l:foldnestmax - 1<CR>:setlocal foldnestmax?<CR>

" Custom search commands
command! -bar -nargs=1 Grep silent execute "grep -IR --exclude-dir=.git '<args>' *" | redraw! | copen
command! -bar -nargs=1 Fgrep silent execute "grep -FIR --exclude-dir=.git '<args>' *" | redraw! | copen
nnoremap <leader>g :execute "Fgrep " . expand("<cword>")<CR>

" Settings per filetype:
augroup filetype_settings
	autocmd!
	autocmd FileType html,python,ruby,yaml
		\ setlocal ts=2 sts=2 sw=2 et textwidth=120 colorcolumn=121
	autocmd FileType python setlocal foldmethod=indent
augroup END

" Settings for airline
set noshowmode
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tagbar#enabled=1

" Settings for Ale
let g:ale_sign_column_always = 1
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_sign_info = 'I'
let g:ale_sign_style_error = 'e'
let g:ale_sign_style_warning = 'w'

" Settings for EasyMotion
nmap <leader>f <Plug>(easymotion-s)
nmap <leader>F <Plug>(easymotion-s)
nmap <leader>t <Plug>(easymotion-bd-t)
nmap <leader>T <Plug>(easymotion-bd-t)
nmap <leader>w <Plug>(easymotion-bd-w)
nmap <leader>b <Plug>(easymotion-bd-w)
nmap <leader>W <Plug>(easymotion-bd-W)
nmap <leader>B <Plug>(easymotion-bd-W)
nmap <leader>e <Plug>(easymotion-bd-e)
nmap <leader>E <Plug>(easymotion-bd-E)
nmap <leader>j <Plug>(easymotion-bd-jk)
nmap <leader>k <Plug>(easymotion-bd-jk)
let g:EasyMotion_keys='asdklöqwertzuiopyxcvbnm,.-fghj'

" Settings for Expand-Region:
xmap v <Plug>(expand_region_expand)
xmap <C-v> <Plug>(expand_region_shrink)
call expand_region#custom_text_objects({'a]':1, 'ab':1, 'aB':1,})
call expand_region#custom_text_objects('ruby', {'ar':1, 'ir':1})

" Settings for fzf:
let g:fzf_command_prefix = 'Fzf'
nnoremap ss :FzfFiles<CR>
nnoremap sg :FzfGFiles<CR>
nnoremap sb :FzfBuffers<CR>
nnoremap sa :FzfAg<CR>
nnoremap sla :FzfLines<CR>
nnoremap sl :FzfBLines<CR>
nnoremap sm :FzfMarks<CR>
nnoremap sh :FzfHistory:<CR>
nnoremap sc :FzfCommits<CR>
nnoremap s. :FzfCommands<CR>
nnoremap sh :FzfHelptags<CR>

" Settings for Indent-Guides:
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar']
let g:indent_guides_auto_colors = 0
let g:indent_guides_default_mapping = 0
nnoremap <silent> <leader><leader>i :IndentGuidesToggle<CR>

" Settings for Limelight:
nnoremap <silent> <F6> :Limelight!!<CR>
inoremap <silent> <F6> <C-o>:Limelight!!<CR>
xnoremap <silent> <F6> :Limelight!!<CR>gv

" Settings for lsp:


" Settings for NERDTree:
nnoremap <leader><leader>n :NERDTreeToggle<CR>
let g:NERDTreeChDirMode = 2  " Needed for fzf to change root accordingly.

" Settings for Tagbar:
let g:tagbar_autoclose = 1
nnoremap <leader><leader>t :TagbarToggle<CR>

" Settings for Undotree:
nnoremap <leader><leader>u :UndotreeToggle<CR>

" Settings for unimpaired:
" Use ö and ä instead of [ and ].
let g:nremap = {"[": "ö", "]": "ä"}
let g:xremap = {"[": "ö", "]": "ä"}
let g:oremap = {"[": "ö", "]": "ä"}

" Settings for vimux:
nnoremap <leader>r :call VimuxRunCommand("clear; ./" . bufname("%"))<CR>
nnoremap <leader>rz :call VimuxRunCommand("clear; ./" . bufname("%"))<CR>:call VimuxZoomRunner()<CR>
nnoremap <leader>rc :call VimuxPromptCommand()<CR>
nnoremap <leader>rcz :call VimuxPromptCommand()<CR>:call VimuxZoomRunner()<CR>
nnoremap <leader>rl :call VimuxRunLastCommand()<CR>
nnoremap <leader>rlz :call VimuxRunLastCommand()<CR>:call VimuxZoomRunner()<CR>
nnoremap <leader>rr :call VimuxRunCommand("clear; find '" . getcwd() . "' -maxdepth 1 -type f -executable -exec '{}' \\\\;")<CR>
nnoremap <leader>rrz :call VimuxRunCommand("clear; find '" . getcwd() . "' -maxdepth 1 -type f -executable -exec '{}' \\\\;")<CR>:call VimuxZoomRunner()<CR>
nnoremap <leader>rq :call VimuxCloseRunner()<CR>

