local lualine_status_ok, lualine = pcall(require, "lualine")
if not lualine_status_ok then
	return
end

local function searchCount()
	local search = vim.fn.searchcount({ maxcount = 0 }) -- maxcount = 0 makes the number not be capped at 99
	local searchCurrent = search.current
	local searchTotal = search.total
	if searchCurrent > 0 and vim.v.hlsearch ~= 0 then
		return "/" .. vim.fn.getreg("/") .. " [" .. searchCurrent .. "/" .. searchTotal .. "]"
	else
		return ""
	end
end

local utils = require("lualine.utils.utils")
local highlight = require("lualine.highlight")

local diagnostics_message = require("lualine.component"):extend()

diagnostics_message.default = {
	colors = {
		error = utils.extract_color_from_hllist(
			{ "fg", "sp" },
			{ "DiagnosticError", "LspDiagnosticsDefaultError", "DiffDelete" },
			"#e32636"
		),
		warning = utils.extract_color_from_hllist(
			{ "fg", "sp" },
			{ "DiagnosticWarn", "LspDiagnosticsDefaultWarning", "DiffText" },
			"#ffa500"
		),
		info = utils.extract_color_from_hllist(
			{ "fg", "sp" },
			{ "DiagnosticInfo", "LspDiagnosticsDefaultInformation", "DiffChange" },
			"#ffffff"
		),
		hint = utils.extract_color_from_hllist(
			{ "fg", "sp" },
			{ "DiagnosticHint", "LspDiagnosticsDefaultHint", "DiffAdd" },
			"#273faf"
		),
	},
}
function diagnostics_message:init(options)
	diagnostics_message.super:init(options)
	self.options.colors = vim.tbl_extend("force", diagnostics_message.default.colors, self.options.colors or {})
	self.highlights = { error = "", warn = "", info = "", hint = "" }
	self.highlights.error = highlight.create_component_highlight_group(
		{ fg = self.options.colors.error },
		"diagnostics_message_error",
		self.options
	)
	self.highlights.warn = highlight.create_component_highlight_group(
		{ fg = self.options.colors.warn },
		"diagnostics_message_warn",
		self.options
	)
	self.highlights.info = highlight.create_component_highlight_group(
		{ fg = self.options.colors.info },
		"diagnostics_message_info",
		self.options
	)
	self.highlights.hint = highlight.create_component_highlight_group(
		{ fg = self.options.colors.hint },
		"diagnostics_message_hint",
		self.options
	)
end

function diagnostics_message:update_status(is_focused)
	local r, _ = unpack(vim.api.nvim_win_get_cursor(0))
	local diagnostics = vim.diagnostic.get(0, { lnum = r - 1 })
	if #diagnostics > 0 then
		local top = diagnostics[1]
		for _, d in ipairs(diagnostics) do
			if d.severity < top.severity then
				top = d
			end
		end
		local icons = { "󰅚 ", " ", " ", "󰌶 " }
		local hl = {
			self.highlights.error,
			self.highlights.warn,
			self.highlights.info,
			self.highlights.hint,
		}
		return highlight.component_format_highlight(hl[top.severity])
			.. icons[top.severity]
			.. " "
			.. utils.stl_escape(top.message)
	else
		return ""
	end
end

lualine.setup({
	sections = {
		lualine_a = {
			"mode",
		},
		lualine_b = {

			{ "filename", path = 1 },
			{
				"diff",
				colored = true, -- Displays a colored diff status if set to true
				diff_color = {
					-- Same color values as the general color option can be used here.
					added = "DiffAdd", -- Changes the diff's added color
					modified = "DiffChange", -- Changes the diff's modified color
					removed = "DiffDelete", -- Changes the diff's removed color you
				},
				symbols = { added = "+", modified = "~", removed = "-" }, -- Changes the symbols used by the diff.
				source = nil, -- A function that works as a data source for diff.
				-- It must return a table as such:
				--   { added = add_count, modified = modified_count, removed = removed_count }
				-- or nil on failure. count <= 0 won't be displayed.
			},
		},
		lualine_c = {
			{
				diagnostics_message,
				colors = {
					error = "#BF616A",
					warn = "#EBCB8B",
					info = "#A3BE8C",
					hint = "#88C0D0",
				},
			},
		},
		lualine_x = { "diagnostics" },
		lualine_y = { searchCount, "location", "progress" },
		lualine_z = { "bo:filetype" },
	},
	options = {
		theme = "github_dark_dimmed",
	},
	extensions = { "fzf", "quickfix", "nvim-dap-ui" },
})
