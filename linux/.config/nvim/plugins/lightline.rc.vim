set laststatus=2
set noshowmode

let g:lightline = {}

let g:lightline_color = "default"
let g:lightline.component = {
  \ 'mode': '%{lightline#mode()}',
  \ 'absolutepath': '%F',
  \ 'relativepath': '%f',
  \ 'filename': '%t',
  \ 'modified': '%M',
  \ 'bufnum': '%n',
  \ 'paste': '%{&paste?"PASTE":""}',
  \ 'readonly': '%R',
  \ 'charvalue': '%b',
  \ 'charvaluehex': '%B',
  \ 'fileencoding': '%{strlen(&fenc)?&fenc:&enc}',
  \ 'fileformat': '%{&fileformat}',
  \ 'filetype': '%{strlen(&filetype)?&filetype:"no ft"}',
  \ 'percent': '%3p%%',
  \ 'percentwin': '%P',
  \ 'lineinfo': '%3l:%-2v',
  \ 'line': '%l',
  \ 'column': '%c',
  \ 'close': '%999X X '
  \ }



" Register the components:
"let g:lightline.component_expand = {
"  \   'linter_warnings': 'lightline#coc#warnings',
"  \   'linter_errors': 'lightline#coc#errors',
"  \   'linter_info': 'lightline#coc#info',
"  \   'linter_hints': 'lightline#coc#hints',
"  \   'linter_ok': 'lightline#coc#ok',
"  \   'status': 'lightline#coc#status',
"  \ }
"
"" Set color to the components:
"let g:lightline.component_type = {
"  \   'linter_warnings': 'warning',
"  \   'linter_errors': 'error',
"  \   'linter_info': 'info',
"  \   'linter_hints': 'hints',
"  \   'linter_ok': 'left',
"  \ }

"let g:lightline.component_expand = {
"  \   'lsp_warnings': 'lightline_lsp#warnings',
"  \   'lsp_errors':   'lightline_lsp#errors',
"  \   'lsp_ok':       'lightline_lsp#ok',
"  \ }
"
"let g:lightline.component_type = {
"  \   'lsp_warnings': 'warning',
"  \   'lsp_errors':   'error',
"  \   'lsp_ok':       'middle',
"  \ }

let g:lightline = {
  \ 'enable': { 'tabline': 1 },
  \ 'colorscheme': g:lightline_color,
  \ 'separator': { 'left': "\ue0b0 ", 'right': " \ue0b2" },
  \ 'subseparator' :{ 'left': "\ue0b1 ", 'right': " \ue0b3" },
  \ 'active': {
  \   'left': [
  \     ['mode', 'paste'],
  \     ['readonly', 'filename', 'modified'],
  \     ['lsp_errors', 'lsp_warnings', 'lsp_ok'],
  \   ],
  \   'right': [
  \     ['lineinfo'],
  \     ['percent'],
  \     ['fileformat', 'fileencoding', 'filetype']
  \   ],
  \ },
  \ 'inactive': {
  \   'left': [
  \     ['filename']
  \   ],
  \   'right': [
  \     ['lineinfo'],
  \     ['percent']
  \   ]
  \ },
  \ 'component_expand': {
  \   'lsp_warnings': 'LightlineLSPWarnings',
  \   'lsp_errors':   'LightlineLSPErrors',
  \   'lsp_ok':       'LightlineLSPOk',
  \ },
  \ 'component_type': {
  \   'lsp_warnings': 'warning',
  \   'lsp_errors':   'error',
  \   'lsp_ok':       'normal',
  \ },
\ }

function! LightlineLSPWarnings() abort
  let l:counts = lsp#get_buffer_diagnostics_counts()
  let l:sign = get(g:lsp_diagnostics_signs_warning, 'text', 'W')
  return l:counts.warning == 0 ? '' : printf('%s %d', l:sign, l:counts.warning)
endfunction

function! LightlineLSPErrors() abort
  let l:counts = lsp#get_buffer_diagnostics_counts()
  let l:sign = get(g:lsp_diagnostics_signs_error, 'text', 'E')
  return l:counts.error == 0 ? '' : printf('%s %d', l:sign, l:counts.error)
endfunction

let g:lightline_lsp_signs_ok = "\uf00c "
function! LightlineLSPOk() abort
  let l:counts =  lsp#get_buffer_diagnostics_counts()
  let l:total = l:counts.error + l:counts.warning
  let l:sign = get(g:, 'lightline_lsp_signs_ok', 'O')
  return l:total == 0 ? l:sign : ''
endfunction

augroup LightLineOnLSP
  autocmd!
  autocmd User lsp_diagnostics_updated call lightline#update()
augroup END


" \     [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]



" LanguageClient-Neovim  ----------------------------------

"let g:lightline.component_expand = {
"    \   'linter_errors': 'lightline#languageclient#errors',
"    \   'linter_ok': 'lightline#languageclient#ok',
"    \ }
"
"let g:lightline.component_type = {
"    \   'linter_errors': 'error',
"    \   'linter_ok': 'left',
"    \ }
"
"let g:lightline#languageclient#indicator_ok = "\uf00c "
"let g:lightline#languageclient#indicator_lt = "Linting"
"let g:lightline#languageclient#indicator_fd = "Failed"
"let g:lightline#languageclient#indicator_e = "\uf05e :%d"
"let g:lightline#languageclient#indicator_w = "\uf071 :%d"
"let g:lightline#languageclient#indicator_i = "I:%d"

"function! LSPStatus() abort
"  let l:errors = 0
"  let l:warnings = 0
"  for item in getqflist()
"      if item["type"] == "E"
"          let l:errors += 1
"      else
"          let l:warnings += 1
"      endif
"  endfor
"
"  if l:errors + l:warnings == 0
"    return "\uf00c "
"  else
"    return "\uf05e " . l:errors . " " . "\uf071" . l:warnings
"  endif
"endfunction
