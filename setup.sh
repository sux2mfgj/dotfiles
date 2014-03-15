#!/bin/bash 

#vim
mkdir -p ~/.vim/bundle

git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle

git clone git://github.com/vim-scripts/256-jungle ~/

cp -r ~/256-jungle/colors ~/.vim/

rm -r ~/256-jungle

ln -s ~/dotfiles/vimrc ~/.vimrc

cp -r ~/dotfiles/dict ~/.vim/

mkdir -p ~/.vim/backup

#other
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/xmodmap ~/.xmodmap

#zsh
ln -s ~/dotfiles/zshrc ~/.zshrc
