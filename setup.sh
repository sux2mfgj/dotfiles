#!/bin/bash 

mkdir -p ~/.vim/bundle

git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle

git clone git://github.com/vim-scripts/256-jungle ~/

cp -r ~/256-jungle/colors ~/.vim/

rm -r ~/256-jungle

ln -s ./vimrc ~/.vimrc
ln -s ./tmux.conf ~/.tmux.conf
ln -s ./xmodmap .xmodmap