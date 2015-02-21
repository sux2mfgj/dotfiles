#!/bin/bash

by_shell(){

    FILES_DIR=$1/files

    ln -s $FILES_DIR/vimrc $HOME/.vimrc
    ln -s $FILES_DIR/tmux.conf $HOME/.tmux.conf
    ln -s $FILES_DIR/xmodmap $HOME/.xmodmap
    ln -s $FILES_DIR/zshrc $HOME/.zshrc
    ln -s $FILES_DIR/gitconfig $HOME/.gitconfig

    mkdir -p $HOME/.vim/bundle
    mkdir -p $HOME/.vim/tmp
    mkdir -p $HOME/.vim/undodir

    git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

    git clone git://github.com/vim-scripts/256-jungle ~/.vim/tmp/256-jungle
    cp -r ~/.vim/tmp/256-jungle/colors ~/.vim/

    git clone git://github.com/Shougo/neosnippet-snippets ~/.vim/tmp/neosnippet-snippets
    cp -r ~/.vim/tmp/neosnippet-snippets/neosnippets ~/.vim/neosnippets

    rm -rf $1/256-jungle

    cp $1/zshrc.mine $HOME/.zshrc.mine


    mkdir -p $HOME/etc $HOME/tmp $HOME/bin

    #erutaso
    git clone git://github.com/sgymtic/sl $HOME/etc/sl

    # cp -r $1/neosnippets $HOME/.vim/neosnippets

}

by_ansible() {
    echo --- > group_vars/all
    echo directory_name: $1 >> group_vars/all

    ansible-playbook -i hosts main.yml --ask-sudo-pass -vvv
}

DIR=$(cd $(dirname $0); pwd)
echo $DIR

if [ `which ansible-playbook` ]; then
    echo "setup script use ansible"
    by_ansible $DIR
else
    echo "shell script"
    by_shell $DIR
fi


