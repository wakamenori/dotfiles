local gitsigns_status_ok, gitsigns = pcall(require, "gitsigns")
if not gitsigns_status_ok then
	return
end

local which_key_Status_ok, which_key = pcall(require, "which-key")
if not which_key_Status_ok then
	print("which_key not found")
	return
end

gitsigns.setup({
	signs = {
		add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		delete = { hl = "GitSignsDelete", text = "▁", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		topdelete = { hl = "GitSignsDelete", text = "▔", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	},
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		interval = 1000,
		follow_files = true,
	},
	attach_to_untracked = true,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 500,
		ignore_whitespace = false,
	},
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000,
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	yadm = {
		enable = false,
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		which_key.register({
			["]c"] = {
				function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end,
				"Next hunk",
			},
			["[c"] = {
				function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end,
				"Previous hunk",
			},
		}, { mode = "n", expr = true })

		-- Actions
		local opts = { noremap = true, silent = true, buffer = bufnr }
		which_key.register({
			h = {
				name = "Gitsigns",
				S = { gs.stage_buffer, "Stage buffer", opts },
				u = { gs.undo_stage_hunk, "Undo staged hunk", opts },
				R = { gs.reset_buffer, "Reset buffer", opts },
				p = { gs.preview_hunk, "Preview hunk", opts },
				d = { gs.diffthis, "Diff this", opts },
				D = {
					function()
						gs.diffthis("~")
					end,
					"Diff this against parent",
				},
				s = { ":Gitsigns stage_hunk <CR>", "Stage hunk", mode = { "v" }, opts },
				r = { ":Gitsigns reset_hunk<CR>", "Reset hunk", mode = { "v" }, opts },
				b = {
					function()
						gs.blame_line({ full = true })
					end,
					"Blame line",
					opts,
				},
			},
			t = {
				name = "Toggle",
				b = { gs.toggle_current_line_blame, "Toggle blame", opts },
				d = { gs.toggle_deleted, "Toggle deleted", opts },
			},
		}, { prefix = "<leader>", mode = "n" })

		-- Text object
		-- TODO: これ謎
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})
