let mapleader=" "

" IMEがオンの時もコマンドを入力したい
nnoremap あ a
nnoremap い i
nnoremap う u
nnoremap お o
nnoremap っd dd
nnoremap っy yy

" 削除キーでyankしない
nnoremap x "_x
nnoremap d "_d
"nnoremap d "_d
nnoremap D "_D

lua << EOF
local function delete_special()
	local line_data = vim.api.nvim_win_get_cursor(0) -- returns {row, col}
	local current_line = vim.api.nvim_buf_get_lines(0, line_data[1]-1, line_data[1], false)
	if current_line[1] == "" then
		return '"_dd'
	else
		return 'dd'
	end
end
vim.keymap.set( "n", "dd", delete_special, { noremap = true, expr = true } )
EOF

" jjでnormal mode
inoremap <silent> jj <ESC>

" switch pane
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nmap <C-q> :q<CR>

" 折り返し時に表示行単位での移動できるようにする

nnoremap j gj
nnoremap k gk

xnoremap p pgvy


