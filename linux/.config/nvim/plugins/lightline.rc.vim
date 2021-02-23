set laststatus=2
set noshowmode

let g:lightline_color = "default"

let g:lightline = {
  \ 'enable': { 'tabline': 1 },
  \ 'colorscheme': g:lightline_color,
  \ 'separator': { 'left': "\ue0b0 ", 'right': " \ue0b2" },
  \ 'subseparator' :{ 'left': "\ue0b1 ", 'right': " \ue0b3" },
  \ 'active': {
  \   'left': [
  \     ['mode', 'paste'],
  \     ['readonly', 'filename', 'modified'],
  \     [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]
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
  \ 'component_function': {
  \   'lsp': 'LSPStatus',
  \ },
\ }

let g:lightline.component_expand = {
    \   'linter_errors': 'lightline#languageclient#errors',
    \   'linter_ok': 'lightline#languageclient#ok',
    \ }

let g:lightline.component_type = {
    \   'linter_errors': 'error',
    \   'linter_ok': 'left',
    \ }

let g:lightline#languageclient#indicator_ok = "\uf00c "
let g:lightline#languageclient#indicator_lt = "Linting"
let g:lightline#languageclient#indicator_fd = "Failed"
let g:lightline#languageclient#indicator_e = "\uf05e :%d"
let g:lightline#languageclient#indicator_w = "\uf071 :%d"
let g:lightline#languageclient#indicator_i = "I:%d"

function! LSPStatus() abort
  let l:errors = 0
  let l:warnings = 0
  for item in getqflist()
      if item["type"] == "E"
          let l:errors += 1
      else
          let l:warnings += 1
      endif
  endfor

  if l:errors + l:warnings == 0
    return "\uf00c "
  else
    return "\uf05e " . l:errors . " " . "\uf071" . l:warnings
  endif
endfunction


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
