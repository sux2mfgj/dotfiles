#!/usr/bin/env bash

current_dir=$(cd $(dirname $0); pwd)

files_path=$current_dir/files

# echo $files_path
logfile_dir=$HOME/.dotfiles_setup.log
copy_files=("zshrc.mine")
home_dot_files=("tmux.conf" "vimrc" "xmodmap" "xmodmap.a" "vimrc" "zshrc" "pyrc", "gdbinit" "gitconfig" "zshrc.pyenv")
create_dirs=(".vim/bundle" ".vim/backup" ".vim/undodir" ".vim/colors" ".emacs.d"  "work" "tmp" ".go" ".emacs.d/inits" "logbook" ".tmux/plugins")
# emacs_inits=("02_linum.el 01_load_macro.el 00_init.el")
emacs_inits=(`ls ${files_path}/inits`)

echo ----- copy files -----
for f in ${copy_files[@]}
do
    if [ -e $HOME/.${f} ]
    then
        echo ${f} is already exists.
    else
        touch $HOME/.${f}
        echo "touch $HOME/.${f}"
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

# for tmux
sed -e "s/C-t/C-g/" $HOME/.tmux.conf >> $HOME/.tmux.conf.client

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

if [ -e $HOME/.config/alacritty/alacritty.yml ]
then
    echo alacritty.yml is already exists.
else
    mkdir -p $HOME/.config/alacritty/
    ln -s ${files_path}/alacritty.yml $HOME/.config/alacritty/alacritty.yml
    echo ${files_path}/alacritty.yml $HOME/.config/alacritty/alacritty.yml
fi

# for nvim config file
if [ -e $HOME/.config/nvim/init.vim ]
then
    echo nvim config file is already exists.
else
    mkdir -p $HOME/.config/nvim
    ln -s ${files_path}/vimrc $HOME/.config/nvim/init.vim
    echo ${files_path}/vimrc $HOME/.config/nvim/init.vim
fi


if [ -e $HOME/.irssi/config ]
then
    echo irrssi config file is already exists.
else
    mkdir -p $HOME/.irssi/
    ln -s ${files_path}/irssi_config $HOME/.irssi/config
    echo ${files_path}/irssi_config $HOME/.irssi/config
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


echo ----- link emacs inits -----
for elfile in ${emacs_inits[@]}
do
    if [ -e $HOME/.emacs.d/inits/${elfile} ];
    then
        echo $HOME/.emacs.d/inits${elfile} is already exists.
    else
        ln -s ${files_path}/inits/${elfile} $HOME/.emacs.d/inits/${elfile}
        echo $HOME/.emacs.d/inits/${elfile}
    fi
done

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

if [ -e $HOME/.emacs.d/init.el ]
then
    echo found init.el
else
    ln -s ${files_path}/init.el $HOME/.emacs.d/init.el
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

echo "[ zsh-completions(zsh) ]"
process(){
    mkdir -p $HOME/.zsh
    git clone https://github.com/zsh-users/zsh-completions.git $HOME/.zsh/zsh-completions
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

echo "[ pyenv ]"
process(){
    git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv
    exit $?
}
if [ -e $HOME/.pyenv ]
then
    echo enhancd was installed already.
    pid_array+=(" ${pass_pid} pyenv")
else
    process >> ${logfile_dir} 2>&1 &
    pid_array+=(" $! pyenv")
fi

process(){
    git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv
    exit $?
}
if [ -e $HOME/.pyenv/plugins/pyenv-virtualenv ]
then
    echo virtualenv was installed already.
    pid_array+=(" ${pass_pid} virtualenv")
else
    process >> ${logfile_dir} 2>&1 &
    pid_array+=(" $! virtualenv")
fi

process() {
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    exit $?
}
if [ -e $HOME/.tmux/plugins/tpm ]
then
    echo "tpm was installed already."
    pid_array+=(" ${pass_pid} tpm" )
else
    process >> ${logfile_dir} 2>&1 &
    pid_array+=(" $! tpm")
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
exit 0
goto_exit 0 #${status_code}
