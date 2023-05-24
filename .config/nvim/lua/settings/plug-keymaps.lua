local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.keymap.set

-- Normal-mode commands
keymap("n", "<A-j>", ":MoveLine(1) <CR>", { noremap = true }) --j
keymap("n", "<A-k>", ":MoveLine(-1) <CR>", { noremap = true }) --k
keymap("n", "<A-l>", ":MoveChar(1) <CR>", { noremap = true }) --l
keymap("n", "<A-h>", ":MoveChar(-1) <CR>", { noremap = true }) --h

-- Visual-mode commands
keymap("v", "<A-j>", ":MoveBlock(1) <CR>", { noremap = true }) --j
keymap("v", "<A-k>", ":MoveBlock(-1) <CR>", { noremap = true }) --k
keymap("v", "<A-l>", ":MoveHBlock(1) <CR>", { noremap = true }) --l
keymap("v", "<A-h>", ":MoveHBlock(-1) <CR>", { noremap = true }) --h

-- vim.cmd([[imap <silent><script><expr> <C-c> copilot#Accept("\<CR>")]])
-- vim.cmd([[let g:copilot_no_tab_map = v:true]])
keymap("i", "«", "<Plug>(copilot-next)", opts)
keymap("i", "‘", "<Plug>(copilot-previous)", opts)
