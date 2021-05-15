"let g:asyncomplete_auto_popup = 1
"let g:asyncomplete_auto_popup = 0
"" Force refresh completion
"imap <C-x><C-u> <Plug>(asyncomplete_force_refresh)
"
"
"
"let g:vsnip_snippet_dir = expand('~/.cache/nvim/plugins/vsnip-snippets/vsnips')
"
""if !has('vsvim')
""  imap <expr> <Tab> vsnip#available(1) ? '<Plug>"(vsnip-expand-or-jump)' : pumvisible() ? "\<C-n>" : "\<Tab>"
""  smap <expr> <Tab> vsnip#available(1) ? '<Plug>"(vsnip-expand-or-jump)' : pumvisible() ? "\<C-n>" : "\<Tab>"
""  imap <expr> <S-Tab> vsnip#available(1) ? '<Plug>(vsnip-jump-prev)' ": pumvisible() ? "\<C-p>" : "\<S-Tab>"
""  smap <expr> <S-Tab> vsnip#available(1) ? '<Plug>(vsnip-jump-prev)' ": pumvisible() ? "\<C-p>" : "\<S-Tab>"
""
""  inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : ""\<CR>"
""  inoremap <expr> <C-y> pumvisible() ? asyncomplete#close_popup() : ""\<C-y>"
""  inoremap <expr> <C-e> pumvisible() ? asyncomplete#cancel_popup() : ""\<C-e>"
""
""  " Move up and down in autocomplete with <c-j> and <c-k>
""  inoremap <expr> <C-j> ("\<C-n>")
""  inoremap <expr> <C-k> ("\<C-p>")
""
""  autocmd! CompleteDone * if !pumvisible() | pclose | endif
""endif
"
"
"
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
"



" Tab completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" Force refresh completion
"imap <c-space> <Plug>(asyncomplete_force_refresh)
