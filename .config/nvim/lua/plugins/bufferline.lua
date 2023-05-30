local cmp_status_ok, bufferline = pcall(require, "bufferline")
if not cmp_status_ok then
	return
end

bufferline.setup({
	options = {
		separator_style = "slant", -- "slant" | "thick" | "thin" | { 'any', 'any' }
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
		hover = {
			enabled = true,
			delay = 200,
			reveal = { "close" },
		},
	},
})
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-n>", ":BufferLineCycleNext<CR>", { noremap = true })
vim.keymap.set("n", "<C-p>", ":BufferLineCyclePrev<CR>", { noremap = true })
-- vim.keymap.set("n", "<C-b>", builtin.buffers, { noremap = true })
