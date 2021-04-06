# windows setting:
* related directory and files
    * ~/.vim --> C:/Users/{user name}/vimfiles
    * ~/.vimrc --> C:/Users/{user name}/_vimrc
* separate OS-specific settings by
```    
    if has("unix")
        ...
    else
        ...
    endif
```   
* add context menu
    * open regedit
    * go to `HKEY_CLASSES_ROOT` -> Folder -> shell
    * create key: "Open with gVim"
    * create key under (c): "c:\Program Files (x86)\vim\run_vim.bat" "%1"
    * put run_vim.bat to related folder

# external command

## ctags
* For windows, put ctags and other program under vim folder so that no modification for $PATH is required.
## cscope
* For windows, use cscope-win32: https://code.google.com/archive/p/cscope-win32/

# plug-ins

* use pathogen in handle vim plugins. See https://github.com/tpope/vim-pathogen
* create ~/.vim/autoload/pathogen.vim
* put plug-in under ~/.vim/bundles folder

## useful plug-ins

* nerdtree
    - file navigator
* SrcExpl
    - show original source
* taghighlight
    - show tag highlight
    - modify the following settings
        - forced_python_variant:python
        - use_existing_tagfile:True
* tagbar
    - show tags in current file
* gutentags
* gutentags_plus
    - update ctags result
* vim-misc

* gtags-cscope
* gtags
    - GNU global

* fugitive

* taglist(deprecated)
