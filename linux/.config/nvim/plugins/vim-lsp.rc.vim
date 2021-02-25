let g:lsp_diagnostics_enabled = v:true
let g:lsp_diagnostics_signs_enabled=1
let g:lsp_diagnostics_virtual_text_enabled=1
let g:lsp_diagnostics_echo_cursor = 1
set signcolumn=yes
"let g:lsp_signs_error = {'text': "\uf05e "}
"let g:lsp_signs_warning = {'text': "\uf071 "}
"let g:lsp_signs_hint = {'icon': '/path/to/some/other/icon'}
"let g:lsp_signs_ok = {'text': "\uf00c "}

"function! s:on_lsp_buffer_enabled() abort
"  setlocal omnifunc=lsp#complete
"  setlocal signcolumn=yes
"  nmap <buffer> gd <plug>(lsp-definition)
"  nmap <buffer> <f2> <plug>(lsp-rename)
"  inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
"endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/.cache/nvim/vim-lsp.log')

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_auto_popup = 1
"let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_auto_completeopt = 1
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 1

"function! s:lsp_setup()
"  let g:lsp_diagnostics_signs_enabled     = 1
"  let g:lsp_diagnostics_signs_error       = {'text': ''}
"  let g:lsp_diagnostics_signs_warning     = {'text': ''}
"  let g:lsp_diagnostics_signs_information = {'text': ''}
"  let g:lsp_diagnostics_signs_hint        = {'text': ''}
"endfunction

let g:lsp_diagnostics_signs_error       = {'text': "\uf057 "}
let g:lsp_diagnostics_signs_warning     = {'text': "\uf071 "}
let g:lsp_diagnostics_signs_information = {'text': "\uf05a "}
let g:lsp_diagnostics_signs_hint        = {'text': "\uf00c "}
"let g:lsp_diagnostics_signs_error = {'text': '✗'}
"let g:lsp_diagnostics_signs_warning = {'text': '‼'} " icons require GUI
"let g:lsp_diagnostics_signs_hint = {'text': 'A'} " icons require GUI
hi! LspErrorHighlight guifg=#dc322f guibg=NONE guisp=#dc322f gui=undercurl cterm=undercurl
hi! LspInfoHighlight guifg=#2aa198 guibg=NONE guisp=#2aa198 gui=undercurl cterm=undercurl
hi! LspWarningHighlight guifg=#b58900 guibg=NONE guisp=#b58900 gui=undercurl cterm=undercurl
"let g:lightline#ale#indicator_checking = "\uf110 "
"let g:lightline#ale#indicator_warnings = "\uf071 "
"let g:lightline#ale#indicator_errors = "\uf05e "
"let g:lightline#ale#indicator_ok = "\uf00c "


"augroup vimrc_lsp_icons
"  au!
"  autocmd User lsp_setup call s:lsp_setup()
"augroup END
