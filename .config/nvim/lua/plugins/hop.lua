local hop_status_ok, hop = pcall(require, "hop")
if not hop_status_ok then
	return
end

local which_key_status_ok, which_key = pcall(require, "which-key")
if not which_key_status_ok then
	return
end

hop.setup()

which_key.register({
	f = { "<cmd>lua require'hop'.hint_words()<cr>", "Hop Word" },
	F = { "<cmd>lua require'hop'.hint_patterns()<cr>", "Hop Pattern" },
}, { noremap = true, silent = true, mode = { "n", "v" } })

-- vim.api.nvim_set_keymap("n", "f", "<cmd>lua require'hop'.hint_words()<cr>", {})
-- vim.api.nvim_set_keymap("n", "F", "<cmd>lua require'hop'.hint_patterns()<cr>", {})
