
alias tmux="tmux -2"
[[ -z "$TMUX" && -n "$DISPLAY" && -z "$WINDOW" && ! -z "$PS1" ]] && tmux

if [ -z "$TMUX" ]; then
    
    if [ -f $HOME/.nested_tmux ];then
        tmux -2 -f $HOME/.tmux.nested.conf
    else
        tmux -2 -f $HOME/.tmux.ori.conf
    fi

fi


