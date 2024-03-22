
if !has('gui_running')
    let &t_ti .= "\e[1 q"
    let &t_SI .= "\e[5 q"
    let &t_EI .= "\e[1 q"
    let &t_te .= "\e[0 q"

    set termguicolors
    " set t_Co=256
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " 文字色
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " 背景色
endif
