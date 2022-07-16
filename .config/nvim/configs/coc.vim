" COC https://qiita.com/coil_msp123/items/29de76b035dd28af77a9
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> H :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" https://zenn.dev/yano/articles/vim_frontend_development_2021#nvim-treesitter-(*)
" map prefix
let g:mapleader = "\<Space>"
nnoremap <Leader> <Nop>
xnoremap <Leader> <Nop>
nnoremap [dev]    <Nop>
xnoremap [dev]    <Nop>
nmap     m        [dev]
xmap     m        [dev]
nnoremap [ff]     <Nop>
xnoremap [ff]     <Nop>
nmap     z        [ff]
xmap     z        [ff]

" coc.nvim
let g:coc_global_extensions = ['coc-tsserver', 'coc-eslint8', 'coc-fzf-preview', 'coc-lists' , 'coc-prettier', 'coc-spell-checker', 'coc-highlight', 'coc-emmet', 'coc-diagnostic', 'coc-json', 'coc-jedi', 'coc-yaml', 'coc-react-refactor', 'coc-ultisnips', 'coc-fzf-preview', 'coc-explorer', 'coc-markmap', 'coc-cssmodules', 'coc-docker', 'coc-floaterm', 'coc-sql', 'coc-swagger', '@yaegassy/coc-tailwindcss3']

inoremap  <expr> <C-Space> coc#refresh()
nnoremap <silent> H       :<C-u>call <SID>show_documentation()<CR>
nmap     <silent> [dev]rn <Plug>(coc-rename)
nmap     <silent> [dev]a  <Plug>(coc-codeaction-selected)iw
nmap     <silent> [dev]d  :CocDiagnostics<CR>

function! s:coc_typescript_settings() abort
nnoremap <silent> <buffer> [dev]f <Plug>(coc-format-selected):<C-u>CocCommand eslint.executeAutofix<CR>:CocCommand prettier.formatFile<CR>
endfunction

augroup coc_ts
autocmd!
autocmd FileType typescript,typescriptreact call <SID>coc_typescript_settings()
augroup END


"" coc.nvim
imap <C-ENTER> <Plug>(coc-snippets-expand)


