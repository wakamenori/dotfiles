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
		f = { "<cmd>Lspsaga finder<CR>", "Finder", opts },
		d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Declaration", opts },
		D = { "<cmd>Lspsaga peek_definition<CR>", "Peak definition", opts },
		i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation", opts },
	}, { prefix = "g", mode = "n" })

	which_key.register({
		f = { "<cmd>lua vim.lsp.buf.format({timeout_ms = 4000}) <CR>", "Format", opts },
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
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
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

local virtual_env_path = vim.trim(vim.fn.system("poetry config virtualenvs.path"))
local virtual_env_dirctory = vim.trim(vim.fn.system("poetry env list"))

local python_path = "python"
-- 現在のディレクトリに対応するvirtualenvがあるかのチェック
if #vim.split(virtual_env_dirctory, "\n") == 1 then
	python_path = string.format("%s/%s/bin/python", virtual_env_path, virtual_env_dirctory)
end
lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	-- settings = {
	-- 	python = {
	-- 		-- pythonPath = python_path,
	-- 		venvPath = ".",
	-- 		pythonPath = "./.venv/bin/python",
	-- 		analysis = {
	-- 			extraPaths = { "." },
	-- 		},
	-- 	},
	-- },
})

-- configure html server
lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["marksman"].setup({
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
typescript.actions.addMissingImports()

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

lspconfig["eslint"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

require("flutter-tools").setup({}) -- use defaults

-- FIXME: cmpでこいつが生成したタグを選択すると、vimがフリーズするバグが発生した
-- configure emmet language server
-- lspconfig["emmet_ls"].setup({
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- 	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
-- })

-- configure lua server (with special settings)
lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		-- custom settings for lua
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

require("lsp-file-operations").setup({
	-- used to see debug logs in file `vim.fn.stdpath("cache") .. lsp-file-operations.log`
	debug = false,
})
