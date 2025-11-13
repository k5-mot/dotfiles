" fern.vim configuration

" Use nerdfont renderer
let g:fern#renderer = 'nerdfont'

" Basic fern settings
let g:fern#default_hidden = 1
let g:fern#disable_default_mappings = 1

" Custom mappings for fern
function! s:init_fern() abort
  " Basic operations
  nmap <buffer> <CR> <Plug>(fern-action-open-or-expand)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-action-open-or-expand)
  nmap <buffer> o <Plug>(fern-action-open:edit)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> t <Plug>(fern-action-open:tabedit)
  nmap <buffer> x <Plug>(fern-action-collapse)

  " File operations
  nmap <buffer> N <Plug>(fern-action-new-file)
  nmap <buffer> K <Plug>(fern-action-new-dir)
  nmap <buffer> D <Plug>(fern-action-remove)
  nmap <buffer> R <Plug>(fern-action-rename)
  nmap <buffer> M <Plug>(fern-action-move)
  nmap <buffer> C <Plug>(fern-action-copy)

  " Navigation
  nmap <buffer> u <Plug>(fern-action-leave)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> h <Plug>(fern-action-hidden-toggle)
  nmap <buffer> q :<C-u>quit<CR>

  " Marks
  nmap <buffer> m <Plug>(fern-action-mark-toggle)
  nmap <buffer> * <Plug>(fern-action-mark-toggle)j
endfunction

augroup fern_custom
  autocmd!
  autocmd FileType fern call s:init_fern()
augroup END

" Keybinding to open fern
nnoremap <silent> <Leader>f :Fern . -drawer -toggle<CR>
nnoremap <silent> <Leader>F :Fern . -drawer -reveal=%<CR>
