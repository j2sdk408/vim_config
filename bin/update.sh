#!/bin/sh
if [[ -d ~/vimfiles ]]; then
    # windows
    cp -i vimrc ~/_vimrc
    cp -i ftplugin/* ~/vimfiles/ftplugin
else
    # unix
    cp -i vimrc ~/.vimrc
    cp -i ftplugin/* ~/.vim/ftplugin
fi
