local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself

	--Colorschemes
    use("xiyaowong/nvim-transparent")
	use({ "tjdevries/colorbuddy.vim" })
	use({ "bkegley/gloombuddy" })
	use({ "folke/tokyonight.nvim" })
	use({ "ray-x/aurora" })
	use({ "ray-x/starry.nvim" })
	use({ "olimorris/onedarkpro.nvim" })
	use({ "nxvu699134/vn-night.nvim" })
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({ "Everblush/everblush.nvim", as = "everblush" })
	use("tiagovla/tokyodark.nvim")
	use("FrenzyExists/aquarium-vim")
	use({ "nyoom-engineering/oxocarbon.nvim" })
	use({ "wuelnerdotexe/vim-enfocado" })

	-- UI
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use({
		"folke/noice.nvim",
		requires = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	})

	-- Filer
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})

	-- Buffer
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })

	-- Statusline
	use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })

	--Git
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
	use({ "lewis6991/gitsigns.nvim" })
	use({ "kdheepak/lazygit.nvim" })
	use("tpope/vim-fugitive")

	-- Terminal
	use({ "akinsho/toggleterm.nvim", tag = "*" })

	-- Keybindings
	use({ "folke/which-key.nvim" })

	-- Autosave
	use("Pocco81/auto-save.nvim")

	-- Cursor movement
	use({ "fedepujol/move.nvim" })
	use({ "phaazon/hop.nvim", branch = "v2" })

	-- Search
	use({ "kevinhwang91/nvim-hlslens" })

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})
	use("nvim-telescope/telescope-packer.nvim")
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	use({
		"nvim-telescope/telescope-frecency.nvim",
		config = function()
			require("telescope").load_extension("frecency")
		end,
		requires = { "kkharji/sqlite.lua" },
	})

	-- Surround
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	use({
		"m-demare/hlargs.nvim",
		requires = { "nvim-treesitter/nvim-treesitter" },
	})

	-- Cmd
	use({ "gelguy/wilder.nvim" })

	-- use({
	-- 	"windwp/nvim-autopairs",
	-- 	config = function()
	-- 		require("nvim-autopairs").setup({})
	-- 	end,
	-- })

	-- Highlight
	use({ "RRethy/vim-illuminate" })
	use({ "lukas-reineke/indent-blankline.nvim" })
	use({ "norcalli/nvim-colorizer.lua" })
	use({
		"johnfrankmorgan/whitespace.nvim",
		config = function()
			require("whitespace-nvim").setup({
				highlight = "DiffDelete",
				ignored_filetypes = { "TelescopePrompt", "Trouble", "help", "terminal" },
			})
		end,
	})

	-- scrollbar
	use("petertriho/nvim-scrollbar")

	-- winbar
	use("SmiteshP/nvim-navic")

	-- LSP
	use({ "neovim/nvim-lspconfig" })
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "MunifTanjim/prettier.nvim" })
	use("folke/lsp-colors.nvim")
	use({ "jose-elias-alvarez/typescript.nvim" })
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			local saga = require("lspsaga")
			saga.init_lsp_saga({
				-- your configuration
			})
		end,
	})
	use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" } })
	use({ "jayp0521/mason-null-ls.nvim" })
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})

	-- CMP
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "L3MON4D3/LuaSnip" })
	use({ "onsails/lspkind.nvim" })
	-- use({ "onsails/lspkind-nvim" })

	-- Test
	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
		},
	})
	use({ "nvim-neotest/neotest-python" })

	-- Copilot
	use({ "github/copilot.vim" })

	-- Comments
	use({ "numToStr/Comment.nvim" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
	})


    -- Session
	use({
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			})
		end,
	})

	-- tmux
	use("christoomey/vim-tmux-navigator")

	-- Obsidian
	use({ "epwalsh/obsidian.nvim" })

	-- Fun
	use({ "eandrju/cellular-automaton.nvim" })

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
