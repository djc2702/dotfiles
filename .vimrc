
scriptencoding utf-8
set encoding=utf-8

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', {'dir' : '~/.fzf', 'do' : './install --all'} 
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-sleuth'
Plug 'sheerun/vim-polyglot'
"Plug 'w0rp/ale'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-repeat'
Plug 'mbbill/undotree'
Plug 'roman/golden-ratio'
Plug 'mileszs/ack.vim'


call plug#end()

"colo solo_dark
syntax on

""""Keybindings
" disable recording with q
map q <Nop> 
nnoremap <F5> :UndotreeToggle<cr>
" swap 0 and ^, ie make 0 go to first non-whitespace char on line
nnoremap 0 ^
nnoremap ^ 0
" following four commands are for easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" oo makes a newline w/o entering input mode, OO newline above
nmap oo o<Esc>k
nmap OO O<Esc>

" make j and k go to next screen row, instead of next 'physical' line
noremap j gj
noremap k gk

" jj exits input mode  
inoremap jj <Esc>

""" `Set` values

set ignorecase
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set smarttab
set expandtab
set softtabstop=0
set splitright
set splitbelow
"
" change command entry timeout length
set timeoutlen=300

" ignore .o files when searching with vimgrep
set wildignore+=*.o


if has ('persistent_undo')
  set undodir=~/.undodir/
  set undofile
endif

" set line numbers on
set number
set laststatus=2
set background=dark

" replace ack with ag
let g:ackprg = 'ag --nogroup --nocolor --column'

"" open vimgrep results in quickfix window
augroup myvimrc
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END


" Lightline
let g:lightline = {
\ 'colorscheme': 'solarized',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error'
\ }
\ }

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

autocmd User ALELint call s:MaybeUpdateLightline()

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

" End section



" GitGutter styling to use · instead of +/-
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'



" setting ALEfix for python
let g:ale_fixers = {'python': ['autopep8', 'yapf', 'isort']} 


colorscheme solarized8_dark

" set a nicer cursor in insert mode (from terryma on github)
" " Tmux will only forward escape sequences to the terminal if surrounded by
" " a DCS sequence
" if exists('$TMUX')
"     let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"         let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"         else
"             let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"                 let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"                 endif
"
"
" gvim options to disable tool/menu bars
if has ('gui_running')
	"set guioptions='-m'
	"set guioptions='-T'
	"set guioptions='-r'
	"set guioptions='-R'
	"set guioptions='-L'
	"set guioptions='-l'
	set guioptions='+a'
	set guioptions='+e'
	set noshowmode
endif


