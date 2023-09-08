vim.cmd([[
colorscheme github_dark_dimmed
" colorscheme vn-night
" colorscheme tokyonight-night
" colorscheme text-to-colorscheme
" colorscheme oxocarbon
" hi Normal guibg=NONE ctermbg=NONE
]])

require("settings.keymaps")
require("settings.plug-keymaps")

-- require("settings.colorscheme").set()
local opt = vim.opt

opt.mousemoveevent = true
opt.termguicolors = true
opt.cmdheight = 0
opt.mouse = "a"
opt.enc = "utf-8"
opt.backup = false
opt.swapfile = false
opt.writebackup = false
opt.hidden = true
opt.showcmd = true
opt.number = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.textwidth = 0
opt.autoindent = true
opt.clipboard = "unnamed"
opt.virtualedit = "onemore"
opt.smartindent = true
opt.visualbell = true
opt.showmatch = true
opt.matchtime = 3
opt.laststatus = 3
opt.wildmode = "list:longest"
opt.syntax = "on"
opt.signcolumn = "yes"
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.wrapscan = true
opt.wrap = true
opt.wildmenu = true
opt.splitbelow = true
opt.splitright = true
opt.cursorline = true
opt.spell = true

opt.shortmess:append("c")

vim.g.python3_host_prog = '/Users/pc-0005829/venv/bin/python'
vim.cmd("set whichwrap+=<,>,[,],h,l") -- move to next line with theses keys
vim.cmd([[set iskeyword+=-]]) -- treat dash separated words as a word text object
vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work
vim.cmd([[let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"]])
vim.cmd([[let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"]])

vim.cmd([[autocmd FileType typescriptreact set shiftwidth=2 tabstop=2]])
vim.cmd([[autocmd FileType typescript  set shiftwidth=2 tabstop=2]])
vim.cmd([[autocmd FileType html set shiftwidth=2 tabstop=2]])
vim.cmd([[autocmd FileType json set shiftwidth=2 tabstop=2]])

-- TODO: コピペ用。何してるかわかってない。効果も不明
-- vim.cmd([[
-- if &term =~ "xterm"
--     let &t_SI .= "\e[?2004h"
--     let &t_EI .= "\e[?2004l"
--     let &pastetoggle = "\e[201~"

--     function! XTermPasteBegin(ret)
--         set paste
--         return a:ret
--     endfunction

--     inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
-- endif

-- ]])

vim.cmd([[
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
]])
