local navic = require("nvim-navic")

require('lualine').setup {
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'diff'},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'diagnostics' },
        lualine_y = { 'anzu#search_status', 'location' },
        lualine_z = { 'bo:filetype' },
    },
    options = {
        theme = 'tokyonight'
    },
    extensions = { 'fzf', 'quickfix', 'nvim-dap-ui' }
}

require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
require('telescope').load_extension('fzf')

require("nvim-tree").setup({
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    filters = { dotfiles = false, custom = { '^.git$' }},
    git = {
        enable = true,
        timeout = 400 -- (in ms)
  }

})

require("lsp-colors").setup({
    Error = "#db4b4b",
    Warning = "#e0af68",
    Information = "#0db9d7",
    Hint = "#10B981"
})
require("auto-save").setup{}

require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "typescript",
        "tsx",
    },
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
    }
}
require("hop").setup {}
vim.api.nvim_set_keymap('', 'f', "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap('', 'F', "<cmd>lua require'hop'.hint_patterns()<cr>", {})

require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
}

-- vim.notify = require("notify")
-- indent
vim.opt.list = true
-- vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}

-- require("lsp_lines").setup()
require("typescript").setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
    },
    server = { -- pass options to lspconfig's setup method
        on_attach = ...,
    },
})
require("todo-comments").setup {}
require("icon-picker")
require("scrollbar").setup()
require("nvim-surround").setup()
require 'colorizer'.setup()
require("startup").setup({theme = "dashboard"})
require("luasnip.loaders.from_vscode").lazy_load()

require('whitespace-nvim').setup({
    highlight = 'lualine_a_replace',
    ignored_filetypes = { 'TelescopePrompt', 'Trouble' },
})
-- vim.api.nvim_set_keymap(
--     'n',
--     '<Leader>t',
--     [[<cmd>lua require('whitespace-nvim').trim()<CR>]],
--     { noremap = true }
-- )

require("lsp")
require("buffer")
require("git")
require("wild")
-- require("noice").setup()

-- Lua
local nm = require("neo-minimap") -- for shorthand use later

-- TSX
nm.set("zi", "typescriptreact", {  -- press `zi` to open the minimap, in `typescriptreact` files
	query = [[
;; query
((function_declaration) @cap) ;; matches function declarations
((arrow_function) @cap) ;; matches arrow functions
((identifier) @cap (#vim-match? @cap "^use.*")) ;; matches hooks (useState, useEffect, use***, etc...)
  ]],
})

