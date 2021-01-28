let g:ale_sign_column_always = 1
"let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_text_changed = 0
let g:ale_sign_warning = "\uf071"
let g:ale_sign_error = "\uf05e"
"let g:ale_sign_warning = "!!"
"let g:ale_sign_error = "=="
"highlight clear ALEErrorSign
"highlight clear ALEWarningSign
let g:ale_echo_msg_format = '[%linter%]%code: %%s'
"highlight link ALEErrorSign Tag
"highlight link ALEWarningSign StorageClass
" Ctrl + kで次の指摘へ、Ctrl + jで前の指摘へ移動
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let b:ale_linters = {
    \   'javascript': ['eslint', 'eslint-plugin-vue'],
    \   'python': ['pyflakes', 'pep8'],
    \   'ruby': ['rubocop'],
    \   'tex': ['textlint'],
    \   'markdown': ['textlint'],
    \   'css': ['stylelint'],
    \}
"let g:ale_statusline_format = ['E%d', 'W%d', 'ok']
"let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1
"nmap <silent> <C-n> <Plug>(ale_next_wrap)

"let g:ale_linters = {
"      \'php': ['phpcs', 'php']
"      \}
"
"let g:ale_fixers = {
"      \'php': ['phpcbf']
"      \}
"
"let g:ale_php_phpcs_standard = 'psr1,psr2'
"let g:ale_php_phpcbf_executable = 'phpcbf'
"let g:ale_php_phpcbf_standard = 'psr1,psr2'

"nnoremap [Ale] <Nop>
"nmap <Leader>a [Ale]
"nmap <silent> [Ale]fx <Plug>(ale_fix)
" マップ先が決まらない問題
"nmap <silent> <C-> <Plug>(ale_previous)
"nmap <silent> <C-> <Plug>(ale_next)
