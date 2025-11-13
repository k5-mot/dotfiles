let s:data_dir = g:vim_data_dir
let s:plug_file = expand(s:data_dir . '/autoload/plug.vim')

if g:is_windows
    let &shell = 'pwsh -NoLogo'
    " set noshellslash
    " set shellcmdflag=-c
end

" Install vim-plug if not found
if empty(glob(s:plug_file))
  silent execute '!curl -fLo ' . s:plug_file .
    \ ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

" Load plug.vim if not autoload
if !empty(glob(s:plug_file)) && !exists('g:plugs')
    execute 'source ' .  expand(s:plug_file)
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Specify a directory for plugins
call plug#begin(expand(s:data_dir . '/plugged'))
  " color scheme
  Plug 'sainnhe/sonokai'
"   Plug 'morhetz/gruvbox'
"   Plug 'croaker/mustang-vim'
"   Plug 'nanotech/jellybeans.vim'
"   Plug 'tomasr/molokai'
"   Plug 'dracula/vim'
"   Plug 'arcticicestudio/nord-vim'
"   Plug 'cocopon/iceberg.vim'
  Plug 'joshdick/onedark.vim'
"   Plug 'jacoborus/tender.vim'
"   Plug 'junegunn/seoul256.vim'
"   Plug 'morhetz/gruvbox'
"   Plug 'sainnhe/gruvbox-material'
  Plug 'sonph/onehalf', { 'rtp': 'vim' }
"   Plug 'folke/tokyonight.nvim'
  " Plug 'ghifarit53/tokyonight-vim'

  " syntax highlight
  Plug 'sheerun/vim-polyglot'
  Plug 'vim-scripts/SyntaxRange'

  " status line
  Plug 'itchyny/lightline.vim'

  " status line for tmux
  Plug 'edkolev/tmuxline.vim'

  " IDE
  if has('python3')
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
  endif
  if (800 <= v:version || has('nvim')) && has('timers')
    Plug 'prabirshrestha/asyncomplete.vim'
    if has('lua') || (has('nvim') && has('nvim-0.4'))
      Plug 'prabirshrestha/vim-lsp'
      Plug 'prabirshrestha/asyncomplete-lsp.vim'
      Plug 'mattn/vim-lsp-settings'
      " Plug 'mattn/vim-lsp-icons'
    endif
    if has('python3')
      Plug 'thomasfaingnaert/vim-lsp-snippets'
      Plug 'thomasfaingnaert/vim-lsp-ultisnips'
    endif
  endif

  " filer
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/fern-git-status.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  Plug 'lambdalisue/nerdfont.vim'

  " icons
  Plug 'ryanoasis/vim-devicons'

  " Git
  Plug 'airblade/vim-gitgutter'

  " filetype
  Plug 'lervag/vimtex', { 'for': ['tex'] }
  " Plug 'vhda/verilog_systemverilog.vim'
  Plug 'cespare/vim-toml', { 'for': ['toml'] }
  Plug 'sophacles/vim-processing'

  Plug 'jiangmiao/auto-pairs'
  Plug 'godlygeek/tabular'
  Plug 'preservim/vim-markdown'

  " game
  " Plug 'vim-scripts/TeTrIs.vim'
  " Plug 'PsychoLlama/vim-gol', { 'on': 'GOL' }
  " Plug 'mattn/invader-vim'
  " Plug 'johngrib/vim-game-snake'
call plug#end()

" Check the specified plugin is installed
function s:is_plugged(name)
  if exists('g:plugs') && has_key(g:plugs, a:name) && isdirectory(g:plugs[a:name].dir)
    return 1
  else
    return 0
  endif
endfunction

" Plugin configurtation
if s:is_plugged("lightline.vim")
    execute 'source ' . expand(g:vim_config_dir . '/plugin/lightline.rc.vim')
endif
if s:is_plugged("asyncomplete.vim")
    execute 'source ' . expand(g:vim_config_dir . '/plugin/asyncomplete.rc.vim')
endif
if s:is_plugged("vim-lsp")
    execute 'source ' . expand(g:vim_config_dir . '/plugin/vim-lsp.rc.vim')
endif
if s:is_plugged("tmuxline.vim")
    execute 'source ' . expand(g:vim_config_dir . '/plugin/tmuxline.rc.vim')
endif
if s:is_plugged("vim-lsp-ultisnips")
    execute 'source ' . expand(g:vim_config_dir . '/plugin/vim-lsp-ultisnips.rc.vim')
endif
if s:is_plugged("fern.vim")
    execute 'source ' . expand(g:vim_config_dir . '/plugin/fern.vim.rc.vim')
endif
if s:is_plugged("lightline.vim") && s:is_plugged("vim-lsp")
    execute 'source ' . expand(g:vim_config_dir . '/plugin/lightline_vim-lsp.rc.vim')
endif

if s:is_plugged("sonokai")
    set background=dark
    colorscheme sonokai
else
    set background=dark
    colorscheme retrobox
endif
