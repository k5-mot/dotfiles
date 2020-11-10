nnoremap [defx] <Nop>
nmap <Leader>d [defx]

" open defx
nnoremap <silent> [defx]f :<C-u>Defx -resume<CR>
" open defx current buffer dir
nnoremap <silent> [defx]b :<C-u>Defx `expand('%:p:h')` -search=`expand('%:p')`<CR>
