# windows setting:
* related directory and files
    * ~/.vim --> C:/Users/<user name>/vimfiles
    * ~/.vimrc --> C:/Users/<user name>/_vimrc
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

# externam command

## ctags
* For windows, put ctags and other program uncer vim folder so that no modification for $PATH is required.
## cscope
* For windows, use cscope-win32: https://code.google.com/archive/p/cscope-win32/

# plug-ins

* nerdtree
* SrcExpl
* taghighlight
* vim-misc
* taglist
