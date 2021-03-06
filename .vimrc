"https://qiita.com/ahiruman5/items/4f3c845500c172a02935"
"https://thinca.hatenablog.com/entry/20090530/1243615055"

set cursorline
set nobackup
set noswapfile
set autoread
set hidden
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set autoindent
set shiftwidth=4
set hlsearch
set ignorecase
set smartcase
set wildmode=list:longest
set wildmenu
set history=5000
set number
set clipboard=unnamedplus
set backspace=indent,eol,start

"comand
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <C-a> ggVG
nnoremap <C-g> :
nnoremap <C-s> :wq!<CR>
"nnoremap <C-q> :q!<CR>
"nnoremap <C-s> :w<CR>
"inoremap <C-s> :<ESC>w<CR>
inoremap <C-s> :<ESC>wq!<CR>
"nnoremap <C-w> :wq!<CR>
"inoremap <C-q> <ESC>:q!<CR>
inoremap <C-w> <ESC>:wq!<CR>

"latex compile
"nnoremap <C-s> :!latexmk<CR>

"move on nomal mode
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

"move on insert mode
inoremap <C-n> _
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-h> <left>
inoremap <C-l> <right>

augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

if has('vim_starting')
    " 初回起動時のみruntimepathにNeoBundleのパスを指定する
    set runtimepath+=~/.vim/bundle/neobundle.vim/

    " NeoBundleが未インストールであればgit cloneする・・・・・・①
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install NeoBundle..."
        :call system("git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" インストールするVimプラグインを以下に記述
" NeoBundle自身を管理
NeoBundleFetch 'Shougo/neobundle.vim'
"----------------------------------------------------------
" ここに追加したいVimプラグインを記述する・・・・・・②

NeoBundle 'tomasr/molokai'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'cohama/lexima.vim', {'rev': 'aef88ca'}
NeoBundle 'thinca/vim-quickrun'


if has('lua') " lua機能が有効になっている場合・・・・・・①
    " コードの自動補完
    NeoBundle 'Shougo/neocomplete.vim'
    " スニペットの補完機能
    NeoBundle "Shougo/neosnippet"
    " スニペット集
    NeoBundle 'Shougo/neosnippet-snippets'
endif


"----------------------------------------------------------
call neobundle#end()

if neobundle#is_installed('molokai') " molokaiがインストールされていれば
    colorscheme molokai " カラースキームにmolokaiを設定する
endif

set t_Co=256 " iTerm2など既に256色環境なら無くても良い
syntax enable " 構文に色を付ける


set laststatus=2 " ステータスラインを常に表示
set showmode " 現在のモードを表示
set showcmd " 打ったコマンドをステータスラインの下に表示
set ruler " ステータスラインの右側にカーソルの現在位置を表示する

if neobundle#is_installed('neocomplete.vim')
    " Vim起動時にneocompleteを有効にする
    let g:neocomplete#enable_at_startup = 1
    " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplete#enable_smart_case = 1
    " 3文字以上の単語に対して補完を有効にする
    let g:neocomplete#min_keyword_length = 3
    " 区切り文字まで補完する
    let g:neocomplete#enable_auto_delimiter = 1
    " 1文字目の入力から補完のポップアップを表示
    let g:neocomplete#auto_completion_start_length = 1
    " バックスペースで補完のポップアップを閉じる
    inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

    " エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定・・・・・・②
    imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
    " タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ・・・・・・③
    imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
endif



" 未インストールのVimプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定・・・・・・③
NeoBundleCheck

if has('lua')
endif


" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1

"ctagsファイル検索
set tags=tags;

highlight MatchParen cterm=NONE ctermfg=white ctermbg=black

if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif
