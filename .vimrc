"colorscheme molokai
 
nmap <DOWN> <ESC>
nmap <RIGHT> <ESC>
nmap <UP> <ESC>
nmap <LEFT> <ESC>
map <DOWN> <ESC>
map <RIGHT> <ESC>
map <UP> <ESC>

set showcmd
set nocompatible
set title
set number
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

set wrapscan
set ignorecase
set smartcase

syntax on
set hlsearch

" タブ
set showtabline=2
set tabpagemax=15
" タブ切り替え
nnoremap <C-n> gt
nnoremap <C-p> gT
nnoremap ts :<C-u>split<Space>
nnoremap <expr> tS ':<C-u>split ' . GetRelativePath()
nnoremap tv :<C-u>vsplit<Space>
nnoremap <expr> tV ':<C-u>vsplit ' . GetRelativePath()

" エンコーディング
set encoding=utf-8

" 文字コードの自動認識 (see also: http://www.kawaz.jp/pukiwiki/?vim#cb691f26)
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
    " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
    " fileencodingsを構築
    if &encoding ==# 'utf-8'
      let s:fileencodings_default = &fileencodings
      let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
      let &fileencodings = &fileencodings .','. s:fileencodings_default
      unlet s:fileencodings_default
    else
      let &fileencodings = &fileencodings .','. s:enc_jis
      set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

"NERDTree
nmap <silent> <S-n> :NERDTreeToggle<CR>
nmap <silent> <F7> :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1

" grepopen
augroup grepopen
    autocmd!
    autocmd QuickfixCmdPost vimgrep cw
augroup END

" Less
au BufNewFile,BufRead *.less    setf less

" JSX
au BufNewFile,BufRead *.jsx    setf jsx
