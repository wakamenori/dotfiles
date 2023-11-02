local function read_env_file_and_get(env_file, key)
	local env_values = {}
	for line in io.lines(env_file) do
		if string.sub(line, 1, 1) ~= "#" then
			local key_from_file, value = string.match(line, "(.-)=(.*)")
			if key_from_file and value then
				env_values[key_from_file] = value
			end
		end
	end
	return env_values[key]
end
local home_dir = os.getenv("HOME")
local env_file = home_dir .. "/.config/nvim/.env"

require("lazy").setup({
	"wakatime/vim-wakatime",
	"github/copilot.vim",
	-- colorscheme
	"ramojus/mellifluous.nvim",
	"Mofiqul/dracula.nvim",
	{ "dasupradyumna/midnight.nvim", lazy = false, priority = 1000 },
	{
		"svermeulen/text-to-colorscheme.nvim",
		-- config = function()
		-- 	require("text-to-colorscheme").setup({
		-- 		ai = {
		-- 			openai_api_key = read_env_file_and_get("/Users/matsukokuumahikari/.config/nvim/.env", "OPENAI_API_KEY"),
		-- 		},
		-- 	})
		-- end,
	},
	"olimorris/onedarkpro.nvim",

	"rebelot/kanagawa.nvim",
	{
		"blueshirts/darcula",
		config = function()
			vim.cmd([[colorscheme darcula]])
		end,
	},
	"projekt0n/github-nvim-theme",
	"rebelot/kanagawa.nvim",
	"nxvu699134/vn-night.nvim",
	"tjdevries/colorbuddy.vim",
	"folke/tokyonight.nvim",
	"nyoom-engineering/oxocarbon.nvim",
	"jacoborus/tender.vim",
	{ "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },
	-- Filer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			{
				-- only needed if you want to use the commands with "_with_window_picker" suffix
				"s1n7ax/nvim-window-picker",
				-- tag = "v1.*",
				config = function()
					require("window-picker").setup({
						autoselect_one = true,
						include_current = false,
						filter_rules = {
							-- filter using buffer options
							bo = {
								-- if the file type is one of following, the window will be ignored
								filetype = { "neo-tree", "neo-tree-popup", "notify" },

								-- if the buffer type is one of following, the window will be ignored
								buftype = { "terminal", "quickfix" },
							},
						},
						other_win_hl_color = "#e35e4f",
					})
				end,
			},
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({})
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	-- UI
	"rcarriga/nvim-notify",
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	"nvim-lua/popup.nvim",
	"nvim-lua/plenary.nvim",
	"nvim-lualine/lualine.nvim",
	"stevearc/dressing.nvim",

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
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
	"nvim-telescope/telescope-file-browser.nvim",
	-- {
	-- 	"nvim-telescope/telescope-frecency.nvim",
	-- 	config = function()
	-- 		require("telescope").load_extension("frecency")
	-- 	end,
	-- 	dependencies = { "kkharji/sqlite.lua" },
	-- },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},

	-- autosave
	"Pocco81/auto-save.nvim",

	-- LSP
	"SmiteshP/nvim-navic",
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"MunifTanjim/prettier.nvim",
	"folke/lsp-colors.nvim",
	"jose-elias-alvarez/typescript.nvim",
	"glepnir/lspsaga.nvim",
	"jose-elias-alvarez/null-ls.nvim",
	"jay-babu/mason-null-ls.nvim",
	"antosha417/nvim-lsp-file-operations",
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	"m-demare/hlargs.nvim",
	{
		"Wansmer/treesj",
		keys = { "<space>m", "<space>j", "<space>s" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({ --[[ your config ]]
			})
		end,
	},
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			require("chatgpt").setup({
				api_key_cmd = "op read 'op://Personal/4vml5a7eguwzp363mgq3oekjmm/api key' --no-newline",
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"piersolenski/wtf.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {
			openai_api_key = read_env_file_and_get(env_file, "OPENAI_API_KEY"),
		},
		keys = {
			{
				"gw",
				mode = { "n", "x" },
				function()
					require("wtf").ai()
				end,
				desc = "Debug diagnostic with AI",
			},
			{
				mode = { "n" },
				"gW",
				function()
					require("wtf").search()
				end,
				desc = "Search diagnostic with Google",
			},
		},
	},

	-- Comment
	"tpope/vim-commentary",
	"numToStr/Comment.nvim",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"folke/todo-comments.nvim",
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	"windwp/nvim-ts-autotag",

	-- Tmux
	"christoomey/vim-tmux-navigator",

	-- wilder.nvim
	"gelguy/wilder.nvim",

	-- CMP
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/vim-vsnip",
	"hrsh7th/vim-vsnip-integ",
	"L3MON4D3/LuaSnip",
	"onsails/lspkind-nvim",
	"akinsho/flutter-tools.nvim",

	-- Git
	"sindrets/diffview.nvim",
	"lewis6991/gitsigns.nvim",
	"kdheepak/lazygit.nvim",
	"tpope/vim-fugitive",
	{
		"dinhhuy258/git.nvim",

		config = function()
			require("git").setup()
		end,
	},
	{ "NeogitOrg/neogit", dependencies = "nvim-lua/plenary.nvim" },

	-- Auto Session
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			})
		end,
	},

	"windwp/nvim-autopairs",

	-- Search
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("hlslens").setup({})
		end,
	},
	"folke/todo-comments.nvim",
	"petertriho/nvim-scrollbar",

	-- Motion
	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	},
	"fedepujol/move.nvim",
	-- Highlight
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	"RRethy/vim-illuminate",
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"johnfrankmorgan/whitespace.nvim",
		config = function()
			require("whitespace-nvim").setup({
				highlight = "DiffDelete",
				ignored_filetypes = { "TelescopePrompt", "Trouble", "help", "terminal" },
			})
		end,
	},
	-- Terminal
	{ "akinsho/toggleterm.nvim", version = "*", config = true },

	-- preview
	{ "iamcco/markdown-preview.nvim" },
})
