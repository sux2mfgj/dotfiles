#保管
autoload -U compinit
compinit

setopt correct
setopt list_packed
setopt auto_menu
setopt list_types

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

export LANG=ja_JP,UTF-8
export EDITOR=vim


#History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command histroy data



#Emacs key bind
bindkey -e

#cd
setopt auto_cd
setopt auto_pushd

setopt nolistbeep

setopt hist_ignore_space

setopt magic_equal_subst

setopt ignore_eof

export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true

#予測変換
#autoload predict-on
#predict-on

#zshrc.mineの読み込み
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine


autoload -U colors
colors


### Prompt ###
# プロンプトに色を付ける
# 一般ユーザ時
tmp_prompt="%{${fg[cyan]}%}%n@%m# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
# SSHログイン時のプロンプト
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
;

#alias
alias ls="ls -FG --color=auto"
alias tmux="tmux -2"
function chpwd(){
    ls -v -F --color=auto
}
