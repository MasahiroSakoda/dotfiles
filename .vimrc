""""""""""""""""""""""""""""""""""""""""""""""""""""""
" display/view setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4
set shiftwidth=4
set laststatus=2
" set scrolloff=5
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

inoremap <silent> jj <ESC>

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
nnoremap <ESC><ESC> :nohlsearch<CR>

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

"Python3 support
" let g:python3_host_prog = expand('$HOME') . '/.pyenv/shims/python'

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" dein.vim settings
" Link: http://qiita.com/delphinus/items/00ff2c0ba972c6e41542#%E3%83%97%E3%83%A9%E3%82%B0%E3%82%A4%E3%83%B3%E3%81%AE%E3%83%AA%E3%82%B9%E3%83%88%E3%82%92%E6%9B%B8%E3%81%8F
""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let s:dein_dir = expand('~/.cache/dein')
"let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
"
"if &runtimepath !~@ '/dein.vim'
"  if !isdirectory(s:dein_repo_dir)
"    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
"  endif
"  execute 'set runtimepath^='. fnamemodify(s:dein_repo_dir, ':p')
"endif
"
"if dein#load_state(s:dein_dir)
"  call dein#begin
"
"  let g:rc_dir    = expand('~/.vim/rc')
"  let s:toml      = g:rc_dir . '/dein.toml'
"  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
"
"  call dein#load_toml(s:toml,      {'lazy': 0})
"  call dein#load_toml(s:toml_lazy, {'lazy': 1})
"
"  call dein#end()
"  call dein#save_state()
"endif
"
"if dein#check_install()
"  call dein#install()
"endif

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
NeoBundleLazy 'lambdalisue/vim-pyenv', {
        \ 'depends': ['davidhalter/jedi-vim'],
        \ 'autoload': {
        \   'filetypes': ['python', 'python3'],
        \ }}

" Jedi for python
NeoBundleLazy "davidhalter/jedi-vim", {
    \ "autoload": { "filetypes": [ "python", "python3", "djangohtml"] }}

if ! empty(neobundle#get("jedi-vim"))
  let g:jedi#auto_initialization = 1
  let g:jedi#auto_vim_configuration = 1

  nnoremap [jedi] <Nop>
  xnoremap [jedi] <Nop>
  nmap <Leader>j [jedi]
  xmap <Leader>j [jedi]

  let g:jedi#completions_command = "<C-Space>"    " 補完キーの設定この場合はCtrl+Space
  let g:jedi#goto_assignments_command = "<C-g>"   " 変数の宣言場所へジャンプ（Ctrl + g)
  let g:jedi#goto_definitions_command = "<C-d>"   " クラス、関数定義にジャンプ（Gtrl + d）
  let g:jedi#documentation_command = "<C-k>"      " Pydocを表示（Ctrl + k）
  let g:jedi#rename_command = "[jedi]r"
  let g:jedi#usages_command = "[jedi]n"
  let g:jedi#popup_select_first = 0
  let g:jedi#popup_on_dot = 0

  autocmd FileType python setlocal completeopt-=preview

  " for w/ neocomplete
    if ! empty(neobundle#get("neocomplete.vim"))
        autocmd FileType python setlocal omnifunc=jedi#completions
        let g:jedi#completions_enabled = 0
        let g:jedi#auto_vim_configuration = 0
        let g:neocomplete#force_omni_input_patterns.python =
                        \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
    endif
endif

if has('lua')
  NeoBundleLazy 'Shougo/neocomplete.vim', {
    \ 'depends' : 'Shougo/vimproc',
    \ 'autoload' : {'insert': 1,}
  \ }
endif

" Environment
NeoBundle 'Shougo/unite.vim'

nnoremap [unite] <Nap>
nmap <Leader>f [unite]

" unite.vim keymap
nnoremap [unite]u  :<C-u>Unite -no-split<Space>
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]r :<C-u>UniteWithBufferDir file<CR>
nnoremap <silent> ,vr :UniteResume<CR>

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

" NeoBundle 'kakkyz81/evervim'
" let g:evervim_devtoken='S=s34:U=39b3dc:E=15b383a8ada:C=153e0895d20:P=1cd:A=en-devtoken:V=2:H=b5adfd2e4d9e034cb17aecbf2de3c530'

"""""""""""""""""""""""""
" Programming Language
"""""""""""""""""""""""""
" Swift
NeoBundle 'keith/swift.vim'

" HTML5/CSS3
NeoBundle 'othree/html5.vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'tpope/vim-haml'

" Ruby
NeoBundleLazy 'vim-ruby/vim-ruby', {
  \ 'autoload' : {'filetypes' : ['ruby', 'eruby']}}

" Ruby on Rails
NeoBundle 'tpope/vim-rails'

NeoBundleCheck

call neobundle#end()

filetype plugin indent on
syntax on

colorscheme jellybeans

" comp setting
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_min_syntax_length = 1
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w'

