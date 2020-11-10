let g:neosnippet#snippets_directory = '~/dotfiles/config/nvim/snippets'

"let g:neosnippet#disable_runtime_snippets = {
"      \ '_': 1,
"      \ }

" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

inoremap <expr><tab> pumvisible() ? "\<C-n>" :
      \ neosnippet#expandable_or_jumpable() ?
      \    "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
