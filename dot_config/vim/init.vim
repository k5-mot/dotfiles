
" Init {{{
if 0 | endif
set encoding=utf-8
scriptencoding utf-8

if &compatible
  set nocompatible
endif

let g:is_windows = has('win16') || has('win32') || has('win64')
let g:is_mac = has('mac')

augroup MyAugroup
  autocmd!
augroup END
" }}}


" Environment {{{
if g:is_windows
    set shellslash
endif

let g:vim_config_dir = expand('$HOME/.config/vim')
let g:vim_cache_dir  = expand('$HOME/.cache/vim')
let g:vim_state_dir  = expand('$HOME/.local/state/vim')
let g:vim_data_dir   = expand('$HOME/.local/share/vim')
let g:vim_plugin_dir = expand(g:vim_config_dir . '/plugins')
let g:viminfo        = expand(g:vim_cache_dir . '/viminfo')
let g:backup_dir     = expand(g:vim_cache_dir . '/backup')
let g:swap_dir       = expand(g:vim_cache_dir . '/swap')
let g:undo_dir       = expand(g:vim_cache_dir . '/undo')
let g:view_dir       = expand(g:vim_cache_dir . '/view')
let g:local_vimrc    = expand('$HOME/.vimrc_local')
" }}}


" Setup {{{
function! s:makedir(dirname) abort
    if !isdirectory(a:dirname)
        call mkdir(a:dirname, 'p')
    endif
endfunction

call s:makedir(g:vim_cache_dir)
call s:makedir(g:vim_state_dir)
call s:makedir(g:vim_data_dir)
call s:makedir(g:backup_dir)
call s:makedir(g:swap_dir)
call s:makedir(g:undo_dir)
call s:makedir(g:view_dir)
" }}}


" Common {{{
execute 'source ' .  expand(g:vim_config_dir . '/common/guioption.vim')
execute 'source ' .  expand(g:vim_config_dir . '/common/option.vim')
execute 'source ' .  expand(g:vim_config_dir . '/common/cache.vim')
execute 'source ' .  expand(g:vim_config_dir . '/common/keymap.vim')
execute 'source ' .  expand(g:vim_config_dir . '/common/func.vim')
execute 'source ' .  expand(g:vim_config_dir . '/plug.vim')
" }}}


" Local Settings {{{
if filereadable(g:local_vimrc)
  execute 'source' g:local_vimrc
endif
" }}}
