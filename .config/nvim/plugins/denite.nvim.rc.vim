nnoremap [denite] <Nop>
nmap <Leader>u [denite]

" test
nnoremap <silent> [denite]t :<C-u>Denite -expand buffer file/rec<CR>

" buffer
nnoremap <silent> [denite]b :<C-u>Denite buffer<CR>

" file_rec
nnoremap <silent> [denite]f :<C-u>Denite file/rec<CR>
nnoremap <silent> [denite]vf :<C-u>Denite -resume file/rec<CR>

" file_mru
nnoremap <silent> [denite]m :<C-u>Denite file_mru<CR>

" directory_mru
nnoremap <silent> [denite]d :<C-u>Denite directory_mru<CR>

" grep
nnoremap <silent> [denite]g :<C-u>Denite grep:.<CR>
" カーソル位置の単語からgrep
nnoremap <silent> [denite]cg :<C-u>DeniteCursorWord grep:.<CR>
" grep検索結果を再呼び出し
nnoremap <silent> [denite]vg :<C-u>Denite -resume grep<CR>

" register
nnoremap <silent> [denite]r :<C-u>Denite register<CR>

" yankround
"nnoremap <silent> [denite]y :<C-u>Denite yankround<CR>

"" unite-tag
"let g:unite_source_tag_max_name_length = 30
"let g:unite_source_tag_max_fname_length = 40
"nnoremap <silent> [unite]t :<C-u>UniteWithCursorWord -buffer-name=tag tag tag/include<CR>
"" t: tags-and-searches
"" The prefix key.
"nnoremap    [Tag]   <Nop>
"nmap    t [Tag]
"" Jump.
"" nnoremap [Tag]t  <C-]>
"nnoremap <silent><expr> [Tag]t  &filetype == 'help' ?  "\<C-]>" :
"      \ ":\<C-u>UniteWithCursorWord -buffer-name=tag tag tag/include\<CR>"
"nnoremap <silent><expr> [Tag]p  &filetype == 'help' ?
"      \ ":\<C-u>pop\<CR>" : ":\<C-u>Unite jump\<CR>"
"
"" Tab jump
"for n in range(1, 9)
"  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
"endfor
"
"" 起動時にインサートモードで開始
"let g:unite_enable_start_insert = 1
"
"" 大文字小文字を区別しない
"let g:unite_enable_ignore_case = 1
"let g:unite_enable_smart_case = 1
"let g:unite_source_grep_encoding = 'utf-8'
"
""時間のフォーマット
"let g:unite_source_buffer_time_format = '(%Y.%m.%d %H:%M:%S) '
"
"" history/yankの有効化
"let g:unite_source_history_yank_enable = 1

"" neomru
let g:neomru#time_format        = '%Y.%m.%d %H:%M:%S'
let g:neomru#filename_format    = ':~:.'
let g:neomru#file_mru_limit     = 1000

""" unite-quickfix
"let g:unite_quickfix_is_multiline = 1
"let g:unite_quickfix_filename_is_pathshorten = 0
