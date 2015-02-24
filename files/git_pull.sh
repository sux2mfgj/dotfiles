#!/bin/bash

log_file=/tmp/git_pull_faild_

if [ -e $HOME/dotfiles ]
then
    echo exist
    log_file=$log_file`date +%Y_%m_%d_%H_%M`.log

    git --git-dir=$HOME/dotfiles/.git pull origin master >  $log_file 1>&2

    if [ $? -ne 0 ]
    then
        echo faild
        cp $log_file $HOME/
    else
        echo succses
        rm $log_file
    fi
fi

