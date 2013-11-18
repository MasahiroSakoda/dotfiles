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
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'VimClojure'
NeoBundle 'Shougo/vimshell'

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'

NeoBundle 'mattn/zencoding-vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'taichouchou2/html5.vim'
NeoBundle 'taichouchou2/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'msanders/cocoa.vim'

NeoBundle 'Townk/vim-autoclose'
NeoBundle 'tpope/vim-rails'
NeoBundle 'scrooloose/syntastic'

filetype plugin indent on
filetype indent on
syntax on

" comp setting
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_min_syntax_length = 1
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w'

