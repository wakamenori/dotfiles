nnoremap <silent> <C-n> :BufferLineCycleNext<CR>
nnoremap <silent> <C-p> :BufferLineCyclePrev<CR>

" These commands will move the current buffer backwards or forwards in the bufferline
nnoremap <silent><C-s> :BufferLineMoveNext<CR>
nnoremap <silent><C-a> :BufferLineMovePrev<CR>

" These commands will sort buffers by directory, language, or a custom criteria
nnoremap <silent>be :BufferLineSortByExtension<CR>
nnoremap <silent>bd :BufferLineSortByDirectory<CR>


" anzu
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
nmap <silent> <Esc><Esc> <Plug>(anzu-clear-search-status) :noh <CR>
":set nohlsearch<CR><ESC>

" nvim-tree
nnoremap <silent> <Leader>e :NvimTreeToggle<CR>
nnoremap <silent> <Leader>w :NvimTreeFindFile<CR>

" neotest
nmap [dev]tr :lua require("neotest").run.run()<CR>
nmap [dev]tc :lua require("neotest").run.run(vim.fn.expand("%"))<CR>
nmap [dev]to :lua require("neotest").summary.open()<CR>

" undo
nnoremap <Leader>u :UndotreeToggle<cr>

nnoremap <silent> gs :Lspsaga signature_help<CR>

" Normal-mode commands
nnoremap <silent> ∆ :MoveLine(1)<CR> " j
nnoremap <silent> ˚ :MoveLine(-1)<CR> " k
nnoremap <silent> ¬ :MoveHChar(1)<CR> " l
nnoremap <silent> ˙ :MoveHChar(-1)<CR> " h

" Visual-mode commands
vnoremap <silent> ∆ :MoveBlock(1)<CR>
vnoremap <silent> ˚ :MoveBlock(-1)<CR>
vnoremap <silent> ¬ :MoveHBlock(1)<CR>
vnoremap <silent> ˙ :MoveHBlock(-1)<CR>


" Telescope
nnoremap <C-f> <cmd>Telescope find_files hidden=true<cr>
nnoremap <C-c> <cmd>Telescope live_grep<cr>
