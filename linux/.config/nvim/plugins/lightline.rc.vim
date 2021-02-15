set laststatus=2
set noshowmode

let g:lightline_color = 'seoul256'


let g:lightline = {
  \ 'enable': { 'tabline': 1 },
  \ 'colorscheme': g:lightline_color,
  \ 'separator': { 'left': "\ue0b0 ", 'right': " \ue0b2" },
  \ 'subseparator' :{ 'left': "\ue0b1 ", 'right': " \ue0b3" },
  \ 'active': {
  \   'left': [
  \     ['mode', 'paste'],
  \     ['readonly', 'filename', 'modified'],
  \     [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
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
\ }


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
