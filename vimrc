
" vim-plug

call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdcommenter'

Plug 'Valloric/YouCompleteMe'

Plug 'scrooloose/nerdtree'
Plug 'nathanaelkane/vim-indent-guides'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'

Plug 'rhysd/vim-llvm'
Plug 'rhysd/vim-clang-format'

Plug 'morhetz/gruvbox'

Plug 'airblade/vim-gitgutter'

Plug 'webastien/vim-ctags'

call plug#end()

"" Disable beap
set noerrorbells
set vb t_vb=

"" Map Leader
let mapleader = ";"

"" cursor line's bottom padding
set scrolloff=10

"" Max width of inputs
set textwidth=0

"" Auto reload a file if other editors overwrite it
set autoread

"" Can open other file even if a file is not saved
set hidden

"" Backup and Swap file
set backup
set backupdir=~/.vim/tmp
set swapfile
set directory=~/.vim/tmp

"" Enable use Backspace to remove indent, EOL, line start
set backspace=indent,eol,start

"" Line Number
set number

"" Highlight cursor line
set cursorline

"" Highlight matched brackets
set showmatch

"" Indent and Tab Width
set autoindent
set tabstop=2
set expandtab
set shiftwidth=2
highlight TabSpace ctermbg=DarkBlue
match TabSpace /\t\|\s\+$/

" Mouse
set mouse=a
set guioptions+=a

set laststatus=2
set title
set showcmd
set ruler
set nohlsearch

augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END



 " Search for selected text, forwards or backwards.
 vnoremap <silent> * :<C-U>
       \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
       \gvy/<C-R><C-R>=substitute(
       \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
       \gV:call setreg('"', old_reg, old_regtype)<CR>
 vnoremap <silent> # :<C-U>
       \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
       \gvy?<C-R><C-R>=substitute(
       \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
       \gV:call setreg('"', old_reg, old_regtype)<CR>


"--------------------------------- Color Theme   -----------------------------

set termguicolors
set background=dark
colorscheme gruvbox
let g:enable_bold_font = 1
let g:enable_italic_font = 1
let g:airline_theme='gruvbox'

"--------------------------------- fzf.vim -----------------------------
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }

nmap <leader><leader> :Files <CR>

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

"--------------------------------- YouCompleteMe -----------------------------
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
let g:ycm_key_invoke_completion=''
let g:ycm_global_ycm_extra_conf='~/.vim/ycm_extra_conf.py'
let g:ycm_extra_conf_vim_data=[
  \ '&filetype',
  \ 'g:ycm_python_interpreter_path',
  \ 'g:ycm_python_sys_path']

let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_rust_src_path='~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
let g:ycm_show_diagnostics_ui=0
" let g:ycm_register_as_syntastic_checker=0
set completeopt-=preview

"--------------------------------- NERDCommenter -----------------------------

nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle
nmap <Leader>/ <Plug>NERDCommenterToggle
vmap <Leader>/ <Plug>NERDCommenterToggle
nmap <Leader>/a <Plug>NERDCommenterAppend
nmap <leader>/9 <Plug>NERDCommenterToEOL
vmap <Leader>/s <Plug>NERDCommenterSexy
vmap <Leader>/b <Plug>NERDCommenterMinimal


" --------------------------------- NERDTree ------------------------------


" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap  @ [Tag]

" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

map <silent> <C-T> :tablast <bar> tabnew <bar> NERDTreeMirror<CR>
map <silent> <C-X> :NERDTreeClose <bar> tabclose<CR>
map <silent> <C-N> :tabnext<CR>
map <silent> <C-P> :tabprevious<CR>

" autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
let g:NERDTreeDirArrows=0
let g:NERDTreeShowHidden=1
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>

" --------------------------------- Indent Guide --------------------------

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" --------------------------------- NERDTree ------------------------------

" llvm, google, chromium, mozilla
let g:clang_format#code_style = 'llvm'
let g:clang_format#detect_style_file = 1

" map to <Leader>cf in C++ code
" autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

" --------------------------------- CTags ---------------------------------
au BufNewFile,BufRead *.c set tags+=$HOME/c.tags
au BufNewFile,BufRead *.cc set tags+=$HOME/c.tags
au BufNewFile,BufRead *.cpp set tags+=$HOME/c.tags

nnoremap <C-]> :call DisplayTag()<CR>
let g:vim_ctags__jump_behaviors = { 'before': 'tabnew', 'after': 'norm zvzz' }

