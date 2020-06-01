" ====================
" fold
" ====================
set foldmethod=marker
set foldmarker=#if,#endif

" ====================
" make
" ====================
set makeprg=python\ -m\ firmware_checker.bin.check_modified\ --format\ VIM\ --rules\ none\ --include\ X01

" ====================
" custom command
" ====================
" run with ":!" to start execution
"ab dox python -m doxygen.doc_search <cword> %

" search for document
function! DoxLookup()
    if has("unix")
        ! python -m doxygen.doc_search <cword> %
    else
        !start python -m doxygen.doc_search <cword> %
    endif
endfunction

" search for register
function! RegisterLookup()
    if has("unix")
        ! python -m editor_tool.reg_lookup <cword> --target-file %
    else
        !start python -m editor_tool.reg_lookup <cword> --target-file %
    endif
endfunction

nnoremap <A-`> :call RegisterLookup()<CR>

" search for call tree
function! CallTreeLookup()
    if has("unix")
        ! python -m editor_tool.graph_gen <cword> %
    else
        !start python -m editor_tool.graph_gen <cword> %
    endif
endfunction

nnoremap <A-'> :call CallTreeLookup()<CR>

" build current file
ab c51 ! python -m build_tool.auto_link.uv2.uv2build --skip-pch --file % auto all

nnoremap <C-F7> :Gtags -g 

" gun global
" use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
set cscopetag

" use gnu global as cscope
set cscopeprg="gtags-cscope"
let g:GtagsCscope_Auto_Map = 1
let g:GtagsCscope_Auto_Load = 1

"   's'   symbol: find all references to the token under cursor
nnoremap <C-\> :exec("Gtags -r ".expand("<cword>"))<cr>

ab gg Gtags -g 

" ====================
" taghighlight color setting
"   - run with ":UpdateTypesFile"
" ====================
hi CTagsGlobalVariable guifg=#8080FF ctermfg=63
hi CTagsFunction guifg=green ctermfg=green
hi CTagsDefinedName guifg=#FF8000 ctermfg=208
hi CTagsEnumerationValue gui=bold term=bold guifg=white ctermfg=white
hi CTagsMember gui=bold term=bold guifg=white ctermfg=white
hi CTagsType gui=bold term=bold guifg=cyan ctermfg=cyan
hi CCommentL guifg=gray48 ctermfg=241
hi CComment guifg=gray48 ctermfg=241
hi cRepeat guifg=red ctermfg=red
hi cPreCondit guifg=red ctermfg=red
hi cPreConditMatch guifg=red ctermfg=red
hi cConditional guifg=red ctermfg=red
hi cLabel guifg=red ctermfg=red
hi cStructure guifg=red ctermfg=red
hi cStatement guifg=red ctermfg=red
hi cNumber guifg=red ctermfg=red
hi cFloat guifg=red ctermfg=red
hi cIncluded guifg=yellow ctermfg=yellow
hi cString guifg=yellow ctermfg=yellow
hi cDefine guifg=yellow ctermfg=yellow

