set mouse=a
set fenc=utf-8
set nobackup
set noswapfile
set nowritebackup
set hidden
set showcmd
set showcmd
set number
set shiftwidth=4
set tabstop=4
set expandtab
set textwidth=0
set autoindent
set clipboard=unnamed
syntax on

let g:black_virtualenv = "~/venv/"
let g:python3_host_prog = "~/venv/bin/python3"
augroup black_on_save
  autocmd!
  autocmd BufWritePre *.py Black
augroup end

nnoremap <F9> :Black<CR>
" Enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" 見た目系
set t_Co=256 " iTerm2など既に256色環境なら無くても良い
syntax enable " 構文に色を付ける
" インデント
let g:indent_guides_enable_on_vim_startup = 1
" 行番号を表示
set number
" 現在の行を強調表示
" set cursorline

augroup vimrc-auto-cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
  autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
  autocmd WinEnter * call s:auto_cursorline('WinEnter')
  autocmd WinLeave * call s:auto_cursorline('WinLeave')

  let s:cursorline_lock = 0
  function! s:auto_cursorline(event)
    if a:event ==# 'WinEnter'
      setlocal cursorline
      let s:cursorline_lock = 2
    elseif a:event ==# 'WinLeave'
      setlocal nocursorline
    elseif a:event ==# 'CursorMoved'
      if s:cursorline_lock
        if 1 < s:cursorline_lock
          let s:cursorline_lock = 1
        else
          setlocal nocursorline
          let s:cursorline_lock = 0
        endif
      endif
    elseif a:event ==# 'CursorHold'
      setlocal cursorline
      let s:cursorline_lock = 1
    endif
  endfunction
augroup END


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
" set nowrap

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

" タブ切り替え
nnoremap <silent> <C-p>   :BufferPrevious<CR>
nnoremap <silent> <C-n>   :BufferNext<CR>

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
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" nnoremap <leader>n :NERDTreeFocus<CR>
" nnoremap <CBufferPrevious-n> :NERDTree<CR>
" nnoremap <silent> <Leader>e :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeShowHidden = 1

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" FZF
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" nnoremap <C-f> :Files<CR>
" nnoremap <S-f> :Ag<CR>

" タブ移動
" map <C-l> gt
" map <C-h> gT

" gitgutter
" let g:gitgutter_highlight_lines = 1

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

" COC https://qiita.com/coil_msp123/items/29de76b035dd28af77a9
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
autocmd CursorHold * silent call CocActionAsync('highlight')


call plug#begin()
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
Plug 'sheerun/vim-polyglot'
Plug 'easymotion/vim-easymotion'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mbbill/undotree'
Plug 'tpope/vim-surround'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'artanikin/vim-synthwave84'
Plug 'mtdl9/vim-log-highlighting'
Plug '4513ECHO/vim-colors-hatsunemiku'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lambdalisue/fern.vim'
Plug 'josa42/vim-lightline-coc'
Plug 'sakshamgupta05/vim-todo-highlight'
Plug 'psf/black', { 'branch': 'stable' }
call plug#end()

colorscheme tokyonight
let g:airline_theme='tokyonight'
" color setting
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" https://zenn.dev/yano/articles/vim_frontend_development_2021#nvim-treesitter-(*)
" map prefix
let g:mapleader = "\<Space>"
nnoremap <Leader> <Nop>
xnoremap <Leader> <Nop>
nnoremap [dev]    <Nop>
xnoremap [dev]    <Nop>
nmap     m        [dev]
xmap     m        [dev]
nnoremap [ff]     <Nop>
xnoremap [ff]     <Nop>
nmap     z        [ff]
xmap     z        [ff]

"" coc.nvim
let g:coc_global_extensions = ['coc-tsserver', 'coc-eslint8',  'coc-git', 'coc-fzf-preview', 'coc-lists' , 'coc-prettier', 'coc-spell-checker', 'coc-highlight', 'coc-emmet', 'coc-diagnostic', 'coc-json', 'coc-jedi', 'coc-yaml', 'coc-react-refactor']

inoremap  <expr> <C-Space> coc#refresh()
nnoremap <silent> K       :<C-u>call <SID>show_documentation()<CR>
nmap     <silent> [dev]rn <Plug>(coc-rename)
nmap     <silent> [dev]a  <Plug>(coc-codeaction-selected)iw
nmap     <silent> [dev]d  :CocDiagnostics<CR>

function! s:coc_typescript_settings() abort
  nnoremap <silent> <buffer> [dev]f :<C-u>CocCommand eslint.executeAutofix<CR>:CocCommand prettier.formatFile<CR>
endfunction

augroup coc_ts
  autocmd!
  autocmd FileType typescript,typescriptreact call <SID>coc_typescript_settings()
augroup END

function! s:show_documentation() abort
  if index(['vim','help'], &filetype) >= 0
    execute 'h ' . expand('<cword>')
  elseif coc#rpc#ready()
    call CocActionAsync('doHover')
  endif
endfunction

"" fzf-preview
let $BAT_THEME                     = 'OneHalfDark'
let $FZF_PREVIEW_PREVIEW_BAT_THEME = 'OneHalfDark'

nnoremap <silent> <C-f>  :<C-u>CocCommand fzf-preview.FromResources buffer project_mru project<CR>
nnoremap <silent> [ff]s  :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [ff]gg :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> [ff]b  :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap          [ff]f  :<C-u>CocCommand fzf-preview.ProjectGrep --add-fzf-arg=--exact --add-fzf-arg=--no-sort<Space>
xnoremap          [ff]f  "sy:CocCommand fzf-preview.ProjectGrep --add-fzf-arg=--exact --add-fzf-arg=--no-sort<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"

nnoremap <silent> [ff]q  :<C-u>CocCommand fzf-preview.CocCurrentDiagnostics<CR>
nnoremap <silent> [ff]rf :<C-u>CocCommand fzf-preview.CocReferences<CR>
nnoremap <silent> [ff]d  :<C-u>CocCommand fzf-preview.CocDefinition<CR>
nnoremap <silent> [ff]t  :<C-u>CocCommand fzf-preview.CocTypeDefinition<CR>
nnoremap <silent> [ff]o  :<C-u>CocCommand fzf-preview.CocOutline --add-fzf-arg=--exact --add-fzf-arg=--no-sort<CR>

"" fern
nnoremap <silent> <Leader>e :NERDTreeToggle<CR>
nnoremap <silent> <Leader>E :NERDTreeFind<CR>

"" react-refactor
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
"" treesitter
lua <<EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "typescript",
    "tsx",
  },
  highlight = {
    enable = true,
  },
}
EOF
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()


let g:lightline = {
  \   'colorscheme': 'ayu_mirage'
  \ }

" register compoments:
let g:lightline.component_expand = {
  \   'linter_warnings': 'lightline#coc#warnings',
  \   'linter_errors': 'lightline#coc#errors',
  \   'linter_info': 'lightline#coc#info',
  \   'linter_hints': 'lightline#coc#hints',
  \   'linter_ok': 'lightline#coc#ok',
  \   'status': 'lightline#coc#status',
  \ }

" Set color to the components:
let g:lightline.component_type = {
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_info': 'info',
  \   'linter_hints': 'hints',
  \   'linter_ok': 'left',
  \ }

" Add the components to the lightline:
let g:lightline.active = {
  \   'left': [[ 'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok' ], [ 'coc_status'  ]]
  \ }

call lightline#coc#register()

