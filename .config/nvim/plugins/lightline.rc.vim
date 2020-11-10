let g:lightline = {
      \ 'colorscheme': g:lightline_color,
      \ 'mode_map': {'c': 'NORMAL'},
      \ 'active': {
      \   'left': [
      \     ['mode', 'paste'],
      \     ['readonly', 'fugitive', 'gitgutter', 'filename', 'modified'],
      \     ['anzu']
      \   ],
      \   'right':[
      "\     ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok'],
      \     ['lineinfo'],
      \     ['percent'],
      \     ['fileformat', 'fileencoding', 'filetype']
      \   ]
      \ },
      \ 'component_function': {
      \   'readonly': 'LlReadonly',
      \   'modified': 'LlModified',
      \   'fugitive': 'LlFugitive',
      \   'filename': 'LlFilename',
      \   'fileformat': 'LlFileformat',
      \   'filetype': 'LlFiletype',
      \   'fileencoding': 'LlFileencoding',
      \   'mode': 'LlMode',
      \   'anzu': 'anzu#search_status',
      \   'gitgutter': 'LlGitGutter'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '»', 'right': '«' }
      \ }

function! LlModified()
  return &filetype =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LlReadonly()
  "  U+f542
  return &filetype !~? 'help' && &readonly ? "\uf542" : ''
endfunction

function! LlFilename()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo' ? '' :
        \ &filetype == 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype == 'unite' ? unite#get_status_string() :
        \ &filetype == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != fname ? fname : '[No Name]')
endfunction

function! LlFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo' && &filetype !~? 'vimfiler' && exists('*fugitive#head')
      "  u+e725
      let mark = "\ue0a0"
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LlFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LlFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LlFileencoding()
  return winwidth(0) > 70 ? (strlen(&fileencoding) ? &fileencoding : &encoding) : ''
endfunction

function! LlMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ &filetype == 'unite' ? 'Unite' :
        \ &filetype == 'vimfiler' ? 'VimFiler' :
        \ &filetype == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LlGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . '',
        \ g:gitgutter_sign_modified . '',
        \ g:gitgutter_sign_removed . ''
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

" 他プラグインのステータスライン上書き
let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
