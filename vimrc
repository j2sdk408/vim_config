" source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
behave mswin
source /usr/share/vim/vim80/mswin.vim
set nu
colorscheme torte
set tabstop=4
set expandtab
set guifont=Monospace\ 16
set nobackup
set noundofile
set autoread
set hlsearch

" python
set softtabstop=4
set shiftwidth=4
set colorcolumn=80
set autoindent
" Enable folding
set foldmethod=indent
set foldlevel=99
set foldnestmax=3

" ctags
set tags=./tags,./TAGS,tags;~,TAGS;~

let g:syntastic_mode_map = {"mode": "passive"}


" Enable folding with the spacebar
nnoremap <A-F8> :TlistToggle<CR>
let Tlist_Exit_OnlyWindow = 1 

" Enable folding with the spacebar
nnoremap <space> za
" switch between split
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

autocmd BufNewFile,BufRead *.cocci set syntax=cocci
autocmd BufNewFile,BufRead *.dox set syntax=doxygen

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

" cscope
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


" custom command
ab dox python ../Tool/doxygen/comment_gen.py --html <cword> %
ab ex Explore **/

" pathogen
execute pathogen#infect()

" NERDTree
nnoremap <A-F9> :NERDTreeToggle<CR>

" SrcExplToggle
nnoremap <A-F7> :SrcExplToggle<CR>
