
" Backup {{{
" バックアップファイル作成
set backup
" バックアップディレクトリ
execute 'set backupdir=' . g:backup_dir
" バックアップファイルの拡張子
set backupext=.backup
" }}}

" Swap {{{
" スワップファイル作成
set swapfile
" スワップファイルの保存先
execute 'set directory=' . g:swap_dir
" スワップファイル保存の間隔[ミリ秒]
set updatetime=30000
" スワップファイル保存の文字数
set updatecount=500
" }}}

" Command History {{{
" コマンド履歴の保存上限数
set history=10000
" アンドゥファイル生成
set undofile
" アンドゥファイルの保存先
execute 'set undodir=' . g:undo_dir
" }}}

" View (折り畳みの保存/復元) {{{
set viewoptions-=options
execute 'set viewdir=' . g:view_dir
" }}}

" Viminfo {{{
execute 'set viminfo+=n' . g:viminfo
" }}}
