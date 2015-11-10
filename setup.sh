#!/bin/bash

current_dir=$(cd $(dirname $0); pwd)

files_path=$current_dir/files

# echo $files_path

copy_files=("zshrc.mine")
home_dot_files=("tmux.conf" "vimrc" "xmodmap" "zshrc" "pyrc", "gdbinit" "gitconfig")
create_dirs=(".vim/bundle" ".vim/backup" ".vim/undodir" ".vim/colors" ".emacs.d" "local" "local/bin" "work" "tmp" "src" ".go")

echo ----- copy files -----
for f in ${copy_files[@]}
do
    if [ -e $HOME/.${f} ]
    then
        echo ${f} is already exists.
    else
        ln -s ${files_path}/${f} $HOME/.${f}
        echo ${files_path}/${f} $HOME/.${f}
    fi
done

echo ----- create symbolic link -----
for f in ${home_dot_files[@]}
do
#     echo ${files_path}/${f} $HOME/.${f}
    if [ -e $HOME/.${f} ]; then
        echo ${f} is already exists.
    else
        ln -s ${files_path}/${f} $HOME/.${f}
        echo ${files_path}/${f} $HOME/.${f}
    fi
done

if [ -e $HOME/.ssh/config ]; then
    echo .ssh/config is already exists. 
else
    ln -s ${files_path}/ssh_config $HOME/.ssh/config
fi

# for qtile config file
if [ -e $HOME/.config/qtile/config.py ]
then
    echo config.py is already exists.
else
    mkdir -p $HOME/.config/qtile
    ln -s ${files_path}/qtile.config.py $HOME/.config/qtile/config.py
    echo ${files_path}/qtile.config.py $HOME/.config/qtile/config.py
fi

# for terminator config file
if [ -e $HOME/.config/terminator/config ]
then
    echo terminator config file is already exists.
else
    mkdir -p $HOME/.config/terminator
    ln -s ${files_path}/terminator.config $HOME/.config/terminator/config
    echo ${files_path}/terminator.config $HOME/.config/terminator/config
fi

echo ----- create dir  -----
for dir in ${create_dirs[@]}
do
#     echo $HOME/${dir}
    if [ -e $HOME/${dir} ]; then
        echo $HOME/${dir} is already exists.
    else
        mkdir -p $HOME/${dir}
        echo $HOME/${dir}
    fi
done
# echo ----- finish -----

logfile_dir=$HOME/.dotfile_setup.log

if [ ! -e ${logfile_dir} ]; then
    touch ${logfile_dir}
fi


goto_exit(){
    echo -------- finish --------- >> ${logfile_dir}
    exit $1
}

echo -------- start ---------- >> ${logfile_dir} &
date >> ${logfile_dir}
which git >> ${logfile_dir} 2>&1
if [ $? -ne 0 ]
then
    goto_exit 1
fi

pass_pid=$!

pid_array=()

echo ----- start install -----

echo "[ neobundle(vim) ]"
if [ -e $HOME/.vim/bundle/neobundle.vim ]; then
    echo neobundle was installed already.
    pid_array+=(" ${pass_pid} neobundle")
else
    git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim >> ${logfile_dir} 2>&1 &
#     process >> ${logfile_dir} 2>&1 &
    pid_array+=(" $! neobundle")
fi

echo "[ 256-jungle(vim) ]"
process(){
    git clone git://github.com/vim-scripts/256-jungle /tmp/256-jungle && \
    cp /tmp/256-jungle/colors/256-jungle.vim $HOME/.vim/colors/
    exit $?
}
export -f process

if [ -e $HOME/.vim/colors/256-jungle.vim ]; then
    echo 256-jungle was installed already.
    pid_array+=(" ${pass_pid} 256-jungle")
else
    process >> ${logfile_dir} 2>&1 &
    pid_array+=(" $! 256-jungle")
fi

echo "[ neosnippets(vim) ]"
process(){
    git clone git://github.com/Shougo/neosnippet-snippets /tmp/neosnippet-snippets && \
    cp -r /tmp/neosnippet-snippets/neosnippets $HOME/.vim/neosnippets
    exit $?
}
export -f process
if [ -e $HOME/.vim/neosnippets ]
then
    echo neosnippets was installed already.
    pid_array+=(" ${pass_pid} neosnippets")
else
    process >> ${logfile_dir} 2>&1 &
    pid_array+=(" $! neosnippets")
fi

echo "[ erutaso(sl) ]"
process(){
    git clone git://github.com/sgymtic/sl $HOME/etc/sl &&\
    make -C $HOME/etc/sl && \
    ln -s $HOME/etc/sl/erutaso $HOME/bin/sl
    exit $?
}
if [ -e $HOME/etc/sl ]
then
    echo erutaso was installed already.
    pid_array+=(" ${pass_pid} erutaso")
else
    process >> ${logfile_dir} 2>&1 &
    pid_array+=(" $! erutaso")
fi

echo "[ zsh-completions(zsh) ]"
process(){
    mkdir -p $HOME/.zsh 
    git clone https://github.com/zsh-users/zsh-completions.git $HOME/.zsh/zsh-completions.git
    exit $?
}
if [ -e $HOME/.zsh/zsh-completions ]
then
    echo zsh-completions was installed already.
    pid_array+=(" ${pass_pid} zsh-completions")
else
    process >> ${logfile_dir} 2>&1 &
    pid_array+=(" $! zsh-completions")
fi

echo "[ enhancd ]"
process(){
    mkdir -p $HOME/.zsh
    git clone https://github.com/b4b4r07/enhancd.git $HOME/.zsh/enhancd
    exit $?
}
if [ -e $HOME/.zsh/enhancd ]
then
    echo enhancd was installed already.
    pid_array+=(" ${pass_pid} enhancd")
else
    process >> ${logfile_dir} 2>&1 &
    pid_array+=(" $! enhancd")
fi

# compile qtile.config.py
python -m py_compile $HOME/.config/qtile/config.py >> ${logfile_dir} 2>&1 &
pid_array+=(" $! check_qtile.config.py")

status_code=0
echo ----- finished -----
for line in "${pid_array[@]}"
do
    pid=`echo ${line[@]} | awk '{print $1}'`
    text=`echo ${line[@]} | awk '{print $2}'`

    wait ${pid}
    if [ $? -eq 0 ]
    then
        echo [ ${text} ]
    else
        echo "*** error occured *** [${text}]"
        status_code=1
    fi
done

goto_exit ${status_code}
