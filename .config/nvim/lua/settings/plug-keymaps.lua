local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.keymap.set

-- Normal-mode commands
keymap("n", "∆", ":MoveLine(1) <CR>") --j
keymap("n", "˚", ":MoveLine(-1) <CR>") --k
keymap("n", "¬", ":MoveChar(1) <CR>") --l
keymap("n", "˙", ":MoveChar(-1) <CR>") --h

-- Visual-mode commands
keymap("v", "∆", ":MoveBlock(1) <CR>") --j
keymap("v", "˚", ":MoveBlock(-1) <CR>") --k
keymap("v", "¬", ":MoveHBlock(1) <CR>") --l
keymap("v", "˙", ":MoveHBlock(-1) <CR>") --h

vim.cmd([[imap <silent><script><expr> <C-c> copilot#Accept("\<CR>")]])
vim.cmd([[let g:copilot_no_tab_map = v:true]])
keymap("i", "<C-]>", "<Plug>(copilot-next)", opts)
keymap("i", "<C-[>", "<Plug>(copilot-previous)", opts)
