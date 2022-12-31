require("settings.keymaps")
require("settings.plug-keymaps")

vim.cmd([[colorscheme oxocarbon]])

local options = {
	termguicolors = true,
	cmdheight = 0,
	mouse = "a",
	fenc = "utf-8",
	backup = false,
	swapfile = false,
	writebackup = false,
	hidden = true,
	showcmd = true,
	number = true,
	shiftwidth = 4,
	tabstop = 4,
	expandtab = true,
	textwidth = 0,
	autoindent = true,
	clipboard = "unnamed",
	virtualedit = "onemore",
	smartindent = true,
	visualbell = true,
	showmatch = true,
	matchtime = 3,
	laststatus = 3,
	wildmode = "list:longest",
	syntax = "on",
	signcolumn = "yes",
	ignorecase = true,
	smartcase = true,
	incsearch = true,
	hlsearch = true,
	wrapscan = true,
	wrap = false,
	wildmenu = true,
	splitbelow = true,
	splitright = true,
    cursorline = true,
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end

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
vim.cmd([[
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function! XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

]])

vim.cmd([[
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
]])
