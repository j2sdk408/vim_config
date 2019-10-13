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
" - with the spacebar
set foldmethod=indent
set foldlevel=99
set foldnestmax=3
nnoremap <space> za


" ====================
" misc
" ====================
" load previous position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" switch between split
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" custom file extension
autocmd BufNewFile,BufRead *.cocci set syntax=cocci
autocmd BufNewFile,BufRead *.dox set syntax=doxygen

" diff setting
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


" ====================
" custom command
" ====================
" run with ":!" to start execution
ab dox python ../Tool/doxygen/doc_search.py <cword> %

function DocSearch()
 ! python ../Tool/doxygen/doc_search.py <cword> %
endfunction

nnoremap <A-`> :call DocSearch()<CR>

" ====================
" highlight current word
" ====================
let g:current_cword = ""

function CwordToggle()
    if (g:current_cword == "")
        let g:current_cword = expand("<cword>")
        let @/ = g:current_cword
        call matchadd("IncSearch", g:current_cword)
    else
        let new_cword = expand("<cword>")

        if (g:current_cword != new_cword)
            call clearmatches()

            let g:current_cword = new_cword
            let @/ = g:current_cword
            call matchadd("IncSearch", g:current_cword)
        else
            let g:current_cword = ""
            call clearmatches()
            let @/ = ""
        endif

    endif
endfunction

"nnoremap <S-F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
nnoremap <S-F8> :call CwordToggle()<CR>

" ====================
" ctags: indexing entries
"   - run with "ctags -R" in root directory
" ====================
set tags=./tags,./TAGS,tags;~,TAGS;~

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
" nerdtree: show folder-based directory
" ====================
" toggle hotkey = Alt-F9
nnoremap <A-F9> :NERDTreeToggle<CR>
" show in right
let g:NERDTreeWinPos = "right"

" ====================
" srcexpl: show source definitions
"   - should be used with ctags
" ====================
" toggle hotkey = Alt-F7
nnoremap <A-F7> :SrcExplToggle<CR>

" ====================
" taglist: show tags in current buffer
"   - should be used with ctags
" ====================
" toggle hotkey = Alt-F8
nnoremap <A-F8> :TlistToggle<CR>
" exit vim if only taglist windows
let Tlist_Exit_OnlyWindow = 1 

" show in right
" let Tlist_Use_Right_Window   = 1

" ====================
" syntastic: run checker
" ====================
" disable syntastic by default
let g:syntastic_mode_map = {"mode": "passive"}

" ====================
" pathogen: manage vim bundles
"   - create "bundle" folder in ~/.vim
"   - put separate folder for each plugin
" ====================
execute pathogen#infect()

