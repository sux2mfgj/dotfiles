#!/bin/zsh


DIRPATH=$HOME/work/

for file in ${DIRPATH}*
do
#      echo ${file}
    if [ -e ${file}/.git ]
    then
        cd ${file}
        git push
    fi
done

