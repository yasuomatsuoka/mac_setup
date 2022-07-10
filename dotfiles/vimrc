"------------------------------------
"" 基本
"------------------------------------
" 基本
set enc=utf-8
set fenc=utf-8
set fencs=utf-8,euc-jp,iso-2022-jp
set backspace=indent,eol,start
set vb t_vb=
set autoindent
set nobackup
set noundofile
set statusline=%F%M%R%=code:%B%H%W
set autoread " ファイルに変更があった場合に再読み込みされる。頻度はひくい
set wildmenu " ファイル名補完
set whichwrap=b,s,h,l,<,>,[,] " 行末から行頭に移動できるように


"------------------------------------
"" kyemapping
"------------------------------------
" emacs風keymapping
inoremap <C-d> <Delete>
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" ハイライトを消すkeymapping
noremap <ESC><ESC> :nohlsearch<CR><ESC>


"------------------------------------
"" タブ
"------------------------------------
" anywhere SID
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" タブ表示をどうするか
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " 最初の見た目
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
set showtabline=2 " show tabline everytime

" タブのkeymapping
" the prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" tab jump  t1 is jump to tab1, t2 is jump to tab2 , ...
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" tc create tab most right tab
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tx close tab
map <silent> [Tag]x :tabclose<CR>
" tn next tab
map <silent> [Tag]n :tabnext<CR>
" tp previous tab
map <silent> [Tag]p :tabprevious<CR>


"------------------------------------
"" 見た目
"------------------------------------
" 基本
syntax on
colorscheme desert
set wrap " 行末で折り返す
set showmatch " 対応するかっこを光らせる

" フォーカスがあたっているウィンドウにのカーソル行にアンダーラインを引く
augroup cch
	  autocmd! cch
	    autocmd WinLeave * set nocursorline
	      autocmd WinEnter,BufRead * set cursorline
      augroup END
      hi clear CursorLine
      hi CursorLine cterm=underline gui=underline

" 見えない文字を見えるように
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
highlight ZenkakuSpace ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/


"------------------------------------
"" 検索
"------------------------------------
set noignorecase " ignore case-sensitivity
set smartcase " if BOL is a capital letter, enable case-sensitivity
set hlsearch


"------------------------------------
"" NeoBundle
"------------------------------------
" https://github.com/Shougo/neobundle.vim
if !1 | finish | endif

if has('vim_starting')
  set nocompatible " be iMproved
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim' " Unite file_mru

call neobundle#end()
filetype indent on


"------------------------------------
"" unite
"------------------------------------
" http://www.karakaram.com/unite
" 一般設定
" インサートモードで開始
let g:unite_enable_start_insert = 1

" 最近開いたファイル履歴の保存数
let g:unite_source_file_mru_limit = 50

" file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" uniteのkeymapping
nnoremap [unite] <Nop>
nmap f [unite]

" 現在開いているファイルのディレクトリ下のファイル一覧
" 開いていない場合はカレントディレクトリ
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>

" バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>

" レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>

" 最近使用したファイル一覧
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>

" ブックマーク一覧
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>

" ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>

" uniteを開いている間のkeymapping
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings() "{{{
    " ESCでuniteを終了
    nmap <buffer> <ESC> <Plug>(unite_exit)
    " 入力モードのときjjでノーマルモードに移動
    imap <buffer> jj <Plug>(unite_insert_leave)
    " 入力モードのときctrl+wでpath単位で削除
    imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
    " ctrl+jで縦に分割して開く
    nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    " ctrl+jで横に分割して開く
    nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
    inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
    " ctrl+oでその場所に開く
    nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
    inoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
endfunction "}}}


"------------------------------------
"" ローカルの設定
"------------------------------------
" mac
if filereadable(expand('~/.vimrc.mac'))
  source ~/.vimrc.mac
endif

" local
if filereadable(expand('~/.vimrc.mine'))
  source ~/.vimrc.mine
endif
