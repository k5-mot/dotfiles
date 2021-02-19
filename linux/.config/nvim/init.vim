if &compatible
  set nocompatible
endif

augroup MyAutoCmd
  autocmd!
augroup END

"" PATHの自動更新関数
"" | 指定された path が $PATH に存在せず、ディレクトリとして存在している場合
"" | のみ $PATH に加える
"function! IncludePath(path)
"  " define delimiter depends on platform
"  if has('win16') || has('win32') || has('win64')
"    let delimiter = ";"
"  else
"    let delimiter = ":"
"  endif
"  let pathlist = split($PATH, delimiter)
"  if isdirectory(a:path) && index(pathlist, a:path) == -1
"    let $PATH=a:path.delimiter.$PATH
"  endif
"endfunction
"
"" ~/.pyenv/shims を $PATH に追加する
"" これを行わないとpythonが正しく検索されない
"IncludePath(expand("~/.anyenv/envs/pyenv/shims"))

let $CACHE = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let $DATA = empty($XDG_DATA_HOME) ? expand('$HOME/.local/share') : $XDG_DATA_HOME

if !has('nvim')
  let &t_TI = ""
  let &t_TE = ""
endif

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

if has('nvim')
  let s:dein_cache_path = expand('$HOME/.cache/nvim/dein')
else
  let s:dein_cache_path = expand('$HOME/.cache/vim/dein')
endif

let s:dein_dir = s:dein_cache_path
      \ .'/repos/github.com/Shougo/dein.vim'

if &runtimepath !~ '/dein.vim'
  if !isdirectory(s:dein_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
  endif
  execute 'set runtimepath+=' . fnamemodify(s:dein_dir, ':p')
endif

" runtimepathの設定
set runtimepath+=~/.config/nvim/
set runtimepath+=~/.config/nvim/plugins

if dein#load_state(s:dein_cache_path)
  call dein#begin(s:dein_cache_path)

  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy' : 0})
  call dein#load_toml('~/.config/nvim/deinlazy.toml', {'lazy' : 1})
  call dein#load_toml('~/.config/nvim/deinft.toml')

  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
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

" Set up external provider
"if has('nvim')
  let g:python3_host_prog = $HOME . '/.anyenv/envs/pyenv/versions/3.9.1/bin/python'
  let g:python_host_prog  = $HOME . '/.anyenv/envs/pyenv/versions/2.7.18/bin/python'
  let g:ruby_host_prog    = $HOME . '/.anyenv/envs/rbenv/versions/3.0.0/bin/neovim-ruby-host'
  let g:node_host_prog    = $HOME . '/.anyenv/envs/nodenv/versions/15.6.0/bin/neovim-node-host'
  "let g:python3_host_prog = $HOME . '/.pyenv/versions/3.8.5/bin/python'
  "let g:python_host_prog  = $HOME . '/.pyenv/versions/2.7.18/bin/python'
  "let g:ruby_host_prog    = $HOME . '/.rbenv/versions/3.0.0/bin/neovim-ruby-host'
  "let g:node_host_prog    = $HOME . '/.nodenv/versions/15.5.0/bin/neovim-node-host'
"endif

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
