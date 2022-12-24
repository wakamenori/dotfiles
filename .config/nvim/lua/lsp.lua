local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- vim.opt.spell = true
-- vim.opt.spelllang = { 'en_us' }

require("nvim-lsp-installer").setup({
    automatic_installation = true,
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>df', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local colors = require("tokyonight.colors").setup({})
vim.api.nvim_set_hl(0, "NavicIconsFile", { default = true, bg = colors.active, fg = colors.blue })
vim.api.nvim_set_hl(0, "NavicIconsModule", { default = true, bg = colors.active, fg = colors.blue })
vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = true, bg = colors.active, fg = colors.yellow })
vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = true, bg = colors.active, fg = colors.orange })
vim.api.nvim_set_hl(0, "NavicIconsClass", { default = true, bg = colors.active, fg = colors.yellow })
vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = true, bg = colors.active, fg = colors.purple })
vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = true, bg = colors.active, fg = colors.blue })
vim.api.nvim_set_hl(0, "NavicIconsField", { default = true, bg = colors.active, fg = colors.blue })
vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = true, bg = colors.active, fg = colors.yellow })
vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = true, bg = colors.active, fg = colors.yellow })
vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = true, bg = colors.active, fg = colors.yellow })
vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = true, bg = colors.active, fg = colors.purple })
vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = true, bg = colors.active, fg = colors.blue })
vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = true, bg = colors.active, fg = colors.orange })
vim.api.nvim_set_hl(0, "NavicIconsString", { default = true, bg = colors.active, fg = colors.green })
vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = true, bg = colors.active, fg = colors.green })
vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = true, bg = colors.active, fg = colors.orange })
vim.api.nvim_set_hl(0, "NavicIconsArray", { default = true, bg = colors.active, fg = colors.yellow })
vim.api.nvim_set_hl(0, "NavicIconsObject", { default = true, bg = colors.active, fg = colors.orange })
vim.api.nvim_set_hl(0, "NavicIconsKey", { default = true, bg = colors.active, fg = colors.purple })
vim.api.nvim_set_hl(0, "NavicIconsNull", { default = true, bg = colors.active, fg = colors.red })
vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = true, bg = colors.active, fg = colors.cyan })
vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = true, bg = colors.active, fg = colors.yellow })
vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = true, bg = colors.active, fg = colors.purple })
vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = true, bg = colors.active, fg = colors.purple })
vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, bg = colors.active, fg = colors.yellow })
vim.api.nvim_set_hl(0, "NavicText", { default = true, bg = colors.active, fg = colors.fg })
vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, bg = colors.active, fg = colors.cyan })

local navic = require("nvim-navic")
navic.setup {
    highlight = true,
}

local on_attach = function(client, bufnr)
    navic.attach(client, bufnr)
    vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}


require('lspkind').init({
    -- DEPRECATED (use mode instead): enables text annotations
    --
    -- default: true
    -- with_text = true,

    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = 'symbol_text',

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'codicons',


    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "ﰠ",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "塞",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "פּ",
        Event = "",
        Operator = "",
        TypeParameter = ""
    },
})
local lspkind = require('lspkind')
-- Setup nvim-cmp.
local cmp = require 'cmp'


local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")

cmp.setup({
    window = {
        completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
        },
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. strings[1] .. " "
            kind.menu = "    (" .. strings[2] .. ")"

            return kind
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
        ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
    }),
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        { name = 'path' },
        { name = 'buffer' },
        { name = 'luasnip' }, -- For luasnip users.
        { name = 'spell' },
    }, {
        { name = 'buffer' },
    })
})


require("symbols-outline").setup()

--use custom config
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['pyright'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
}

require("mason").setup()
require("mason-lspconfig").setup_handlers {
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      on_attach = on_attach
    }
  end,
}

require('lspconfig')['tsserver'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}

require('lspconfig')['sumneko_lua'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim' } }
        }
    }
}

require('lspconfig')['yamlls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities
}

require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.diagnostics.eslint,
        require("null-ls").builtins.completion.spell,
        require("null-ls").builtins.formatting.prettierd,
        require("null-ls").builtins.formatting.black,
        require("null-ls").builtins.formatting.isort,
        -- require("null-ls").builtins.diagnostic.flake8,
        -- require("null-ls").builtins.diagnostic.mypy,
    },
})

-- require("lsp_lines").setup()


vim.keymap.set("n", "<Leader>h", "<cmd>lua vim.lsp.buf.format()<CR>", { silent = false, noremap = true })
-- vim.keymap.set("n", "gh", require("lspsaga.finder").lsp_finder, { silent = true, noremap = true })
vim.keymap.set("n", "gh", '<cmd>Lspsaga lsp_finder<CR>', { silent = true, noremap = true })
vim.keymap.set("v", "gh", '<cmd>Lspsaga lsp_finder<CR>', { silent = true, noremap = true })

local action = require("lspsaga.codeaction")

-- code action
vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true, noremap = true })
vim.keymap.set("v", "<leader>ca", function()
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
    action.range_code_action()
end, { silent = true, noremap = true })

vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

-- local action = require("lspsaga.action")
-- scroll down hover doc or scroll in definition preview
-- vim.keymap.set("n", "<C-f>", function()
--     action.smart_scroll_with_saga(1)
-- end, { silent = true })
-- -- scroll up hover doc
-- vim.keymap.set("n", "<C-b>", function()
--     action.smart_scroll_with_saga(-1)
-- end, { silent = true })

-- vim.keymap.set("n", "gs", require("lspsaga.signaturehelp").signature_help, { silent = true, noremap = true })
vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>t", "<cmd>Trouble workspace_diagnostics <CR>", { silent = true, noremap = true })

vim.keymap.set("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", { silent = true, noremap = true })


-- require("lsp_lines").setup()
-- vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
-- vim.keymap.set(
--   "n",
--   "<Leader>l",
--   require("lsp_lines").toggle,
--   { desc = "Toggle lsp_lines" }
-- )

vim.diagnostic.config({
  virtual_text = true,
})
require('lspconfig').jsonls.setup {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}

local venv = os.getenv('VIRTUAL_ENV')
command = string.format('%s/bin/python', venv)

require('dap-python').setup(command)
vim.api.nvim_set_keymap('n', '<F5>', ':DapContinue<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F10>', ':DapStepOver<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F11>', ':DapStepInto<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F12>', ':DapStepOut<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':DapToggleBreakpoint<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>B', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Breakpoint condition: "))<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>lp', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>dr', ':lua require("dap").repl.open()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>dl', ':lua require("dap").run_last()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>d', ':lua require("dapui").toggle()<CR>', {})
require("dapui").setup({
  icons = { expanded = "", collapsed = "" },
  layouts = {
    {
      elements = {
        { id = "watches", size = 0.20 },
        { id = "stacks", size = 0.20 },
        { id = "breakpoints", size = 0.20 },
        { id = "scopes", size = 0.40 },
      },
      size = 64,
      position = "right",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.20,
      position = "bottom",
    },
  },
})
