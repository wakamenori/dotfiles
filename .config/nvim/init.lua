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
vim.o.termguicolors = true

if vim.g.vscode then
	-- Config for VSCode
	require("lazy").setup({
		{
			"kylechui/nvim-surround",
			version = "*", -- Use for stability; omit to use `main` branch for the latest features
			event = "VeryLazy",
			config = function()
				require("nvim-surround").setup({
					-- Configuration here, or leave empty to use defaults
				})
			end,
		},
	})
	vim.cmd([[
          "clipboard
  if has("clipboard")
    if has("unnamedplus")
      " When possible use + register for copy-paste
      set clipboard=unnamed,unnamedplus
    else
      " On mac and Windows, use * register for copy-paste
      set clipboard=unnamed
    endif
  endif
  ]])
else
	-- Config for Neovim

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
	require("plugins.neogit")
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
end
