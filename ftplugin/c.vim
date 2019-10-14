" ====================
" custom command
" ====================
" run with ":!" to start execution
ab dox python ../Tool/doxygen/doc_search.py <cword> %

function! DocSearch()
 ! python ../Tool/doxygen/doc_search.py <cword> %
endfunction

nnoremap <A-`> :call DocSearch()<CR>


" ====================
" cscope: searching projects with better indexing?
"   - run with "cscope -Rbqk" in root directory
" ====================
set cscopetag
set csto=0
if filereadable("cscope.out")
   cs add cscope.out   
elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
endif
set cscopeverbose

nmap zs :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap zg :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap zc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap zt :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap ze :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap zf :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap zi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap zd :cs find d <C-R>=expand("<cword>")<CR><CR>

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

" get highlight group for cursor word
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
