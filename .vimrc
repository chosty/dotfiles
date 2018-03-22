"----------------------------------------------------------
" 基本設定
"----------------------------------------------------------

" エンコーディング
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
scriptencoding utf-8

" 行番号を表示
set number

" ファイルを上書きする前にバックアップを作ることを無効化
set nowritebackup

" ファイルを上書きする前にバックアップを作ることを無効化
set nobackup

" 挿入モードでバックスペースで削除できるようにする
set backspace=indent,eol,start

" モードライン
set modeline

" syntax
syntax enable
set background=dark
set termguicolors
colorscheme material-theme

" 常にステータスラインを表示
set laststatus=2

" カレント行をハイライトしない
set nocursorline

" タブ幅とインデント
set tabstop=2
set autoindent
set expandtab
set shiftwidth=2

"新しい行を作った時に高度な自動インデントを行う
set smarttab

" タブを可視化
set list
set listchars=tab:^\ ,trail:~

" 行末スペースを可視化
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
augroup vimrc
  autocmd!
  autocmd WinEnter * match WhitespaceEOL /\s\+$/
augroup END

" マルチバイト文字でずれないように
set ambiwidth=double

" 変更されたときに自動で読み直す
set autoread

" 音を出さないようにする
set belloff=all

" 括弧の対応関係, %による移動
set showmatch
source $VIMRUNTIME/macros/matchit.vim

" 補完系の設定
set completeopt=menuone

"----------------------------------------------------------
" 言語別設定
"----------------------------------------------------------

" ファイルタイプインデント
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.php setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.go setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

" PHP
let g:php_baselib       = 1
let g:php_htmlInStrings = 1
let g:php_noShortTags   = 1
let g:php_sql_query     = 1
let g:sql_type_default = 'mysql'

"----------------------------------------------------------
" マッピング設定
"----------------------------------------------------------

" 行頭、行末移動
nnoremap <Space>h  ^
nnoremap <Space>l  $

" セミコロン、コロンの置き換え
nnoremap ;  :
nnoremap :  ;
vnoremap ;  :
vnoremap :  ;

" 行移動の変更(表示行での移動)
nnoremap k   gk
nnoremap j   gj
vnoremap k   gk
vnoremap j   gj
nnoremap gk  k
nnoremap gj  j
vnoremap gk  k
vnoremap gj  j

" for accelerated-jk
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

" for vim-anzu
nmap n nzz<Plug>(anzu-update-search-status)
nmap N Nzz<Plug>(anzu-update-search-status)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)
nmap <silent> <ESC><ESC> :<C-u>nohlsearch<CR><Plug>(anzu-clear-search-status)

" 保存, 終了
nnoremap <Space>w  :<C-u>w<CR>
nnoremap <Space>q  :<C-u>q<CR>
nnoremap <Space>Q  :<C-u>q!<CR>

" tab関連
nnoremap <silent> tt  :<C-u>tabe<CR>
nnoremap <C-b>  gT
nnoremap <C-n>  gt
nnoremap <silent> tq :<C-u>tabclose<CR>

" 空行挿入
nnoremap <Space>o  :<C-u>for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>
nnoremap <Space>O  :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>

" esc置き換え
inoremap jj <Esc>

" move cursor in cmd mode
cnoremap <C-l>  <Right>
cnoremap <C-h>  <Left>
cnoremap <C-a>  <C-b>
cnoremap <C-e>  <C-e>
cnoremap <C-u> <C-e><C-u>
cnoremap <C-v> <C-f>a

" その他
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q gq

"----------------------------------------------------------
" dein set up
"----------------------------------------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let s:dein_dir = expand('~/dotfiles/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  echo "install dein.vim..."
  execute '!git clone git://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#add(s:dein_dir)
  let g:rc_dir    = expand('~/dotfiles/dein')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/lazy.toml'

  " プラグイン管理 tomlに書く
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
