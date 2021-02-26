if &compatible
  set nocompatible
endif

augroup MyAutoCmd
  autocmd!
augroup END

augroup vimrc
  autocmd!
augroup END

let $CACHE = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let $DATA = empty($XDG_DATA_HOME) ? expand('$HOME/.local/share') : $XDG_DATA_HOME

if !has('nvim')
  let &t_TI = ""
  let &t_TE = ""
endif

set vb t_vb=
set belloff=all

" キーマップリーダーを最初に定義
let mapleader = ','

" True Color対応
if has('nvim')
  " For Neovim 0.1.3 and 0.1.4
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1

  " Or if you have Neovim >= 0.1.5
  if (has("termguicolors"))
    set termguicolors
  endif
elseif has('patch-7.4.1778')
  "set guicolors
elseif !has('gui_running')
  set t_Co=256
endif

" Set up external provider
"if has('nvim')
if !isdirectory('$HOME/.anyenv/envs/pyenv')
  let g:python3_host_prog = $HOME . '/.anyenv/envs/pyenv/versions/3.9.2/bin/python'
  let g:python_host_prog  = $HOME . '/.anyenv/envs/pyenv/versions/2.7.18/bin/python'
endif
if !isdirectory('$HOME/.anyenv/envs/rbenv')
  let g:ruby_host_prog    = $HOME . '/.anyenv/envs/rbenv/versions/3.0.0/bin/neovim-ruby-host'
endif
if !isdirectory('$HOME/.anyenv/envs/nodenv')
  let g:node_host_prog    = $HOME . '/.anyenv/envs/nodenv/versions/15.10.0/bin/neovim-node-host'
endif
if !isdirectory('$HOME/.anyenv/envs/plenv')
  let g:perl_host_prog    = $HOME . '/.anyenv/envs/nodenv/versions/5.32.1/bin'
endif
"let g:perl_host_prog    = $HOME . '/.anyenv/envs/nodenv/versions/15.6.0/bin/neovim-node-host'
"let g:python3_host_prog = $HOME . '/.pyenv/versions/3.8.5/bin/python'
"let g:python_host_prog  = $HOME . '/.pyenv/versions/2.7.18/bin/python'
"let g:ruby_host_prog    = $HOME . '/.rbenv/versions/3.0.0/bin/neovim-ruby-host'
"let g:node_host_prog    = $HOME . '/.nodenv/versions/15.5.0/bin/neovim-node-host'
"endif

"if has('nvim')
  let s:dein_cache_path = expand('$HOME/.cache/nvim/dein')
"else
"  let s:dein_cache_path = expand('$HOME/.cache/vim/dein')
"endif

let s:dein_dir = s:dein_cache_path .'/repos/github.com/Shougo/dein.vim'

if &runtimepath !~ '/dein.vim'
  if !isdirectory(s:dein_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
  endif
  execute 'set runtimepath+=' . fnamemodify(s:dein_dir, ':p')
endif

" runtimepathの設定
let s:settings_config_dir = expand('~/.config/nvim')
let s:settings_plugin_dir = expand(s:settings_config_dir . '/plugins')
let s:settings_data_dir = expand(s:settings_config_dir . '/data')
set runtimepath+=s:settings_config_dir
set runtimepath+=s:settings_plugin_dir
set runtimepath+=s:settings_data_dir


if dein#load_state(s:dein_cache_path)
  call dein#begin(s:dein_cache_path)

  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#load_toml('$HOME/.config/nvim/dein.toml', {'lazy' : 0})
  call dein#load_toml('$HOME/.config/nvim/deinlazy.toml', {'lazy' : 1})
  call dein#load_toml('$HOME/.config/nvim/deinft.toml')

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif

filetype plugin indent on
syntax enable


augroup TransparentBG
  autocmd!
  autocmd Colorscheme * highlight Normal ctermbg=none
	autocmd Colorscheme * highlight NonText ctermbg=none
	autocmd Colorscheme * highlight LineNr ctermbg=none
	autocmd Colorscheme * highlight Folded ctermbg=none
	autocmd Colorscheme * highlight EndOfBuffer ctermbg=none
augroup END
set background=dark
colorscheme gruvbox
"colorscheme iceberg
"colorscheme molokai
"colorscheme tender


"colorscheme gruvbox  "example
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE
highlight Folded ctermbg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guibg=NONE



" Base
runtime! ./basis.rc.vim

" Functions
runtime! ./functions.rc.vim

" Keymapping
runtime! ./keymaps.rc.vim

" Load local settings.
if filereadable(expand('$HOME/.vimrc_local'))
  source $HOME/.vimrc_local
endif

" プロジェクト設定
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc_local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction
