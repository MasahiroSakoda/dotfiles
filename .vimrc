""""""""""""""""""""""""""""""""""""""""""""""""""""""
" display/view setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4
set shiftwidth=4
set laststatus=2
set ruler
set cursorline
set wildmenu
set nocompatible
set showmode
set notitle
set showcmd
set showmatch
set number

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" edit setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""
set list
set listchars=tab:>\ ,extends:<
set backspace=indent,eol,start
set autoindent
highlight ZenkakuSpace cterm=reverse ctermfg=white guibg=darkgray
match ZenkakuSpace /　/
syntax on
filetype off

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" encode setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""
set enc=utf-8
set fenc=utf-8
" set enc=sjis
" set fenc=sjis

" search setting
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" file type settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType c,cpp,java,sh,command,perl,rb,php,html,js,erl set cindent
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab
autocmd FileType php :set dict=dic/PHP.dict
autocmd BufNewFile,BufRead *.scpt,*applescript :setl filetype=applesctipt
autocmd BufNewFile,BufRead .vimperatorrc set filetype=vimperator

au InsertEnter * hi StatusLine guifg=DarkBlue guibg=DarkYellow gui=none ctermfg=Blue ctermbg=Yellow cterm=none
au InsertLeave * hi StatusLine guifg=DarkBlue guibg=DarkGray gui=none ctermfg=Blue ctermbg=DarkGray cterm=none

" 行末の空白文字を可視化
highlight WhitespaceEOL cterm=underline ctermbg=red guibg=#FF0000
au BufWinEnter * let w:m1 = matchadd("WhitespaceEOL", ' +$')
au WinEnter * let w:m1 = matchadd("WhitespaceEOL", ' +$')

" 行頭のTAB文字を可視化
highlight TabString ctermbg=red guibg=red
au BufWinEnter * let w:m2 = matchadd("TabString", '^\t+')
au WinEnter * let w:m2 = matchadd("TabString", '^\t+')

" 改行を可視化
" highlight EndOfLine cterm=underline guifg=Red

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermbg=red guibg=#666666
au BufWinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
au WinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neobundle settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('vim_starting')
  set nocompatible
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'

NeoBundleFetch 'Shougo/neobundle.vim'

"""""""""""""""""""""""""
" Color
"""""""""""""""""""""""""
NeoBundle 'nanotech/jellybeans.vim'

"""""""""""""""""""""""""
" Shell
"""""""""""""""""""""""""
NeoBundle 'Shougo/vimshell'

"""""""""""""""""""""""""
" Async Process
"""""""""""""""""""""""""
NeoBundle 'Shougo/vimproc', {
  \ 'build': {
  \ 'windows': 'make -f make_mingw32.mak',
  \ 'cygwin' : 'make -f make_cygwin.mak',
  \ 'mac'    : 'make -f make_mac.mak',
  \ 'unix'   : 'make -f make_unix.mak',
  \ },
\ }

"""""""""""""""""""""""""
" Completion
"""""""""""""""""""""""""
if has('lua')
  NeoBundleLazy 'Shougo/neocomplete.vim', {
    \ 'depends' : 'Shougo/vimproc',
    \ 'autoload' : {'insert': 1,}
  \ }
endif

" neocomplete {{{
let g:neocomplete#enable_at_startup               = 1
let g:neocomplete#auto_completion_start_length    = 3
let g:neocomplete#enable_ignore_case              = 1
let g:neocomplete#enable_smart_case               = 1
let g:neocomplete#enable_camel_case               = 1
let g:neocomplete#use_vimproc                     = 1
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
let g:neocomplete#sources#tags#cache_limit_size   = 30000000
let g:neocomplete#enable_fuzzy_completion         = 1
let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'
" }}}

NeoBundle 'Townk/vim-autoclose'
NeoBundleLazy 'tpope/vim-endwise', {
  \ 'autoload' : { 'insert' : 1,}}

NeoBundle 'AndrewRadev/switch.vim'
" switch {{{
nmap + :Switch<CR>
nmap - :Switch<CR>
" }}}

" Vimperator
NeoBundle 'superbrothers/vim-vimperator'

"""""""""""""""""""""""""
" Programming Language
"""""""""""""""""""""""""
" Ruby on Rails
NeoBundle 'tpope/vim-rails'

" Ruby
NeoBundleLazy 'vim-ruby/vim-ruby', {
  \ 'autoload' : {'filetypes' : ['ruby', 'eruby']}}

" HTML5/CSS3
NeoBundle 'othree/html5.vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'tpope/vim-haml'

" JavaScript
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'moll/vim-node'

NeoBundleCheck

call neobundle#end()

filetype plugin indent on
syntax on

" colorscheme jellybeans

" comp setting
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_min_syntax_length = 1
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w'

