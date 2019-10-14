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
ab c51 ! python ../Tool/auto_link/uv2/uv2build.py --file % --skip-pch 

" ====================
" cscope: searching projects with better indexing?
"   - run with "cscope -Rbqk" in root directory
" ====================
set cscopetag
set csto=0

set nocscopeverbose 
if filereadable("cscope.out")
   cs add cscope.out   
elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
endif
set cscopeverbose


" find usage + definition
nmap zs :cs find s <C-R>=expand("<cword>")<CR><CR>

" fine definition
nmap zg :cs find g <C-R>=expand("<cword>")<CR><CR>

" find usagee
nmap zc :cs find c <C-R>=expand("<cword>")<CR><CR>

" find string
nmap zt :cs find t <C-R>=expand("<cword>")<CR><CR>

" egrep?
nmap ze :cs find e <C-R>=expand("<cword>")<CR><CR>

" fine name used by cword
nmap zd :cs find d <C-R>=expand("<cword>")<CR><CR>

" find file
nmap zf :cs find f <C-R>=expand("<cfile>")<CR><CR>

" find include
nmap zi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>


" ====================
" taghighlight color setting
"   - run with ":UpdateTypesFile"
" ====================
hi CTagsGlobalVariable guifg=#8080FF
hi CTagsFunction guifg=green
hi CTagsDefinedName guifg=#FF8000
hi CTagsEnumerationValue term=bold guifg=white
hi CTagsMember term=bold guifg=white
hi CTagsType term=bold guifg=cyan
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

