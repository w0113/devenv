" Disable Vi compatibility (only needed by vim).
set nocompatible

" Enable syntax highlighting.
if !exists('g:syntax_on')
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

" Use true-colors.
if has('termguicolors')
	let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" Basic settings.
set encoding=utf-8  " Use UTF-8 as file encoding.
set timeout         " Enable timeouts.
set timeoutlen=750  " Timeout for key combinations (in ms).
set ttimeoutlen=10  " Timeout for <ESC> key (in ms).
set updatetime=1000 " Write swap file after this many milliseconds.
set shortmess+=I    " Disable intro message when starting vim.

" Enhance usability.
set autoread        " Automatically read files when changed on disk.
set autowrite       " Automatically save before commands like :next and :make.
set hidden          " Hide buffers when they are abandoned.
set history=10000   " Remember more commands.
set hlsearch        " Highlight all found matches.
set ignorecase      " Do case insensitive matching.
set incsearch       " Incremental search.
set isfname-==      " Do not recognize '=' as part of a file name.
set mouse=a         " Enable mouse usage (all modes).
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set signcolumn=yes  " Always show sign column.
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
nnoremap <silent> <leader><leader>b :b#<CR>

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Windows
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings for resizing windows.
noremap <Left> <C-w><
noremap <Down> <C-w>-
noremap <Up> <C-w>+
noremap <Right> <C-w>>

" Mappings for moving windows.
nnoremap <leader><Left>  <C-w>H
nnoremap <leader><Down>  <C-w>J
nnoremap <leader><Up>    <C-w>K
nnoremap <leader><Right> <C-w>L

" Mappings for switching windows.
inoremap <C-h> <C-\><C-o><C-w>h
inoremap <C-j> <C-\><C-o><C-w>j
inoremap <C-k> <C-\><C-o><C-w>k
inoremap <C-l> <C-\><C-o><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Execute line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap !b !!bash<CR>
nnoremap !r !!ruby<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" List
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set lcs=eol:¶,tab:‣\ ,space:·,trail:·,extends:»,precedes:«,nbsp:␣
nnoremap <silent> <leader><leader>l :set list!<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup filetype_settings
	autocmd!
	autocmd FileType html,javascript,json,python,ruby,yaml
		\ setlocal ts=2 sts=2 sw=2 et textwidth=120 colorcolumn=121
	autocmd FileType python setlocal foldmethod=indent
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neovim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('nvim')
	set inccommand=nosplit  " Shows the effects of a command as you type.

	" Also enable navigation mappings in neovims terminal.
	tnoremap <C-h> <C-\><C-n><C-w>h
	tnoremap <C-j> <C-\><C-n><C-w>j
	tnoremap <C-k> <C-\><C-n><C-w>k
	tnoremap <C-l> <C-\><C-n><C-w>l

	" Also enable mappings for resizing windows.
	tnoremap <Left> <C-w><
	tnoremap <Down> <C-w>-
	tnoremap <Up> <C-w>+
	tnoremap <Right> <C-w>>

	" Use leader+escape to leave terminal mode.
	tnoremap <leader><ESC> <C-\><C-n>
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neovim send command to terminal
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('nvim')
	" Where should a new terminal be positioned? Possible values:
	" left, right, top or bottom
	let s:send_term_split_pos = 'bottom'
	" Character width/height of new terminal window.
	let s:send_term_split_size = 15

	" Name of the variable to identify the terminal buffer. Usually no need to
	" edit this.
	let s:send_term_id_var_name = 'is_send_term_buffer'

	"
	" Execute a shell command inside a terminal in a split window.
	" arg cmd: The command as string which should be executed.
	"
	function! SendTermCmdTerminal(cmd) abort
		let l:jid = SendTermOpenTerminal()
		if strlen(a:cmd) > 0
			" Send the command if one is given.
			call jobsend(l:jid, a:cmd . "\n")
		endif
	endfunction

	"
	" Get the job ID of the shell within the terminal.
	" Returns: The job ID of the shell running inside the terminal.
	"
	function! SendTermOpenTerminal() abort
		" Find the first buffer with a running terminal and the id variable set.
		let l:bs = filter(getbufinfo(),
			\ 'has_key(v:val["variables"], "' . s:send_term_id_var_name . '") '
			\ . '&& getbufvar(v:val["bufnr"], "&")["buftype"] == "terminal"')
		" Either open a new terminal or show the current terminal and return the
		" job ID of the shell running inside the terminal.
		return len(l:bs) > 0 ? SendTermOpenTerminalCurrent(l:bs[0]) :
			\ SendTermOpenTerminalNew()
	endfunction

	"
	" Display the current terminal running a shell in a new split, if necessary.
	" arg bufinfo: The buffer information of the terminal, as returned by
	"   getbufinfo()
	" Returns: The job ID of the shell running inside the terminal.
	"
	function! SendTermOpenTerminalCurrent(bufinfo) abort
		" If the terminal is hidden, create a new split and show the terminal
		" within that split.
		if a:bufinfo['hidden']
			" Get current  window nr, so we can jump back later.
			let l:w = winnr()
			call SendTermOpenSplit()
			exe 'buffer' . a:bufinfo['bufnr']
			" Return to previous window.
			exe l:w . 'wincmd w'
		endif
		" Return job ID of the shell running inside the terminal.
		return a:bufinfo['variables']['terminal_job_id']
	endfunction

	"
	" Create a new split with a terminal running a shell.
	" Returns: The job ID of the shell running inside the terminal.
	"
	function! SendTermOpenTerminalNew() abort
		" Get current  window nr, so we can jump back later.
		let l:w = winnr()
		" Open new terminal in a new split inside a new buffer.
		call SendTermOpenSplit()
		enew
		let l:jid = termopen(&shell)
		" Set buffer local variable to identify this buffer later.
		exe 'let b:' . s:send_term_id_var_name . ' = 1'
		" Go to the bottom of the terminal buffer, this is necessary that the
		" terminal is scrolling correctly.
		normal G
		" Return to previous window.
		exe l:w . 'wincmd w'
		" Clear shell after startup, so we have a clean shell.
		call jobsend(l:jid, "clear\n")
		" Return job ID of shell running inside the terminal.
		return l:jid
	endfunction

	"
	" Open a split, where the position is given by s:send_term_split_pos and the
	" size by s:send_term_split_size.
	"
	function! SendTermOpenSplit() abort
		if s:send_term_split_pos ==? 'top'
			exe 'topleft ' . s:send_term_split_size . 'split'
		elseif s:send_term_split_pos ==? 'bottom'
			exe 'botright ' . s:send_term_split_size . 'split'
		elseif s:send_term_split_pos ==? 'left'
			exe 'topleft ' . s:send_term_split_size . 'vsplit'
		elseif s:send_term_split_pos ==? 'right'
			exe 'botright ' . s:send_term_split_size . 'vsplit'
		endif
	endfunction

	" Register :T as a command for SendTermCmdTerminal.
	command! -nargs=? -complete=shellcmd T call SendTermCmdTerminal(<q-args>)
	
	" Define mapping to run current file in terminal.
	nnoremap <silent> <leader>r
		\ :call SendTermCmdTerminal("clear\n" . expand('%:p'))<CR>
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use preinstalled colorscheme and adjust it to look good with gui and 256
" colors.
set background=dark
colorscheme evening
highlight ColorColumn             ctermbg=237                      guibg=#3c3836
highlight CursorLine   cterm=none ctermbg=237                      guibg=#3c3836
highlight CursorLineNr cterm=bold ctermbg=237 ctermfg=214 gui=bold guibg=#3c3836 guifg=#fabd2f
highlight LineNr       cterm=bold ctermbg=235 ctermfg=243 gui=bold guibg=#282828 guifg=#7c6f64
highlight Normal                  ctermbg=235                      guibg=#282828
highlight SignColumn              ctermbg=237                      guibg=#3c3836
highlight Visual                  ctermbg=237                      guibg=#3c3836


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! DefineSlHighlights() abort
	highlight SlModeNormal   cterm=bold ctermbg=246 ctermfg=235 gui=bold guibg=#a89984 guifg=#282828
	highlight SlModeInsert   cterm=bold ctermbg=109 ctermfg=235 gui=bold guibg=#83a598 guifg=#282828
	highlight SlModeReplace  cterm=bold ctermbg=108 ctermfg=235 gui=bold guibg=#8ec07c guifg=#282828
	highlight SlModeCommand  cterm=bold ctermbg=246 ctermfg=235 gui=bold guibg=#a89984 guifg=#282828
	highlight SlModeVisual   cterm=bold ctermbg=208 ctermfg=235 gui=bold guibg=#fe8019 guifg=#282828
	highlight SlModeSelect   cterm=bold ctermbg=142 ctermfg=235 gui=bold guibg=#b8bb26 guifg=#282828
	highlight SlModeTerminal cterm=bold ctermbg=175 ctermfg=235 gui=bold guibg=#d3869b guifg=#282828
	highlight SlModeUnknown  cterm=bold ctermbg=214 ctermfg=235 gui=bold guibg=#fabd2f guifg=#282828

	highlight SlFile         cterm=none ctermbg=239 ctermfg=248 gui=none guibg=#504945 guifg=#bdae93
	highlight SlInfo         cterm=none ctermbg=237 ctermfg=248 gui=none guibg=#3c3836 guifg=#bdae93

	highlight StatusLineNC   cterm=none ctermbg=239 ctermfg=248 gui=none guibg=#504945 guifg=#bdae93
endfunction
call DefineSlHighlights()

let s:sl_mode_conf = {
	\ 'n'  : ['SlModeNormal', 'NORMAL'],
	\ 'i'  : ['SlModeInsert', 'INSERT'],
	\ 'R'  : ['SlModeReplace', 'REPLACE'],
	\ 'c'  : ['SlModeCommand', 'COMMAND'],
	\ 'v'  : ['SlModeVisual', 'VISUAL'],
	\ 'V'  : ['SlModeVisual', 'V-LINE'],
	\ '' : ['SlModeVisual', 'V-BLOCK'],
	\ 's'  : ['SlModeSelect', 'SELECT'],
	\ 'S'  : ['SlModeSelect', 'S-LINE'],
	\ '' : ['SlModeSelect', 'S-BLOCK'],
	\ 't'  : ['SlModeTerminal', 'TERMINAL'],
	\ }
let s:sl_mode_unknown = ['SlModeUnknown', '-----']

function! SlActive() abort
	let l:mc = get(s:sl_mode_conf, mode(), s:sl_mode_unknown)
	let l:sl  = '%#' . l:mc[0] . '# ' . l:mc[1] . ' '
	let l:sl .= (&paste) ? '%#SlInfo# PASTE ' : ''
	let l:sl .= '%#SlFile# %<%f%( [%M%R%H%W]%)'
	let l:sl .= '%='
	let l:sl .= '%#SlInfo# %{(&ft!=""?&ft." ":"")}'
	let l:sl .= '%{(&fenc!=""?&fenc:&enc)}[%{&ff}] '
	let l:sl .= '%#' . l:mc[0] . '# %3p%% ☰ %4l/%L ln : %3v '
	return l:sl
endfunction

function! SlPassive() abort
	let l:sl  = ' %<%f%( [%M%R%H%W]%)'
	let l:sl .= '%='
	let l:sl .= '%{(&ft!=""?&ft." ":"")}'
	let l:sl .= '%{(&fenc!=""?&fenc:&enc)}[%{&ff}]  '
	let l:sl .= '%3p%% ☰ %4l/%L ln : %3v '
	return l:sl
endfunction

set laststatus=2
set noshowmode
set statusline=%!SlActive()

augroup statusline
	autocmd!
	autocmd ColorScheme * call DefineSlHighlights()
	autocmd WinEnter * setlocal statusline=%!SlActive()
	autocmd WinLeave * setlocal statusline=%!SlPassive()
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:plug_path=expand('~/.devenv/vim/plug-config.vim')
if filereadable(s:plug_path)
	exe 'source ' . s:plug_path
endif

