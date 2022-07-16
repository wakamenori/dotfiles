source ~/.config/nvim/configs/plugs.vim

let vim_scripts = split(glob("~/.config/nvim/configs/" . "*.vim"))

for file in vim_scripts
  execute 'source' file
endfor

augroup start_screen
  au!
  autocmd VimEnter * ++once lua require('start')
augroup END

let g:mkdp_markdown_css = '/Users/matsukokuumahikari/md.css'
let g:mkdp_highlight_css = '/Users/matsukokuumahikari/md.css'
let g:mkdp_theme = 'light'

let g:black_virtualenv = "~/venv/"
let g:python3_host_prog = "~/venv/bin/python3"

augroup black_on_save
  autocmd!
  autocmd BufWritePre *.py Black
augroup end

nnoremap <F9> :Black<CR>
" Enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" インデント
let g:indent_guides_enable_on_vim_startup = 1
" 行番号を表示

set list listchars=tab:\▸\-

" autosave
autocmd FocusLost * silent wa

" FZF
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" [Commands] --expect expression for directly executing the command

" nnoremap <C-f> :Files<CR>

" GHQ fzf
command! -nargs=0 Fq call fzf#run({
\ 'source': 'ghq list --full-path',
\ 'sink': 'cd'
\ })


autocmd CursorHold * silent call CocActionAsync('highlight')

autocmd VimEnter * call s:setup_bufferline()
function! s:setup_bufferline() abort
endfunction


let g:indent_guides_exclude_filetypes = ["dashboard"]
lua << EOF
local db = require('dashboard')
EOF
let g:extra_whitespace_ignored_filetypes = ['unite', 'mkd', "dashboard"]

let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

nmap <silent> <C-_> <Plug>(pydocstring)

let g:Illuminate_ftblacklist = ['nerdtree', 'NvimTree']

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  indent = {
      enable = true,
  },
}
EOF
lua <<EOF
require("neotest").setup({
  adapters = {
    require("neotest-python")
  }
})
EOF
nmap <Leader>tr :lua require("neotest").run.run()<CR>
nmap <Leader>to :lua require("neotest").summary.open()<CR>
nmap <Leader>tc :lua require("neotest").run.run(vim.fn.expand("%"))<CR>

let g:rainbow_conf = {
  \	'separately': {
  \		'nerdtree': 0,
  \	}
  \}
let g:onedark_config = {
    \ 'style': 'deep',
\}

" color setting
if exists('+termguicolors')
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
endif

nmap <Leader>t :TagbarToggle<CR>

nmap [dev]tr :lua require("neotest").run.run()<CR>
nmap [dev]tc :lua require("neotest").run.run(vim.fn.expand("%"))<CR>
nmap [dev]to :lua require("neotest").summary.open()<CR>

set termguicolors

" undo
nnoremap <Leader>u :UndotreeToggle<cr>

let g:UltiSnipsExpandTrigger = '<f5>'
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
function! s:show_documentation() abort
if index(['vim','help'], &filetype) >= 0
  execute 'h ' . expand('<cword>')
elseif coc#rpc#ready()
  call CocActionAsync('doHover')
endif
endfunction

"" fzf-preview
let $BAT_THEME                     = 'OneHalfDark'
let $FZF_PREVIEW_PREVIEW_BAT_THEME = 'OneHalfDark'

let g:markdown_fenced_languages = ['html', 'python', 'lua', 'vim', 'typescript', 'javascript']

