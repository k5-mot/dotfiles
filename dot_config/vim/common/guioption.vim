
if has('gui_running')
    set guioptions-=a
    set guioptions-=i
    set guioptions-=r
    set guioptions-=L
    set guioptions-=e
    set guioptions-=m " メニューバーを非表示
    set guioptions+=M
    set guioptions-=t
    set guioptions-=T " ツールバーを非表示
    set guioptions-=g
    set guioptions+=c
    " set guioptions+=R " 右スクロールバーを非表示

    set guicursor+=c:ver10 " カーソル外観

    if g:is_windows
        set renderoptions=type:directx,renmode:5
        set guifont=CascaydiaCove_NFM:h13.5:cSHIFTJIS,MS_Gothic:h13
    elseif g:is_mac
        set guifont=CascaydiaCove\ NFM:h17
        set macmeta
        set transparency=10
    endif
else
    let &t_ti .= "\e[1 q"
    let &t_SI .= "\e[5 q"
    let &t_EI .= "\e[1 q"
    let &t_te .= "\e[0 q"

    " set termguicolors
    " set t_Co=256
    " let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " 文字色
    " let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " 背景色
endif
