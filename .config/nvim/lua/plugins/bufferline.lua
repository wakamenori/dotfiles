local cmp_status_ok, bufferline = pcall(require, "bufferline")
if not cmp_status_ok then
	return
end

bufferline.setup({
	options = {
		separator_style = "thin",
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
	},
})
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-n>", ":BufferLineCycleNext<CR>", { noremap = true })
vim.keymap.set("n", "<C-p>", ":BufferLineCyclePrev<CR>", { noremap = true })
vim.keymap.set("n", "<C-b>", builtin.buffers, { noremap = true })
