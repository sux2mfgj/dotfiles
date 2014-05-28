#!/bin/zsh

DIR=$(cd $(dirname $0); pwd)
echo $DIR

ln -s $DIR/vimrc $HOME/.vimrc
ln -s $DIR/tmux.conf $HOME/.tmux.conf
ln -s $DIR/xmodmap $HOME/.xmodmap
ln -s $DIR/zshrc $HOME/.zshrc

mkdir -p ~/.vim/bundle
mkdir ~/.vim/tmp

git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

git clone git://github.com/vim-scripts/256-jungle ~/.vim/tmp/256-jungle
cp -r ~/.vim/tmp/256-jungle/colors ~/.vim/

git clone git://github.com/Shougo/neosnippet-snippets ~/.vim/tmp/neosnippet-snippets
cp -r ~/.vim/tmp/neosnippet-snippets/neosnippets ../



rm -rf $DIR/256-jungle

cp $DIR/zshrc.mine $HOME/.zshrc.mine


mkdir $HOME/etc $HOME/tmp $HOME/bin
# ln -s $DIR/auto_git.sh /etc/cron.daily/auto_git
# ln -s $DIR/delete_tmp.sh /etc/cron.daily/delete_tmp

#erutaso
git clone git://github.com/sgymtic/sl $HOME/etc/sl

cp -r $DIR/neosnippets $HOME/.vim/neosnippets

