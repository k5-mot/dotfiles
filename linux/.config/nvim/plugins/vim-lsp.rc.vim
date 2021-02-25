"let g:lsp_diagnostics_enabled = v:true
"let g:lsp_diagnostics_signs_enabled=1
"let g:lsp_diagnostics_virtual_text_enabled=1
"let g:lsp_diagnostics_echo_cursor = 1
"set signcolumn=yes
""let g:lsp_signs_error = {'text': "\uf05e "}
""let g:lsp_signs_warning = {'text': "\uf071 "}
""let g:lsp_signs_hint = {'icon': '/path/to/some/other/icon'}
""let g:lsp_signs_ok = {'text': "\uf00c "}
"
""function! s:on_lsp_buffer_enabled() abort
""  setlocal omnifunc=lsp#complete
""  setlocal signcolumn=yes
""  nmap <buffer> gd <plug>(lsp-definition)
""  nmap <buffer> <f2> <plug>(lsp-rename)
""  inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
""endfunction
"
"augroup lsp_install
"  au!
"  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
"augroup END
"command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/.cache/nvim/vim-lsp.log')
"
"let g:lsp_diagnostics_enabled = 1
"let g:lsp_diagnostics_signs_enabled = 1
"let g:lsp_diagnostics_echo_cursor = 1
""let g:asyncomplete_auto_popup = 1
""let g:asyncomplete_auto_completeopt = 0
"let g:asyncomplete_auto_completeopt = 1
"let g:asyncomplete_popup_delay = 200
"let g:lsp_text_edit_enabled = 1
"let g:lsp_format_sync_timeout = 1000
"
""function! s:lsp_setup()
""  let g:lsp_diagnostics_signs_enabled     = 1
""  let g:lsp_diagnostics_signs_error       = {'text': ''}
""  let g:lsp_diagnostics_signs_warning     = {'text': ''}
""  let g:lsp_diagnostics_signs_information = {'text': ''}
""  let g:lsp_diagnostics_signs_hint        = {'text': ''}
""endfunction
"







set signcolumn=yes

let g:lsp_diagnostics_signs_error       = {'text': "\uf057 "}
let g:lsp_diagnostics_signs_warning     = {'text': "\uf071 "}
let g:lsp_diagnostics_signs_information = {'text': "\uf05a "}
let g:lsp_diagnostics_signs_hint        = {'text': "\uf00c "}
