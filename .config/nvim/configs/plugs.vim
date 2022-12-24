call plug#begin()
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
Plug 'sheerun/vim-polyglot'
Plug 'easymotion/vim-easymotion'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sjl/vitality.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'simeji/winresizer'
Plug 'tpope/vim-fugitive'
Plug 'wakatime/vim-wakatime'
Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }
Plug 'rhysd/committia.vim'
Plug 'cohama/lexima.vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'SirVer/ultisnips'
Plug 'vim-scripts/indentpython.vim'
Plug 'honza/vim-snippets'
Plug 'mbbill/undotree'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'kyazdani42/nvim-tree.lua'
Plug 'folke/todo-comments.nvim'
Plug 'psf/black'
Plug 'jmcantrell/vim-virtualenv'
Plug 'luochen1990/rainbow'
Plug 'osyo-manga/vim-anzu'
Plug 'tpope/vim-endwise'
Plug 'norcalli/nvim-colorizer.lua'
" Plug 'rcarriga/nvim-notify'
Plug 'nvim-lua/plenary.nvim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'stevearc/dressing.nvim'
Plug 'toppair/reach.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'RRethy/vim-illuminate'
Plug 'numToStr/Comment.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'lewis6991/gitsigns.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'kdheepak/lazygit.nvim'
Plug 'Pocco81/auto-save.nvim'
Plug 'shaunsingh/moonlight.nvim'
Plug 'rose-pine/neovim'
Plug 'nxvu699134/vn-night.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'junegunn/goyo.vim'
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
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'tpope/vim-repeat'
Plug 'mbbill/undotree'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
Plug 'weilbith/nvim-code-action-menu'
Plug 'ziontee113/icon-picker.nvim'

Plug 'github/copilot.vim'
" Statusline
Plug 'nvim-lualine/lualine.nvim'
Plug 'mkropat/vim-tnvim-lualine/lualine.nvimt' "FIX: これなに?

" Tmux
Plug 'tmux-plugins/vim-tmux'


" JP
Plug 'vim-jp/vimdoc-ja'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }


" Filer
Plug 'nixprime/cpsm'

" Utility
Plug 'marko-cerovac/material.nvim'
Plug 'kevinhwang91/promise-async'

" Theme
Plug 'rebelot/kanagawa.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'mcchrish/zenbones.nvim'
Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'navarasu/onedark.nvim'
Plug 'olimorris/onedarkpro.nvim'

" Theme Creation
Plug 'rktjmp/lush.nvim'

" Appearance
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'johnfrankmorgan/whitespace.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
Plug 'startup-nvim/startup.nvim'

" Cursor
Plug 'fedepujol/move.nvim'
Plug 'kylechui/nvim-surround'
Plug 'phaazon/hop.nvim'

" React
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" SQL
Plug 'jsborjesson/vim-uppercase-sql'

" UI
Plug 'ziontee113/neo-minimap'
Plug 'MunifTanjim/nui.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-lua/popup.nvim'
Plug 'petertriho/nvim-scrollbar'

" LSP
Plug 'ray-x/lsp_signature.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'folke/trouble.nvim'
Plug 'simrat39/symbols-outline.nvim'
Plug 'b0o/schemastore.nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'f3fora/cmp-spell'
Plug 'onsails/lspkind-nvim'
Plug 'ray-x/cmp-treesitter'
Plug 'SmiteshP/nvim-navic'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/typescript.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'folke/lsp-colors.nvim'

" Debug
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'https://github.com/mfussenegger/nvim-dap-python'
Plug 'nvim-neotest/neotest'
Plug 'nvim-neotest/neotest-python'
Plug 'nvim-neotest/neotest-plenary'
Plug 'nvim-neotest/neotest-vim-test'
Plug 'vim-test/vim-test'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'
call plug#end()
