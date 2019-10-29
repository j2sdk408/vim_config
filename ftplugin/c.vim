" ====================
" fold
" ====================
set foldmethod=marker
set foldmarker=#if,#endif

" ====================
" custom command
" ====================
" run with ":!" to start execution
"ab dox python ../Tool/doxygen/doc_search.py <cword> %

" search for document
function! DoxLookup()
    if has("unix")
        ! python ../Tool/doxygen/doc_search.py <cword> %
    else
        !start python ../Tool/doxygen/doc_search.py <cword> %
    endif
endfunction

" search for register
function! RegisterLookup()
    if has("unix")
        ! python ../Tool/db/reg_lookup.py <cword> --target-file %
    else
        !start python ../Tool/db/reg_lookup.py <cword> --target-file %
    endif
endfunction

nnoremap <A-`> :call RegisterLookup()<CR>

" search for call tree
function! CallTreeLookup()
    if has("unix")
        ! python ../Tool/call_graph/graph_gen.py <cword> %
    else
        !start python ../Tool/call_graph/graph_gen.py <cword> %
    endif
endfunction

nnoremap <A-'> :call CallTreeLookup()<CR>

" build current file
ab c51 ! python ../Tool/auto_link/uv2/uv2build.py --skip-pch --file % auto all

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
hi CTagsGlobalVariable guifg=#8080FF
hi CTagsFunction guifg=green
hi CTagsDefinedName guifg=#FF8000
hi CTagsEnumerationValue gui=bold term=bold guifg=white
hi CTagsMember gui=bold term=bold guifg=white
hi CTagsType gui=bold term=bold guifg=cyan
hi CCommentL guifg=gray48
hi CComment guifg=gray48
hi cRepeat guifg=red
hi cPreCondit guifg=red
hi cPreConditMatch guifg=red
hi cConditional guifg=red
hi cLabel guifg=red
hi cStructure guifg=red
hi cStatement guifg=red
hi cNumber guifg=red
hi cFloat guifg=red
hi cIncluded guifg=yellow
hi cString guifg=yellow
hi cDefine guifg=yellow

