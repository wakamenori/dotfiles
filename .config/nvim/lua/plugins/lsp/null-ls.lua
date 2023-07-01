-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters
local code_actions = null_ls.builtins.code_actions

-- configure null_ls
null_ls.setup({
	-- setup formatters & linters
	sources = {
		--  to disable file types use
		--  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
		formatting.prettier, -- js/ts formatter
		formatting.stylua, -- lua formatter
		diagnostics.eslint_d.with({
			-- js/ts linter
			-- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
			condition = function(utils)
				return utils.root_has_file(".eslintrc.json") -- change file extension if you use something else
			end,
		}),
		code_actions.eslint_d,
		diagnostics.flake8, -- python linter
		diagnostics.mypy, -- python linter
		formatting.black.with({ extra_args = { "--line-length", "119" } }), -- python formatter
		-- formatting.black, -- python formatter
		formatting.isort, -- python formatter

		code_actions.gitsigns,

		-- diagnostics.cspell.with({
		-- 	diagnostics_postprocess = function(diagnostic)
		-- 		-- レベルをWARNに変更（デフォルトはERROR）
		-- 		diagnostic.severity = vim.diagnostic.severity["WARN"]
		-- 	end,
		-- 	-- FIXME: with config, cspell doesn't work
		-- 	extra_args = { "--config", "~/.config/nvim/lua/plugins/cspell/cspell.json" },
		-- 	condition = function()
		-- 		-- cspellが実行できるときのみ有効
		-- 		return vim.fn.executable("cspell") > 0
		-- 	end,
		-- 	-- https://zenn.dev/kawarimidoll/articles/ad35f3dc4a5009
		-- 	-- https://zenn.dev/kawarimidoll/articles/2e99432d27eda3
		-- }),
	},
	-- configure format on save
	-- on_attach = function(current_client, bufnr)
	-- 	if current_client.supports_method("textDocument/formatting") then
	-- 		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	-- 		vim.api.nvim_create_autocmd("BufWritePre", {
	-- 			group = augroup,
	-- 			buffer = bufnr,
	-- 			callback = function()
	-- 				vim.lsp.buf.format({
	-- 					filter = function(client)
	-- 						--  only use null-ls for formatting instead of lsp server
	-- 						return client.name == "null-ls"
	-- 					end,
	-- 					bufnr = bufnr,
	-- 				})
	-- 			end,
	-- 		})
	-- 	end
	-- end,
})
