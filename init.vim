set termguicolors
set cmdheight=0
set mouse=a
set fenc=utf-8
set nobackup
set noswapfile
set nowritebackup
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
xnoremap p pgvy

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
set signcolumn=yes
" インデント
let g:indent_guides_enable_on_vim_startup = 1
" 行番号を表示
set number

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
" set hlsearch
" ESC連打でハイライト解除
" nmap <Esc><Esc> :nohlsearch<CR><Esc>
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

" These commands will navigate through buffers in order regardless of which mode you are using
" e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
nnoremap <silent> <C-n> :BufferLineCycleNext<CR>
nnoremap <silent> <C-p> :BufferLineCyclePrev<CR>

" These commands will move the current buffer backwards or forwards in the bufferline
nnoremap <silent><C-s> :BufferLineMoveNext<CR>
nnoremap <silent><C-a> :BufferLineMovePrev<CR>

" These commands will sort buffers by directory, language, or a custom criteria
nnoremap <silent>be :BufferLineSortByExtension<CR>
nnoremap <silent>bd :BufferLineSortByDirectory<CR>
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

" Start NERDTree when Vim is started without file arguments.
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NvimTreeOpen | endif

" FZF
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" [Commands] --expect expression for directly executing the command

" nnoremap <C-f> :Files<CR>

" タブ移動
" map <C-l> gt
" map <C-h> gT

nnoremap J :m .+1<CR>==
nnoremap K :m .-2<CR>==
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

highlight SignColumn ctermbg=brown

" GHQ fzf
command! -nargs=0 Fq call fzf#run({
\ 'source': 'ghq list --full-path',
\ 'sink': 'cd'
\ })

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
nnoremap <silent> H :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
autocmd CursorHold * silent call CocActionAsync('highlight')

autocmd VimEnter * call s:setup_bufferline()
function! s:setup_bufferline() abort
lua<<EOF
require('bufferline').setup{
  options={
    separator_style = "slant",
    diagnostics = "coc",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
    local s = " "
    for e, n in pairs(diagnostics_dict) do
      local sym = e == "error" and " "
      or (e == "warning" and " " or "" )
      s = s .. n .. sym
    end
    return s
    end
  }}
EOF
endfunction


call plug#begin()
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
Plug 'tpope/vim-fugitive'
Plug 'wakatime/vim-wakatime'
Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }
Plug 'rhysd/committia.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'bronson/vim-trailing-whitespace'
Plug 'cohama/lexima.vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'tmhedberg/SimpylFold'
Plug 'SirVer/ultisnips'
Plug 'vim-scripts/indentpython.vim'
Plug 'honza/vim-snippets'
Plug 'mbbill/undotree'
Plug 'tpope/vim-surround'
Plug 'artanikin/vim-synthwave84'
Plug 'mtdl9/vim-log-highlighting'
Plug '4513ECHO/vim-colors-hatsunemiku'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
Plug 'ryanoasis/vim-devicons'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'lambdalisue/fern.vim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'josa42/vim-lightline-coc'
Plug 'folke/todo-comments.nvim'
Plug 'psf/black'
Plug 'jmcantrell/vim-virtualenv'
Plug 'luochen1990/rainbow'
Plug 'osyo-manga/vim-anzu'
Plug 'tpope/vim-endwise'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'rcarriga/nvim-notify'
Plug 'nvim-lua/plenary.nvim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'stevearc/dressing.nvim'
Plug 'toppair/reach.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'RRethy/vim-illuminate'
Plug 'numToStr/Comment.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'nvim-neotest/neotest'
Plug 'nvim-neotest/neotest-python'
Plug 'nvim-neotest/neotest-plenary'
Plug 'nvim-neotest/neotest-vim-test'
Plug 'vim-test/vim-test'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'
Plug 'lewis6991/gitsigns.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'kdheepak/lazygit.nvim'
Plug 'preservim/tagbar'
Plug 'Pocco81/AutoSave.nvim'
Plug 'shaunsingh/moonlight.nvim'
Plug 'navarasu/onedark.nvim'
Plug 'olimorris/onedarkpro.nvim'
Plug 'rose-pine/neovim'
Plug 'nxvu699134/vn-night.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'junegunn/goyo.vim'
Plug 'phaazon/hop.nvim'
if has('nvim')
  function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction

  Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
else
  Plug 'gelguy/wilder.nvim'
endif
Plug 'romgrk/fzy-lua-native'
Plug 'nvim-telescope/telescope.nvim'
Plug 'tpope/vim-repeat'
Plug 'mbbill/undotree'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
Plug 'rebelot/kanagawa.nvim'
Plug 'weilbith/nvim-code-action-menu'
" Plug 'vimpostor/vim-tpipeline'
Plug 'nvim-lua/popup.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'wthollingsworth/pomodoro.nvim'
Plug 'mkropat/vim-tt'
Plug 'ziontee113/icon-picker.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }
Plug 'tmux-plugins/vim-tmux'
Plug 'github/copilot.vim'
Plug 'folke/lsp-colors.nvim'
Plug 'ghillb/cybu.nvim'
Plug 'vim-jp/vimdoc-ja'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'petertriho/nvim-scrollbar'
Plug 'mrjones2014/legendary.nvim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'jsborjesson/vim-uppercase-sql'
Plug 'nixprime/cpsm'
Plug 'lambdalisue/fern.vim'
Plug 'glepnir/dashboard-nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'marko-cerovac/material.nvim'
call plug#end()

lua require'colorizer'.setup()
let g:indent_guides_exclude_filetypes = ["dashboard"]
let g:extra_whitespace_ignored_filetypes = ['unite', 'mkd', "dashboard"]

lua << EOF
require("nvim-tree").setup({
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = { custom = { "^.git$" } }
})
EOF

let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
" lspcolor
lua << EOF
require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})
EOF

lua << EOF
require("cybu").setup()
vim.keymap.set("n", "[b", "<Plug>(CybuPrev)")
vim.keymap.set("n", "]b", "<Plug>(CybuNext)")
vim.keymap.set("n", "<c-s-tab>", "<plug>(CybuLastusedPrev)")
vim.keymap.set("n", "<c-tab>", "<plug>(CybuLastusedNext)")
EOF

nmap <silent> <C-_> <Plug>(pydocstring)
let g:Illuminate_ftblacklist = ['nerdtree', 'NvimTree']
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord ctermbg=4 guibg=#33467c
augroup END
" phaazon/hop.nvim
lua require("hop").setup{}

lua require("icon-picker")

lua << EOF
require("scrollbar").setup()
EOF

lua << EOF
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '┃', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '┃', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 500,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end

}
EOF

" folke/todo-comments
lua << EOF
  require("todo-comments").setup{}
EOF


" gelguy/wilder.nvim
lua << EOF
local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})

wilder.set_option('pipeline', {
  wilder.branch(
    wilder.python_file_finder_pipeline({
      file_command = function(ctx, arg)
        if string.find(arg, '.') ~= nil then
          return {'fd', '-tf', '-H'}
        else
          return {'fd', '-tf'}
        end
      end,
      dir_command = {'fd', '-td'},
      filters = {'cpsm_filter'},
    }),
    wilder.substitute_pipeline({
      pipeline = wilder.python_search_pipeline({
        skip_cmdtype_check = 1,
        pattern = wilder.python_fuzzy_pattern({
          start_at_boundary = 0,
        }),
      }),
    }),
    wilder.cmdline_pipeline({
      fuzzy = 2,
      fuzzy_filter = wilder.lua_fzy_filter(),
    }),
    {
      wilder.check(function(ctx, x) return x == '' end),
      wilder.history(),
    },
    wilder.python_search_pipeline({
      pattern = wilder.python_fuzzy_pattern({
        start_at_boundary = 0,
      }),
    })
  ),
})

local highlighters = {
  wilder.pcre2_highlighter(),
  wilder.lua_fzy_highlighter(),
}

local popupmenu_renderer = wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    border = 'rounded',
    empty_message = wilder.popupmenu_empty_message_with_spinner(),
    highlighter = highlighters,
    highlights = {
      accent = wilder.make_hl('WilderAccent', 'Pmenu', {{a = 1}, {a = 1}, {foreground = '#f4468f'}}),
    },
    left = {
      ' ',
      wilder.popupmenu_devicons(),
      wilder.popupmenu_buffer_flags({
        flags = ' a + ',
        icons = {['+'] = '', a = '', h = ''},
      }),
    },
    right = {
      ' ',
      wilder.popupmenu_scrollbar(),
    },
  })
)

local wildmenu_renderer = wilder.wildmenu_renderer({
  highlighter = highlighters,
  separator = ' · ',
  left = {' ', wilder.wildmenu_spinner(), ' '},
  right = {' ', wilder.wildmenu_index()},
})

wilder.set_option('renderer', wilder.renderer_mux({
  [':'] = popupmenu_renderer,
  ['/'] = wildmenu_renderer,
  substitute = wildmenu_renderer,
}))
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  }
}
EOF
lua <<EOF
require("neotest").setup({
  adapters = {
    require("neotest-python")
  }
})
EOF
nmap <Leader>tr :lua require("neotest").run.run()<CR>
nmap <Leader>to :lua require("neotest").summary.open()<CR>
nmap <Leader>tc :lua require("neotest").run.run(vim.fn.expand("%"))<CR>

lua << EOF
local autosave = require("autosave")
autosave.setup(
  {
      enabled = true,
      execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
      events = {"InsertLeave", "TextChanged"},
      conditions = {
          exists = true,
          filename_is_not = {},
          filetype_is_not = {},
          modifiable = true
      },
      write_all_buffers = false,
      on_off_commands = true,
      clean_command_line_interval = 0,
      debounce_delay = 1000
  }
)
EOF

" anzu
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
" clear status
nmap <silent> <Esc><Esc> <Plug>(anzu-clear-search-status) :set nohlsearch<CR><ESC>
" :nohlsearch<CR><ESC>

let g:rainbow_active = 1
let g:rainbow_conf = {
  \	'separately': {
  \		'nerdtree': 0,
  \	}
  \}
let g:onedark_config = {
    \ 'style': 'deep',
\}

let g:tokyonight_style = "night"
colorscheme tokyonight
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
nmap <Leader>t :TagbarToggle<CR>

nmap [dev]tr :lua require("neotest").run.run()<CR>
nmap [dev]tc :lua require("neotest").run.run(vim.fn.expand("%"))<CR>
nmap [dev]to :lua require("neotest").summary.open()<CR>

set termguicolors

" undo
nnoremap <Leader>u :UndotreeToggle<cr>

" coc.nvim
let g:coc_global_extensions = ['coc-tsserver', 'coc-eslint8', 'coc-fzf-preview', 'coc-lists' , 'coc-prettier', 'coc-spell-checker', 'coc-highlight', 'coc-emmet', 'coc-diagnostic', 'coc-json', 'coc-jedi', 'coc-yaml', 'coc-react-refactor', 'coc-ultisnips', 'coc-fzf-preview', 'coc-explorer']

inoremap  <expr> <C-Space> coc#refresh()
nnoremap <silent> H       :<C-u>call <SID>show_documentation()<CR>
nmap     <silent> [dev]rn <Plug>(coc-rename)
nmap     <silent> [dev]a  <Plug>(coc-codeaction-selected)iw
nmap     <silent> [dev]d  :CocDiagnostics<CR>

function! s:coc_typescript_settings() abort
nnoremap <silent> <buffer> [dev]f <Plug>(coc-format-selected):<C-u>CocCommand eslint.executeAutofix<CR>:CocCommand prettier.formatFile<CR>
endfunction

augroup coc_ts
autocmd!
autocmd FileType typescript,typescriptreact call <SID>coc_typescript_settings()
augroup END


"" coc.nvim
imap <C-ENTER> <Plug>(coc-snippets-expand)

let g:UltiSnipsExpandTrigger = '<f5>'
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
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
nnoremap <silent> <Leader>e :NvimTreeToggle<CR>
nnoremap <silent> <Leader>E :NvimTreeFindFile<CR>

"" react-refactor
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
let g:markdown_fenced_languages = ['html', 'python', 'lua', 'vim', 'typescript', 'javascript']
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
lua << END
require('lualine').setup{
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'diff'},
    lualine_c = {{ 'filename', path=1 }},
    lualine_x = {'diagnostics'},
    lualine_z = {''},
    lualine_y = {''},
    },
  options = {
      theme = 'palenight'
    }
}
END

" set noshowmode
set laststatus=3
