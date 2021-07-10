set laststatus=2
set noshowmode

let g:lightline = {}

let g:lightline_color = "default"
"let g:lightline.component = {
"  \ 'mode': '%{lightline#mode()}',
"  \ 'absolutepath': '%F',
"  \ 'relativepath': '%f',
"  \ 'filename': '%t',
"  \ 'modified': '%M',
"  \ 'bufnum': '%n',
"  \ 'paste': '%{&paste?"PASTE":""}',
"  \ 'readonly': '%R',
"  \ 'charvalue': '%b',
"  \ 'charvaluehex': '%B',
"  \ 'fileencoding': '%{strlen(&fenc)?&fenc:&enc}',
"  \ 'fileformat': '%{&fileformat}',
"  \ 'filetype': '%{strlen(&filetype)?&filetype:"no ft"}',
"  \ 'percent': '%3p%%',
"  \ 'percentwin': '%P',
"  \ 'lineinfo': '%3l:%-2v',
"  \ 'line': '%l',
"  \ 'column': '%c',
"  \ 'close': '%999X X '
"  \ }
"
"let g:lightline = {
"  \   'enable': { 'tabline': 1 },
"  \   'colorscheme': g:lightline_color,
"  \   'separator': { 'left': "\ue0b0 ", 'right': " \ue0b2" },
"  \   'subseparator' :{ 'left': "\ue0b1 ", 'right': " \ue0b3" },
"  \   'active': {
"  \     'left': [
"  \       ['mode', 'paste'],
"  \       ['readonly', 'filename', 'modified'],
"  \     ],
"  \     'right': [
"  \       ['lineinfo'],
"  \       ['percent'],
"  \       ['fileformat', 'fileencoding', 'filetype']
"  \     ],
"  \   },
"  \   'inactive': {
"  \     'left': [
"  \       ['filename']
"  \     ],
"  \     'right': [
"  \       ['lineinfo'],
"  \       ['percent']
"  \     ]
"  \   },
"  \ }
"






"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Configs
"
"let s:nerdfont = get(g:, 'nerdfont', 0)
"
"let s:indicator_warnings = get(g:, 'lightline#coc#indicator_warnings', '•')
"let s:indicator_errors = get(g:, 'lightline#coc#indicator_errors', '×')
"let s:indicator_info = get(g:, 'lightline#coc#indicator_info', '~')
"let s:indicator_hints = get(g:, 'lightline#coc#indicator_hints', '>')
"let s:indicator_ok = get(g:, 'lightline#coc#indicator_ok', (s:nerdfont ? "\uf058" : '✓'))
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Lightline components
"
"function! s:cocwarnings() abort
"  if s:isHidden()
"    return ''
"  endif
"
"  let l:counts = s:count('warning')
"  return l:counts == 0 ? '' : printf(s:indicator_warnings . '%d', l:counts)
"endfunction
"
"function! s:cocerrors() abort
"  if s:isHidden()
"    return ''
"  endif
"
"  let l:counts = s:count('error')
"  return l:counts == 0 ? '' : printf(s:indicator_errors . '%d', l:counts)
"endfunction
"
"function! s:cocinfo() abort
"  if s:isHidden()
"    return ''
"  endif
"
"  let l:counts = s:count('information')
"  return l:counts == 0 ? '' : printf(s:indicator_info . '%d', l:counts)
"endfunction
"
"function! s:cochints() abort
"  if s:isHidden()
"    return ''
"  endif
"
"  let l:counts = s:count('hint')
"  return l:counts == 0 ? '' : printf(s:indicator_hints . '%d', l:counts)
"endfunction
"
"function! s:cocok() abort
"  if s:isHidden()
"    return ''
"  endif
"
"  let l:counts = s:countSum()
"  return l:counts == 0 ? s:indicator_ok : ''
"endfunction
"
"function! s:cocstatus()
"  return get(g:, 'coc_status', '')
"endfunction
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Helper functions
"
"function! s:count(level) abort
"  let info = get(b:, 'coc_diagnostic_info', {})
"  return get(info, a:level, 0)
"endfunction
"
"function! s:countSum() abort
"  let info = get(b:, 'coc_diagnostic_info', {})
"  return get(info, 'error', 0) + get(info, 'warning', 0)
"endfunction
"
"function! s:isHidden()
"  return exists('*lightline#sensible#isHidden') && lightline#sensible#isHidden()
"endfunction
"
"function! s:setLightline(scope, name, value) abort
"  let g:lightline = get(g:, 'lightline', {})
"  let g:lightline[a:scope] = get(g:lightline, a:scope, {})
"  let g:lightline[a:scope][a:name] =  get(g:lightline[a:scope], a:name, a:value)
"endfunction
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Register
""let g:lightline_color = "default"
"let g:lightline = {
"  \   'enable': { 'tabline': 1 },
"  \   'colorscheme': g:lightline_color,
"  \   'separator': { 'left': "\ue0b0 ", 'right': " \ue0b2" },
"  \   'subseparator' :{ 'left': "\ue0b1 ", 'right': " \ue0b3" },
"  \   'active': {
"  \     'left': [
"  \       ['mode', 'paste'],
"  \       ['readonly', 'filename', 'modified'],
"  \       ['coc_errors', 'coc_warnings', 'coc_info', 'coc_hints', 'coc_ok' ],
"  \       ['coc_status']
"  \     ],
"  \     'right': [
"  \       ['lineinfo'],
"  \       ['percent'],
"  \       ['fileformat', 'fileencoding', 'filetype']
"  \     ],
"  \   },
"  \   'inactive': {
"  \     'left': [
"  \       ['filename']let g:lightline = {
"  \   'active': {
"  \     left': [[  'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok' ], [ 'coc_status'  ]]
"  \   }
"  \ }

" register compoments:
"call lightline#coc#register()
"  \     ],
"  \     'right': [
"  \       ['lineinfo'],
"  \       ['percent']
"  \     ]
"  \   },
"	\   'component_function': {
"	\     'coc_status' : 'coc#status'
"	\   },
"  \   'component_expand' : {
"  \     'coc_warnings' : 's:cocwarnings',
"  \     'coc_errors'   : 's:cocerrors',
"  \     'coc_info'     : 's:cocinfo',
"  \     'coc_hints'    : 's:cochints',
"  \     'coc_ok'       : 's:cocok',
"  \   },
"  \   'component_type' : {
"  \     'coc_warnings' : 'warning',
"  \     'coc_errors'   : 'error',
"  \     'coc_info'     : 'info',
"  \     'coc_hints'    : 'hint',
"  \     'coc_ok'       : 'left',
"  \   },
"  \ }
""
"autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()









"let g:lightline = {
"  \   'enable': { 'tabline': 1 },
"  \   'colorscheme': g:lightline_color,
"  \   'separator': { 'left': "\ue0b0 ", 'right': " \ue0b2" },
"  \   'subseparator' :{ 'left': "\ue0b1 ", 'right': " \ue0b3" },
"  \   'active': {
"  \     'left': [
"  \       ['mode', 'paste'],
"  \       ['readonly', 'filename', 'modified'],
"  \       ['coc_errors', 'coc_warnings', 'coc_info', 'coc_hints', 'coc_ok' ],
"  \       ['coc_status']
"  \     ],
"  \     'right': [
"  \       ['lineinfo'],
"  \       ['percent'],
"  \       ['fileformat', 'fileencoding', 'filetype']
"  \     ],
"  \   },
"  \   'inactive': {
"  \     'left': [
"  \       ['filename']
"  \     ],
"  \     'right': [
"  \       ['lineinfo'],
"  \       ['percent']
"  \     ]
"  \   },
"	\   'component_function': {
"	\     'coc_status' : 'coc#status'
"	\   },
"  \   'component_expand' : {
"  \     'coc_status'   : 'lightline#coc#status',
"  \     'coc_warnings' : 'lightline#coc#warnings',
"  \     'coc_errors'   : 'lightline#coc#errors',
"  \     'coc_info'     : 'lightline#coc#info',
"  \     'coc_hints'    : 'lightline#coc#hints',
"  \     'coc_ok'       : 'lightline#coc#ok',
"  \   },
"  \   'component_type' : {
"  \     'coc_warnings' : 'warning',
"  \     'coc_errors'   : 'error',
"  \     'coc_info'     : 'info',
"  \     'coc_hints'    : 'hint',
"  \     'coc_ok'       : 'left',
"  \   },
"  \ }
"
"" register compoments:
"call lightline#coc#register()

















"Diagnosticsの、左横のアイコンの色設定
"highlight CocErrorSign ctermfg=15 ctermbg=196
"highlight CocWarningSign ctermfg=0 ctermbg=172

"   \     ['lsp_errors', 'lsp_warnings', 'lsp_ok'],

"  \ 'component_expand': {
"  \   'lsp_warnings': 'LightlineLSPWarnings',
"  \   'lsp_errors':   'LightlineLSPErrors',
"  \   'lsp_ok':       'LightlineLSPOk',
"  \ },
"  \ 'component_type': {
"  \   'lsp_warnings': 'warning',
"  \   'lsp_errors':   'error',
"  \   'lsp_ok':       'normal',
"  \ },

"function! LightlineLSPWarnings() abort
"  let l:counts = lsp#get_buffer_diagnostics_counts()
"  let l:sign = get(g:lsp_diagnostics_signs_warning, 'text', 'W')
"  return l:counts.warning == 0 ? '' : printf('%s %d', l:sign, l:counts.warning)
"endfunction
"
"function! LightlineLSPErrors() abort
"  let l:counts = lsp#get_buffer_diagnostics_counts()
"  let l:sign = get(g:lsp_diagnostics_signs_error, 'text', 'E')
"  return l:counts.error == 0 ? '' : printf('%s %d', l:sign, l:counts.error)
"endfunction
"
"let g:lightline_lsp_signs_ok = "\uf00c "
"function! LightlineLSPOk() abort
"  let l:counts =  lsp#get_buffer_diagnostics_counts()
"  let l:total = l:counts.error + l:counts.warning
"  let l:sign = get(g:, 'lightline_lsp_signs_ok', 'O')
"  return l:total == 0 ? l:sign : ''
"endfunction
"
"augroup LightLineOnLSP
"  autocmd!
"  autocmd User lsp_diagnostics_updated call lightline#update()
"augroup END


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




let g:lightline#coc#indicator_warnings = '•'
let g:lightline#coc#indicator_errors   = '×'
let g:lightline#coc#indicator_info     = '~'
let g:lightline#coc#indicator_hints    = '>'
let g:lightline#coc#indicator_ok       = "\uf058"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configs

let s:nerdfont = get(g:, 'nerdfont', 0)

let s:indicator_warnings = get(g:, 'lightline#coc#indicator_warnings', '•')
let s:indicator_errors = get(g:, 'lightline#coc#indicator_errors', '×')
let s:indicator_info = get(g:, 'lightline#coc#indicator_info', '~')
let s:indicator_hints = get(g:, 'lightline#coc#indicator_hints', '>')
let s:indicator_ok = get(g:, 'lightline#coc#indicator_ok', (s:nerdfont ? "\uf058" : '✓'))

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lightline components

function! Coc_warnings() abort
  if s:isHidden()
    return ''
  endif

  let l:counts = s:count('warning')
  "return l:counts == 0 ? '' : printf(s:indicator_warnings . '%d', l:counts)
  return printf(s:indicator_warnings . '%d', l:counts)
endfunction

function! Coc_errors() abort
  if s:isHidden()
    return ''
  endif

  let l:counts = s:count('error')
  "return l:counts == 0 ? '' : printf(s:indicator_errors . '%d', l:counts)
  return printf(s:indicator_errors . '%d', l:counts)
endfunction

function! Coc_info() abort
  if s:isHidden()
    return ''
  endif

  let l:counts = s:count('information')
  "return l:counts == 0 ? '' : printf(s:indicator_info . '%d', l:counts)
  return printf(s:indicator_info . '%d', l:counts)
endfunction

function! Coc_hints() abort
  if s:isHidden()
    return ''
  endif

  let l:counts = s:count('hint')
  "return l:counts == 0 ? '' : printf(s:indicator_hints . '%d', l:counts)
  return printf(s:indicator_hints . '%d', l:counts)
endfunction

function! Coc_ok() abort
  if s:isHidden()
    return ''
  endif

  let l:counts = s:countSum()
  "return l:counts == 0 ? s:indicator_ok : ''
  return printf(s:indicator_ok . '%d', l:counts)
endfunction

function! Coc_status()
  return get(g:, 'coc_status', '')
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Register

"function! lightline#coc#register() abort
"  call s:setLightline('component_expand', 'coc_status', 'lightline#coc#status')
"  call s:setLightline('component_expand', 'coc_warnings', 'lightline#coc#warnings')
"  call s:setLightline('component_expand', 'coc_errors', 'lightline#coc#errors')
"  call s:setLightline('component_expand', 'coc_info', 'lightline#coc#info')
"  call s:setLightline('component_expand', 'coc_hints', 'lightline#coc#hints')
"  call s:setLightline('component_expand', 'coc_ok', 'lightline#coc#ok')
"
"  call s:setLightline('component_type', 'coc_warnings', 'warning')
"  call s:setLightline('component_type', 'coc_errors', 'error')
"  call s:setLightline('component_type', 'coc_info', 'info')
"  call s:setLightline('component_type', 'coc_hints', 'hint')
"  call s:setLightline('component_type', 'coc_ok', 'left')
"
"  call s:setLightline('component_function', 'coc_status', 'lightline#coc#status')
"endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helper functions

function! s:count(level) abort
  let info = get(b:, 'coc_diagnostic_info', {})
  return get(info, a:level, 0)
endfunction

function! s:countSum() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  return get(info, 'error', 0) + get(info, 'warning', 0)
endfunction

function! s:isHidden()
  return exists('*lightline#sensible#isHidden') && lightline#sensible#isHidden()
endfunction

"function! s:setLightline(scope, name, value) abort
"  let g:lightline = get(g:, 'lightline', {})
"  let g:lightline[a:scope] = get(g:lightline, a:scope, {})
"  let g:lightline[a:scope][a:name] =  get(g:lightline[a:scope], a:name, a:value)
"endfunction


"augroup lightline#coc
"  autocmd!
"  autocmd User CocDiagnosticChange call lightline#update()
"  autocmd User CocStatusChange call lightline#update()
"augroup END

let g:lightline = {
  \   'enable': { 'tabline': 1 },
  \   'colorscheme': g:lightline_color,
  \   'separator': { 'left': "\ue0b0 ", 'right': " \ue0b2" },
  \   'subseparator' :{ 'left': "\ue0b1 ", 'right': " \ue0b3" },
	\   'component_expand': {
	\     'coc_status'   : 'Coc_status',
  \     'coc_warnings' : 'Coc_warnings',
  \     'coc_errors'   : 'Coc_errors',
  \     'coc_info'     : 'Coc_info',
  \     'coc_hints'    : 'Coc_hints',
  \     'coc_ok'       : 'Coc_ok',
	\   },
  \   'component_type' : {
  \     'coc_warnings' : 'warning',
  \     'coc_errors'   : 'error',
  \     'coc_info'     : 'info',
  \     'coc_hints'    : 'hint',
  \     'coc_ok'       : 'left',
  \   },
  \   'active': {
  \     'left': [
  \       ['mode', 'paste'],
  \       ['readonly', 'filename', 'modified'],
  \       ['coc_errors', 'coc_warnings', 'coc_info', 'coc_hints', 'coc_ok' ],
  \       ['coc_status']
  \     ],
  \     'right': [
  \       ['lineinfo'],
  \       ['percent'],
  \       ['fileformat', 'fileencoding', 'filetype']
  \     ],
  \   },
  \   'inactive': {
  \     'left': [
  \       ['filename']
  \     ],
  \     'right': [
  \       ['lineinfo'],
  \       ['percent']
  \     ]
  \   },
  \ }


"  \   'component_expand' : {
"  \     'coc_status'   : 's:coc_status',
"  \     'coc_warnings' : 's:coc_warnings',
"  \     'coc_errors'   : 's:coc_errors',
"  \     'coc_info'     : 's:coc_info',
"  \     'coc_hints'    : 's:coc_hints',
"  \     'coc_ok'       : 's:coc_ok',
"  \   },

"let g:lightline = {
"  \   'active': {
"  \     left': [[  'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok' ], [ 'coc_status'  ]]
"  \   }
"  \ }

" register compoments:
"call lightline#coc#register()
augroup lightline#coc
  autocmd!
  autocmd User CocDiagnosticChange call lightline#update()
  autocmd User CocStatusChange call lightline#update()
augroup END

