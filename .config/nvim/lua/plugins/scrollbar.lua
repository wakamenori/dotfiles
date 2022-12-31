require("scrollbar").setup({
	excluded_filetypes = {
		"prompt",
		"TelescopePrompt",
		"NvimTree",
	},
})
require("scrollbar.handlers.gitsigns").setup()
require("scrollbar.handlers.search").setup({
	-- hlslens config overrides
})
