"
" NeoVim Configurations
"   init.vim
"

" Create directory.
echo system('mkdir -pv ~/.cache/nvim/swap')
echo system('mkdir -pv ~/.cache/nvim/backup')
echo system('mkdir -pv ~/.cache/nvim/undodir')
echo system('mkdir -pv ~/.cache/vim/swap')
echo system('mkdir -pv ~/.cache/vim/backup')
echo system('mkdir -pv ~/.cache/vim/undodir')

" Set environment variables.
let $XDG_CACHE_HOME = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let $XDG_CONFIG_HOME = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let $XDG_DATA_HOME = empty($XDG_DATA_HOME) ? expand('$HOME/.local/share') : $XDG_DATA_HOME
if has('nvim')
  let $VIM_CACHE_HOME = $XDG_CACHE_HOME . '/nvim'
  let $VIM_CONFIG_HOME = $XDG_CONFIG_HOME . '/nvim'
else
  let $VIM_CACHE_HOME = $XDG_CACHE_HOME . '/vim'
  let $VIM_CONFIG_HOME = $XDG_CONFIG_HOME . '/nvim'
endif
let $VIM_PLUGIN_HOME = $VIM_CONFIG_HOME . '/plugins'
let $VIM_DATA_HOME = $VIM_CONFIG_HOME . '/datas'

" Set up runtimepath.
set runtimepath+=$VIM_CONFIG_HOME
set runtimepath+=$VIM_PLUGIN_HOME
set runtimepath+=$VIM_DATA_HOME

" Define Keymap Leader <Leader>
let mapleader = ','

" True Color
if has('nvim')
  " For Neovim 0.1.3 and 0.1.4
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  " Or if you have Neovim >= 0.1.5
  if (has("termguicolors"))
    set termguicolors
  endif
elseif !has('gui_running')
  set t_Co=256
endif
" GVim
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " 文字色
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " 背景色

" Neovim Features
"if !isdirectory('$HOME/.anyenv/envs/pyenv')
"  let s:pyenv_python3_version = system('pyenv versions | grep -e "3\.[0-9]*\.[0-9]*" | tail -1 | sed "s/([^)]*)//g" | sed "s/[ \t*]//g" | sed -z "s/\n//g"')
"  let s:pyenv_python_version = system('pyenv versions | grep -e "2\.[0-9]*\.[0-9]*" | tail -1 | sed "s/([^)]*)//g" | sed "s/[ \t*]//g" | sed -z "s/\n//g"')
"  let g:python3_host_prog = $HOME . '/.anyenv/envs/pyenv/versions/' . s:pyenv_python3_version . '/bin/python'
"  let g:python_host_prog  = $HOME . '/.anyenv/envs/pyenv/versions/' . s:pyenv_python_version . '/bin/python'
"endif
"if !isdirectory('$HOME/.anyenv/envs/rbenv')
"  let s:rbenv_ruby_version = system('rbenv versions | grep -e "[0-9]*\.[0-9]*\.[0-9]*" | tail -1 | sed "s/([^)]*)//g" | sed "s/[ \t*]//g" | sed -z "s/\n//g"')
"  let g:ruby_host_prog    = $HOME . '/.anyenv/envs/rbenv/versions/' . s:rbenv_ruby_version . '/bin/neovim-ruby-host'
"endif
"if !isdirectory('$HOME/.anyenv/envs/nodenv')
"  let s:nodenv_nodejs_version = system('nodenv versions | grep -e "[0-9]*\.[0-9]*\.[0-9]*" | tail -1 | sed "s/([^)]*)//g" | sed "s/[ \t*]//g" | sed -z "s/\n//g"')
"  let g:node_host_prog    = $HOME . '/.anyenv/envs/nodenv/versions/' . s:nodenv_nodejs_version . '/bin/neovim-node-host'
"endif
"if !isdirectory('$HOME/.anyenv/envs/plenv')
"  let s:plenv_perl_version = system('plenv versions | grep -e "[0-9]*\.[0-9]*\.[0-9]*" | tail -1 | sed "s/([^)]*)//g" | sed "s/[ \t*]//g" | sed -z "s/\n//g"')
"  let g:perl_host_prog    = $HOME . '/.anyenv/envs/nodenv/versions/' . s:plenv_perl_version . '/bin'
"endif

" Plugin Manager
if (800 <= v:version)
  runtime! ./dein.vim
else
  runtime! ./vim-plug.vim
endif

" Powerline
"set pythonthreedll=$HOME/.local/usr/lib/libpython3.9.a
"if !isdirectory('$HOME/.local/usr/lib/python3.9/site-packages/powerline')
"  let g:powerline_pycmd="python3"
"  set runtimepath+=$HOME/.local/usr/lib/python3.9/site-packages/powerline/bindings/vim
"  python3 from powerline.vim import setup as powerline_setup
"  python3 powerline_setup()
"  python3 del powerline_setup
"  set laststatus=2
"  set showtabline=2
"  set noshowmode
"  "runtime! ./powerline.vim
"endif

" Base
runtime! ./basis.rc.vim

" Functions
runtime! ./functions.rc.vim

" Keybindings
runtime! ./keybindings.rc.vim

" Load local settings.
if filereadable(expand('$HOME/.vimrc_local'))
  source $HOME/.vimrc_local
endif

set background=dark
colorscheme gruvbox
"colorscheme iceberg
"colorscheme molokai
"colorscheme tender

