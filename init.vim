set mouse=a
set fenc=utf-8
set nobackup
set noswapfile
set nowritebackup
set autoread
set hidden
set showcmd
set number
set shiftwidth=4
set tabstop=4
set expandtab
set textwidth=0
set autoindent
set clipboard=unnamed
syntax on

" 構文エラー行に「>>」を表示
let g:syntastic_enable_signs = 1
" 他のVimプラグインと競合するのを防ぐ
let g:syntastic_always_populate_loc_list = 1
" 構文エラーリストを非表示
let g:syntastic_auto_loc_list = 0
" ファイルを開いた時に構文エラーチェックを実行する
let g:syntastic_check_on_open = 1
" 「:wq」で終了する時も構文エラーチェックする
let g:syntastic_check_on_wq = 1

let g:syntastic_python_checkers = ["flake8"]
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" 見た目系
set t_Co=256 " iTerm2など既に256色環境なら無くても良い
syntax enable " 構文に色を付ける

" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
set matchtime=3
set matchpairs& matchpairs+=<:>
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
set list listchars=tab:\▸\-

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" Backspaceの影響範囲に制限を設けないようにする
set backspace=indent,eol,start

" IMEがオンの時もコマンドを入力したい
nnoremap あ a
nnoremap い i
nnoremap う u
nnoremap お o
nnoremap っd dd
nnoremap っy yy

" 削除キーでyankしない
nnoremap x "_x
nnoremap d "_d
"nnoremap d "_d
nnoremap D "_D

" jjでnomal mode
inoremap <silent> jj <ESC>

" autosave
autocmd FocusLost * silent wa
" switch pane

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" コピペの最適化
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

" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeShowHidden = 1

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" タブ移動
map <C-l> gt
map <C-h> gT

" gitgutter
let g:gitgutter_highlight_lines = 1 

augroup GitSpellCheck
    autocmd!
    autocmd FileType gitcommit setlocal spell
augroup END

let g:committia_hooks = {}
function! g:committia_hooks.edit_open(info)
    " Additional settings
    setlocal spell

    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    endif

    " Scroll the diff window from insert mode
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
endfunction

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'sheerun/vim-polyglot'
Plug 'easymotion/vim-easymotion'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sjl/vitality.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'simeji/winresizer'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'wakatime/vim-wakatime'
Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }
Plug 'rhysd/committia.vim'
Plug 'itchyny/lightline.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'bronson/vim-trailing-whitespace'
Plug 'cohama/lexima.vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'scrooloose/syntastic'
call plug#end()

let g:lightline = {
      \ 'colorscheme': 'one',
     \ }
colorscheme onehalfdark
let g:airline_theme='onehalfdark'
" color setting
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

