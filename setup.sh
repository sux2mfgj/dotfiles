#!/bin/bash

current_dir=$(cd $(dirname $0); pwd)

files_path=$current_dir/files

echo $files_path

home_dot_files=("tmux.conf" "vimrc" "xmodmap" "zshrc")
create_dirs=(".vim/bundle" ".vim/backup" ".vim/undodir" ".emacs.d" "bin" "work" "tmp" "src")


echo ----- create symbolic link -----
for f in ${home_dot_files[@]}
do
#     echo ${files_path}/${f} $HOME/.${f}
    if [ -e $HOME/.${f} ]; then
        echo ${f} is already exists.
    else
        ln -s ${files_path}/${f} $HOME/.${f}
    fi
done
echo ----- finish -----

echo ----- create dir  -----
for dir in ${create_dirs[@]}
do
#     echo $HOME/${dir}
    if [ -e $HOME/${dir} ]; then
        echo $HOME/${dir} is already exists.
    else
        mkdir -p $HOME/${dir}
    fi
done
echo ----- finish -----

pid_array=()


echo start install 
echo [ neobundle ]
if [ -e $HOME/.vim/bundle/neobundle.vim ]; then
    echo neobundle already installed
else
    $(git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim)
    pid_array+=$! "installed neobundle"
fi


for line in ${pid_array}
do
    echo ${line}
done




