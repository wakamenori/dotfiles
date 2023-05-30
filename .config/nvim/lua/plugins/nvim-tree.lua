local nvim_tree_status, nvim_tree = pcall(require, "nvim-tree")
if not nvim_tree_status then
	return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.6 -- You can change this too

local function on_attach(bufnr)
	local api = require("nvim-tree.api")
	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	api.config.mappings.default_on_attach(bufnr)
	vim.keymap.set("n", "x", api.node.navigate.parent_close, opts("Close"))
	vim.keymap.set("n", "r", api.fs.rename_sub, opts('Rename: Omit Filename'))
	-- override a default
	-- vim.keymap.set("n", "<C-e>", api.tree.reload, opts("Refresh"))
end

nvim_tree.setup({
	on_attach = on_attach,
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
	filters = {
		dotfiles = false,
		exclude = { "^.env$" }, -- List of directories or files to exclude from filtering: always show them.
		custom = {
			"^.git$",
			"^.idea$",
		},
	},
	git = {
		enable = true,
		timeout = 400, -- (in ms)
		ignore = true,
	},

	view = {
		-- mappings = {
		-- 	list = {
		-- 		{ key = "x", action = "close_node" },
		-- 	},
		-- },
		float = {
			enable = true,
			open_win_config = function()
				local screen_w = vim.opt.columns:get()
				local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
				local window_w = screen_w * WIDTH_RATIO
				local window_h = screen_h * HEIGHT_RATIO
				local window_w_int = math.floor(window_w)
				local window_h_int = math.floor(window_h)
				local center_x = (screen_w - window_w) / 2
				local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
				return {
					border = "rounded",
					relative = "editor",
					row = center_y,
					col = center_x,
					width = window_w_int,
					height = window_h_int,
				}
			end,
		},
		width = function()
			return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
		end,
	},
})

require("which-key").register({
	e = { ":NvimTreeToggle<CR>", "Toggle Nvim-tree" },
	w = { ":NvimTreeFindFile<CR>", "Find file in Nvim-tree" },
}, { prefix = "<leader>" })
