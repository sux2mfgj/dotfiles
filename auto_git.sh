#!/bin/zsh


DIRPATH=$HOME/work/

for file in ${DIRPATH}*
do
#      echo ${file}
    if [ -e ${file}/.git ]
    then
        cd ${file}
#          git pull
        git push
    fi
done

cd $HOME/dotfiles
git pull
git push
