set colorcolumn=80

" fold by indent
set foldmethod=indent
set foldnestmax=3

" ====================
" make
" ====================
set makeprg=python ../Tool/checker/bin/check_tool_modified.py --format VIM
