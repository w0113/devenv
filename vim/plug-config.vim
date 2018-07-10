
" All plugins
call plug#begin('~/.config/nvim/plugged/')
Plug 'airblade/vim-gitgutter'
"Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'godlygeek/tabular'
Plug 'gregsexton/gitv', {'on': ['Gitv']}
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/limelight.vim'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'majutsushi/tagbar', {'on': ['TagbarToggle']}
Plug 'mbbill/undotree', {'on': ['UndotreeToggle']}
Plug 'michaeljsmith/vim-indent-object'
Plug 'morhetz/gruvbox'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle']}
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails', {'for': 'ruby'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby', {'for': 'ruby'}
Plug 'w0113/vim-textobj-rubyblock'
call plug#end()

" TODO: Autoload this file on changes
"		Builtin check for not loading this file when no vim-plug is installed

" Settings for airline.
set noshowmode
set laststatus=2
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tagbar#enabled=1

" Settings for EasyMotion:
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
let g:fzf_command_prefix='Fzf'

command! -bang -nargs=? -complete=dir FzfHFiles call fzf#vim#files(<q-args>,
	\ {'source': 'find . -type d -name .git -prune -o -print'}, <bang>0)

command! -bang -nargs=* FzfHAg call fzf#vim#ag(<q-args>,
	\ '--hidden --ignore .git', <bang>0)

nnoremap ss :FzfFiles<CR>
nnoremap sw :FzfHFiles<CR>
nnoremap sg :FzfGFiles<CR>
nnoremap sb :FzfBuffers<CR>
nnoremap sa :FzfAg<CR>
nnoremap sq :FzfHAg<CR>
nnoremap sl :FzfLines<CR>
nnoremap so :FzfBLines<CR>
nnoremap sm :FzfMarks<CR>
nnoremap sh :FzfHistory:<CR>
nnoremap sc :FzfCommits<CR>
nnoremap s. :FzfCommands<CR>
nnoremap sh :FzfHelptags<CR>

" Settings for Indent-Guides:
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_exclude_filetypes=['help', 'nerdtree', 'tagbar']
let g:indent_guides_auto_colors=0
let g:indent_guides_default_mapping=0
nnoremap <silent> <leader><leader>i :IndentGuidesToggle<CR>

" Settings for LanguageClient-neovim:
"let g:LanguageClient_serverCommands = {
"    \ 'ruby': ['tcp://127.0.0.1:7658'],
"	\ }
"augroup language_client
"	autocmd!
"	autocmd FileType ruby call system('bash -c "'
"		\ . 'if which solargraph &> /dev/null '
"		\ . '    && ! pgrep solargraph &> /dev/null; then '
"		\ . '    solargraph socket &> /dev/null &disown; '
"		\ . 'fi"')
"augroup END
"set completefunc=LanguageClient#complete
"set signcolumn=yes
"nnoremap <F4> :call LanguageClient_contextMenu()<CR>
"let g:LanguageClient_loggingFile = '/tmp/LanguageClient.log'
"let g:LanguageClient_loggingLevel = 'DEBUG'

" Settings for Limelight:
nnoremap <silent> <F6> :Limelight!!<CR>
inoremap <silent> <F6> <C-o>:Limelight!!<CR>
xnoremap <silent> <F6> :Limelight!!<CR>gv

" Settings for NERDTree:
nnoremap <leader><leader>n :NERDTreeToggle<CR>
let g:NERDTreeChDirMode=2  " Needed for fzf to change root accordingly.

" Settings for Tagbar:
let g:tagbar_autoclose=1
nnoremap <leader><leader>t :TagbarToggle<CR>

" Settings for Undotree:
nnoremap <leader><leader>u :UndotreeToggle<CR>

" Settings for unimpaired:
" Use ö and ä instead of [ and ].
let g:nremap={"[": "ö", "]": "ä"}
let g:xremap={"[": "ö", "]": "ä"}
let g:oremap={"[": "ö", "]": "ä"}

" Settings for vimux:
"nnoremap <leader>r :call VimuxRunCommand("clear; ./" . bufname("%"))<CR>
"nnoremap <leader>rz :call VimuxRunCommand("clear; ./" . bufname("%"))<CR>:call VimuxZoomRunner()<CR>
"nnoremap <leader>rc :call VimuxPromptCommand()<CR>
"nnoremap <leader>rcz :call VimuxPromptCommand()<CR>:call VimuxZoomRunner()<CR>
"nnoremap <leader>rl :call VimuxRunLastCommand()<CR>
"nnoremap <leader>rlz :call VimuxRunLastCommand()<CR>:call VimuxZoomRunner()<CR>
"nnoremap <leader>rr :call VimuxRunCommand("clear; find '" . getcwd() . "' -maxdepth 1 -type f -executable -exec '{}' \\\\;")<CR>
"nnoremap <leader>rrz :call VimuxRunCommand("clear; find '" . getcwd() . "' -maxdepth 1 -type f -executable -exec '{}' \\\\;")<CR>:call VimuxZoomRunner()<CR>
"nnoremap <leader>rq :call VimuxCloseRunner()<CR>

