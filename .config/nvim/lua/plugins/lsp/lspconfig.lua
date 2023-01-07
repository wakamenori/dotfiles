-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local navic_status, navic = pcall(require, "nvim-navic")
if not navic_status then
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
	return
end

local which_key_setup, which_key = pcall(require, "which-key")
if not which_key_setup then
	return
end

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	if client.name == "tsserver" then
		client.server_capabilities.document_formatting = false
	end

	if client.server_capabilities.documentSymbolProvider then
		vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
		navic.attach(client, bufnr)
	end

	-- set keybinds
	which_key.register({
		name = "LSP",
		f = { "<cmd>Lspsaga lsp_finder<CR>", "Finder", opts },
		d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Declaration", opts },
		D = { "<cmd>Lspsaga peek_definition<CR>", "Peak definition", opts },
		i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation", opts },
	}, { prefix = "g", mode = "n" })

	which_key.register({
		f = { "<cmd>lua vim.lsp.buf.format({timeout_ms = 2000}) <CR>", "Format", opts },
		a = { "<cmd>Lspsaga code_action<CR>", "Code action", opts },
		r = { "<cmd>Lspsaga rename<CR>", "Rename", opts },
		d = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show line diagnostics", opts },
		D = { "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Show cursor diagnostics", opts },
		["[d"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Jump to previous diagnostic", opts },
		["]d"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Jump to next diagnostic", opts },
		o = { "<cmd>Lspsaga outline<CR>", "Outline", opts },
	}, { prefix = "<leader>", mode = "n" })

	which_key.register({
		K = { "<cmd>Lspsaga hover_doc<CR>", "Hover doc", opts },
	})

	-- typescript specific keymaps (e.g. rename file and update imports)
	if client.name == "tsserver" then
		which_key.register({
			rf = { "<cmd>TypescriptRenameFile<CR>", "Rename file and update imports", opts },
			oi = { "<cmd>TypescriptOrganizeImports<CR>", "Organize imports", opts },
			ru = { "<cmd>TypescriptRemoveUnused<CR>", "Remove unused variables", opts },
		}, { prefix = "<leader>", mode = "n" })
	end
end


-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
	virtual_text = false,
    severity_sort = true,
})

-- enable lsp servers
-- Python
lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})


-- configure html server
lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["jsonls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure typescript server with plugin
typescript.setup({
	server = {
		capabilities = capabilities,
		on_attach = on_attach,
	},
})

-- configure css server
lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- configure tailwindcss server
lspconfig["tailwindcss"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- FIXME: cmpでこいつが生成したタグを選択すると、vimがフリーズするバグが発生した
-- configure emmet language server
-- lspconfig["emmet_ls"].setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- 	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
-- })

-- configure lua server (with special settings)
lspconfig["sumneko_lua"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

local status, prettier = pcall(require, "prettier")
if not status then
	return
end

prettier.setup({
	bin = "prettierd",
	filetypes = {
		"css",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"json",
		"scss",
		"less",
	},
})

-- Lua
require("lsp-colors").setup({
	Error = "#db4b4b",
	Warning = "#e0af68",
	Information = "#0db9d7",
	Hint = "#10B981",
})
