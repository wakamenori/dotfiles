
local function delete_special()
    local line_data = vim.api.nvim_win_get_cursor(0) -- returns {row, col}
    local current_line = vim.api.nvim_buf_get_lines(0, line_data[1] - 1, line_data[1], false)

    if current_line[1] == "" then
        return '"_dd'
    else
        return 'dd'
    end
end

local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

-- space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.maplocalleader = " "
vim.g.mapleader = " "

keymap("n", "あ", "a", opts)
keymap("n", "い", "i", opts)
keymap("n", "う", "u", opts)
keymap("n", "え", "e", opts)
keymap("n", "お", "o", opts)
keymap("n", "っd", "dd", opts)

keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)


keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("", "<C-q>", ":q<CR>")

keymap("i", "jj", "<esc>", opts)


-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)


-- Indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)


keymap("v", "p", '"_dP', opts)


-- Close all buffers
keymap("n", "<leader>q", ":bufdo bd<CR>", opts)
