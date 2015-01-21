#!/bin/bash

DIR=$(cd $(dirname $0); pwd)
echo $DIR

ln -s $DIR/vimrc $HOME/.vimrc
ln -s $DIR/tmux.conf $HOME/.tmux.conf
ln -s $DIR/xmodmap $HOME/.xmodmap
ln -s $DIR/zshrc $HOME/.zshrc
ln -s $DIR/gitconfig $HOME/.gitconfig

mkdir -p $HOME/.vim/bundle
mkdir -p $HOME/.vim/tmp
mkdir -p $HOME/.vim/undodir

git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

git clone git://github.com/vim-scripts/256-jungle ~/.vim/tmp/256-jungle
cp -r ~/.vim/tmp/256-jungle/colors ~/.vim/

# git clone git://github.com/Shougo/neosnippet-snippets ~/.vim/tmp/neosnippet-snippets
# cp -r ~/.vim/tmp/neosnippet-snippets/neosnippets ~/.vim/neosnippets

rm -rf $DIR/256-jungle

cp $DIR/zshrc.mine $HOME/.zshrc.mine


mkdir -p $HOME/etc $HOME/tmp $HOME/bin

#erutaso
git clone git://github.com/sgymtic/sl $HOME/etc/sl

# cp -r $DIR/neosnippets $HOME/.vim/neosnippets

