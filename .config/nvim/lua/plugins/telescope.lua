local status, telescope = pcall(require, "telescope")
if not status then
	return
end
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
	return vim.fn.expand("%:p:h")
end

local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
-- local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
-- table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
-- table.insert(vimgrep_arguments, "--glob")
-- table.insert(vimgrep_arguments, "!**/.git/*")

local fb_actions = require("telescope").extensions.file_browser.actions

telescope.setup({
	pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
			hidden = true,
		},
		live_grep = {
			aduitional_args = function(opts)
				return { "--hidden" }
			end,
		},
	},
	defaults = {
		mappings = {
			n = {
				["q"] = actions.close,
			},
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<esc>"] = actions.close,

				["<C-u>"] = false,
				-- ["<C-q>"] = actions.close,
			},
		},
		file_ignore_patterns = { "node_modules", ".git", ".idea" },
	},
	extensions = {
		file_browser = {
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				-- your custom insert mode mappings
				["i"] = {
					["<C-w>"] = function()
						vim.cmd("normal vbd")
					end,
				},
				["n"] = {
					-- your custom normal mode mappings
					["N"] = fb_actions.create,
					["h"] = fb_actions.goto_parent_dir,
					["/"] = function()
						vim.cmd("startinsert")
					end,
				},
			},
		},
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
	configs = {
		ensure_installed = { "markdown", "markdown_inline", ... },
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { "markdown" },
		},
	},
})
telescope.load_extension("file_browser")
telescope.load_extension("frecency")
require("telescope").load_extension("packer")
require("telescope").load_extension("fzf")

vim.keymap.set("n", ";f", function()
	builtin.find_files({
		no_ignore = false,
		hidden = true,
	})
end)
vim.keymap.set("n", ";r", function()
	builtin.live_grep()
end)
vim.keymap.set("n", ";b", function()
	builtin.buffers()
end)
vim.keymap.set("n", ";t", function()
	builtin.help_tags()
end)
vim.keymap.set("n", ";;", function()
	builtin.resume()
end)
vim.keymap.set("n", ";e", function()
	builtin.diagnostics()
end)
