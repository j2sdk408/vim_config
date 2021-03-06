behave mswin

" OS specific settings
if has("unix")
    source /usr/share/vim/vim80/mswin.vim
    set guifont=Monospace\ 14
else
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim

    " set lang to utf-8
    "set guifont=Consolas:h12:cANSI:qDRAFT
    set guifont=Courier_New:h16:cANSI:qDRAFT
    let $LANG="zh_TW.UTF-8"
    set langmenu=zh_tw.utf-8
    set encoding=utf-8

    "reload menu with UTF-8 encoding
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
endif

set nu
set hidden
colorscheme torte
set tabstop=4
set expandtab
set nobackup
set noundofile
set autoread
set hlsearch
set incsearch
set formatoptions=
set wildmenu

" load plugin by file type
filetype plugin on

" python
set softtabstop=4
set shiftwidth=4
set autoindent

" Enable folding
" - with the spacebar
nnoremap <space> za
hi Folded guifg=black
set foldlevel=99

" ====================
" completion setting
" ====================
hi Pmenu guibg=gray20 guifg=white
hi PmenuSel guifg=gray20 guibg=white

set completeopt=longest,menuone

" ====================
" vim diff
" ====================
" smaller font for vimdiff
if &diff
    if has("unix")
        set guifont=Monospace\ 14
    else
        set guifont=Courier_New:h14:cANSI:qDRAFT
    endif
endif

hi DiffText guifg=black
hi DiffAdd gui=bold term=bold guifg=black guibg=green4
hi DiffDelete gui=bold term=bold guifg=black guibg=red4
hi DiffChange gui=bold term=bold guifg=black guibg=yellow4

" ====================
" misc
" ====================
" load previous position
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" ignore output folder
set wildignore=Output/**

" mark trailing whitespaces
"call matchadd("Error", "  *$")

" switch between split
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" navigate in quickfix
map <C-n> :cn<CR>
map <C-p> :cp<CR>

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
" bind RB gui tool
" ====================
function! RbGui()
    if has("unix")
        ! python -m repository_tool.rb.rbgui
    else
        !start python -m repository_tool.rb.rbgui
    endif
endfunction

" ====================
" bind repository commands
" ====================
if has("unix")
    " do nothing
else
    function! TortoiseShowLog()
        !start python -m editor_tool.repo_cmd log_project --file "%"
    endfunction
    nnoremap t<C-g> :call TortoiseShowLog()<CR>

    function! TortoiseDiffFile()
        !start python -m editor_tool.repo_cmd diff --file "%"
    endfunction
    nnoremap t<C-p> :call TortoiseDiffFile()<CR>

    function! TortoiseDiffProject()
        !start python -m editor_tool.repo_cmd diff_project
    endfunction
    nnoremap t<C-d> :call TortoiseDiffProject()<CR>

    function! TortoiseBlame()
        !start python -m editor_tool.repo_cmd blame --file "%"
    endfunction
    nnoremap t<C-b> :call TortoiseBlame()<CR>
endif

" ====================
" highlight current word
" ====================
let g:current_cword = ""

function! _WordToggle()
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
nnoremap <S-F8> :call _WordToggle()<CR>


" get highlight group for cursor word
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" ====================
" change font size
" ====================
nnoremap <C-Up> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)+1)',
 \ '')<CR>
nnoremap <C-Down> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)-1)',
 \ '')<CR>

" ====================
" ctags: indexing entries
"   - run with "ctags -R" in root directory
" ====================
set tags=./tags,./TAGS,tags;~,TAGS;~
nnoremap <F7> :ta 
nnoremap <C-LeftMouse>: ta <cword><CR>

function! CtagUpdate()
    if has("unix")
        ! ctags -R --extra=+f --exclude=Output
    else
        !start ctags -R --extra=+f --exclude=Output
    endif
endfunction

" add ctags flag for gutenflags
let g:gutentags_ctags_extra_args = ['--extra=+f', '--exclude=Output']
let g:gutentags_modules = ['ctags', 'gtags_cscope']
nnoremap <C-F7> :Gtags -g 
let g:gutentags_define_advanced_commands = 1
let g:gutentags_enabled = 0


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
"nnoremap <A-F8> :TlistToggle<CR>
" exit vim if only taglist windows
"let Tlist_Exit_OnlyWindow = 1

" show in left
" let Tlist_Use_Right_Window   = 1

" show tags in one file only
"let Tlist_Show_One_File = 1

" ====================
" tagbar: show tags in current buffer
"   - should be used with ctags
" ====================
nnoremap <A-F8> :TagbarToggle<CR>

" show in left
let g:tagbar_left = 1

let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1

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

