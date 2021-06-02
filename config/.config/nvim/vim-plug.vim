
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
"let data_dir = has('nvim') ? '~/.cache/nvim' : '~/.cache/vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  " Install vim-plug if not found
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  " Run PlugInstall if there are missing plugins
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
"call plug#begin('~/.vim/plugged')
call plug#begin(data_dir . 'plugged')

Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'


" Initialize plugin system
call plug#end()

source ./plugins/lightline.rc.vim


