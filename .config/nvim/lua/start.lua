local navic = require("nvim-navic")
require('lualine').setup{
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'diff'},
    lualine_c = {{ 'filename', path=1 }},
    lualine_x = {'diagnostics'},
    lualine_y = {'anzu#search_status'},
    lualine_z = {'bo:filetype'},
    },
  options = {
      theme = 'tokyonight'
    },
  extensions = { 'nvim-tree', 'fzf', 'quickfix', 'nvim-dap-ui' }
}


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
  filters = { custom = { "^.git$" } }
})

require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})

local autosave = require("autosave")
autosave.setup(
  {
      enabled = true,
      execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
      events = {"InsertLeave", "TextChanged"},
      conditions = {
          exists = true,
          filename_is_not = {},
          filetype_is_not = {},
          modifiable = true
      },
      write_all_buffers = false,
      on_off_commands = true,
      clean_command_line_interval = 0,
      debounce_delay = 1000
  }
)

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

require("hop").setup{}
vim.api.nvim_set_keymap('', 'f', "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap('', 'F', "<cmd>lua require'hop'.hint_patterns()<cr>", {})

require("todo-comments").setup{}
require("icon-picker")
require("scrollbar").setup()
require("nvim-surround").setup()
require'colorizer'.setup()

require("buffer")

