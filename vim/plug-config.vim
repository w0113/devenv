
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
Plug 'aserebryakov/vim-todo-lists'
Plug 'easymotion/vim-easymotion'
Plug 'gcmt/taboo.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-textobj-user'
Plug 'leafgarland/typescript-vim'
Plug 'majutsushi/tagbar', {'on': ['TagbarToggle']}
Plug 'mbbill/undotree', {'on': ['UndotreeToggle']}
Plug 'michaeljsmith/vim-indent-object'
Plug 'morhetz/gruvbox'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree', {'on': ['NERDTreeToggle']}
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails', {'for': 'ruby'}
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby', {'for': 'ruby'}
call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Common mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:jump_next()
	if &diff
		normal ]c
	else
		exec "normal \<Plug>(coc-diagnostic-next)"
	endif
	normal zz
endfunction

function! s:jump_prev()
	if &diff
		normal [c
	else
		exec "normal \<Plug>(coc-diagnostic-prev)"
	endif
	normal zz
endfunction

" We use öö or ää to jump to the next/previous diagnostic message or changed
" text, depending on the context
nnoremap <silent> öö :call <SID>jump_prev()<CR>
nnoremap <silent> ää :call <SID>jump_next()<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Coc.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

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
"noremap <silent> <leader>d :<C-u>CocList diagnostics<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Formatting selected code.
xmap <leader>0  <Plug>(coc-format-selected)
nmap <leader>0  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Redefine <ESC><ESC> to also remove floating windows
nnoremap <silent> <ESC><ESC> :nohlsearch \| match none \| 2match none \| call coc#float#close_all()<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" easy-align
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


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
" fugitive & git bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show history of selected lines
vnoremap <silent> <leader>gl :<C-U>exe '!git log -L' line("'<").','.line("'>").':'.expand('%')<CR>
" Open diffs from the fugitive index with dt in a new tab
autocmd User FugitiveIndex nmap <buffer> dt :Gtabedit <Plug><cfile><Bar>Gvdiffsplit!<CR>
" Pull in changes from left side
nnoremap <silent> <leader>df :diffget //2<CR>
" Pull in changes from right side
nnoremap <silent> <leader>dj :diffget //3<CR>
" Update diff
nnoremap <silent> <leader>du :diffupdate<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fzf_command_prefix='Fzf'

command! -bang -nargs=? -complete=dir FzfHFiles call fzf#vim#files(<q-args>,
	\ {'source': 'find . -type d -name .git -prune -o -print'}, <bang>0)

command! -bang -nargs=* FzfHAg call fzf#vim#ag(<q-args>,
	\ '--hidden --ignore .git', <bang>0)

command! -bang -nargs=* FzfAgLimit call fzf#vim#ag('',
	\ '--ignore .git --ignore "test/"',
	\ {'options': '--delimiter : --nth 4..'}, <bang>0)

nnoremap ss :FzfFiles<CR>
nnoremap sw :FzfHFiles<CR>
nnoremap sg :FzfGFiles<CR>
nnoremap sb :FzfBuffers<CR>
nnoremap sa :FzfAgLimit<CR>
nnoremap sA :FzfAg<CR>
nnoremap sq :FzfHAg<CR>
nnoremap sl :FzfLines<CR>
nnoremap so :FzfBLines<CR>
nnoremap sm :FzfMarks<CR>
nnoremap sH :FzfHistory:<CR>
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
let g:indent_guides_exclude_filetypes=['fzf', 'help', 'nerdtree', 'tagbar']
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
" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader><leader>n :NERDTreeToggle<CR>
"let g:NERDTreeChDirMode=2  " Needed for fzf to change root accordingly.
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeDirArrows = 1
let NERDTreeMinimalUI = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tagbar
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_autoclose=1
nnoremap <leader><leader>t :TagbarToggle<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Undotree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader><leader>u :UndotreeToggle<CR>

