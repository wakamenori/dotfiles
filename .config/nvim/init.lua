vim.o.termguicolors = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- vim.notify = require("notify")



require("plugins")
require("settings")
-- require("plugins.inpatient")
require("plugins.autopairs")
require("plugins.autosave")
require("plugins.lsp")
require("plugins.bufferline")
require("plugins.cmp")
require("plugins.gitsigns")
require("plugins.hlslens")
require("plugins.hop")
require("plugins.indent-blankline")
require("plugins.lualine")
-- require("plugins.material")
require("plugins.navic")
-- require("plugins.neotest") -- まだ適当
-- require("plugins.noice")
-- require("plugins.nvim-tree")
require("plugins.neo-tree")
-- require("plugins.obsidian") -- まだ適当
require("plugins.scrollbar")
require("plugins.telescope")
require("plugins.terminal")
require("plugins.todo-comments")
require("plugins.treesitter")
require("plugins.which-key")
require("plugins.wild")
require("plugins.illuminate")

