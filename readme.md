windows setting:
1. ~/.vim       --> C:/Users/<user name>/vimfiles
2. ~/.vimrc     --> C:/Users/<user name>/_vimrc
3. separate OS-specific settings by
    if has("unix")
        ...
    else
        ...
    endif

4. add context menu
    a. open regedit
    b. go to `HKEY_CLASSES_ROOT` -> Folder -> shell
    c. create key: "Open with gVim"
    d. create key under (c): "c:\Program Files (x86)\vim\run_vim.bat" "%1"
    e. put run_vim.bat to related folder

externam command:

    ctags

    cscope


plug-ins:

    nerdtree

    SrcExpl

    taghighlight

    vim-misc

    taglist
