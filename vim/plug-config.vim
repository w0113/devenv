
" Neovim only.
if !has('nvim')
	finish
endif

" Only load this file if vim-plug is loaded.
runtime autoload/plug.vim
if !exists('g:loaded_plug')
	finish
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged/')
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
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'neoclide/coc-solargraph', {'do': 'yarn install --frozen-lockfile'}
Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle']}
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails', {'for': 'ruby'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-ruby/vim-ruby', {'for': 'ruby'}
Plug 'w0113/vim-textobj-rubyblock', {'for': 'ruby'}
call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Coc.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
	if &filetype == 'vim'
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Navigate diagnostics
nmap <silent> öö <Plug>(coc-diagnostic-prev)
nmap <silent> ää <Plug>(coc-diagnostic-next)
noremap <silent> <leader>d :<C-u>CocList diagnostics<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyMotion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Expand-Region
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
xmap v <Plug>(expand_region_expand)
xmap <C-v> <Plug>(expand_region_shrink)
call expand_region#custom_text_objects({'a]':1, 'ab':1, 'aB':1,})
call expand_region#custom_text_objects('ruby', {'ar':1, 'ir':1})


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gruvbox
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_contrast_light='medium'
set background=dark
colorscheme gruvbox

function! CsSwitchBackground() abort
	let &background = (&background == 'dark' ? 'light' : 'dark')
	echo "Changed colorscheme background to " . &background
endfunction

function! CsSwitchContrast() abort
	" All current contrast options.
	let l:cs = ['soft', 'medium', 'hard']
	" Get the index of the current contrast.
	let l:ci = index(l:cs, g:gruvbox_contrast_dark)
	" Get the next contrast, relativ to l:ci.
	let l:cn = l:cs[(l:ci + 1) % len(l:cs)]

	" Set the new contrast and activate it by setting the colorscheme.
	let g:gruvbox_contrast_dark = l:cn
	let g:gruvbox_contrast_light = l:cn
	colorscheme gruvbox
	echo "Changed colorscheme contrast to " . l:cn
endfunction

noremap <silent> <F5> :call CsSwitchBackground()<CR>
noremap <silent> <F6> :call CsSwitchContrast()<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indent-Guides
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indent_guides_default_mapping=0
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_exclude_filetypes=['help', 'nerdtree', 'tagbar']
nnoremap <silent> <leader><leader>i :IndentGuidesToggle<CR>

" Use the normal background color for indent-guide odd and the normal
" foreground color for indent-guide even coloring.
function! CsIndentGuides() abort
	let l:bg = join(filter(split(execute('hi Normal')),
		\ 'match(v:val, "bg=") >= 0'))
	let l:fg = join(filter(split(execute('hi Normal')),
		\ 'match(v:val, "fg=") >= 0'))
	exe 'hi IndentGuidesOdd ' . l:bg . ' ' . l:fg
	exe 'hi IndentGuidesEven ' . l:fg
endfunction

call CsIndentGuides()
augroup indentguides
	autocmd!
	autocmd ColorScheme * call CsIndentGuides()
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Limelight
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <F7> :Limelight!!<CR>
inoremap <silent> <F7> <C-o>:Limelight!!<CR>
xnoremap <silent> <F7> :Limelight!!<CR>gv


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader><leader>n :NERDTreeToggle<CR>
let g:NERDTreeChDirMode=2  " Needed for fzf to change root accordingly.


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tagbar
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_autoclose=1
nnoremap <leader><leader>t :TagbarToggle<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Undotree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader><leader>u :UndotreeToggle<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" unimpaired
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use ö and ä instead of [ and ].
let g:nremap={"[": "ö", "]": "ä"}
let g:xremap={"[": "ö", "]": "ä"}
let g:oremap={"[": "ö", "]": "ä"}

