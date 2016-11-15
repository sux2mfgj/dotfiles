#!/bin/bash

set -eu

if [ $# -ne 1 ]; then
    echo 'example'
    echo '  $ chroot_plus.sh /home/hima/chroot/debian_0'
    exit
fi

if [ ${EUID:-${UID}} != 0 ]; then
   echo 'You are not root'
   exit
fi

if [[ -v SUDO_USER ]]; then
    echo username: $SUDO_USER
    user=$SUDO_USER
else
    echo "cannot detect user."
    exit 1
fi

dest_dir=$1

mount_out=`mount`

# proc
if ! echo ${mount_out} | grep ${dest_dir}/proc > /dev/null; then
    mount -t proc proc ${dest_dir}/proc
    echo "[proc] mounted."
else
    echo "[proc] already mounted."
fi

# tmpfs
if ! echo ${mount_out} | grep ${dest_dir}/tmp > /dev/null ; then
    mount -t tmpfs tmpfs ${dest_dir}/tmp
    echo "[tmpfs] mounted."
else
    echo "[tmpfs] already mounted."
fi 

# devfs
if ! echo ${mount_out} | grep ${dest_dir}/dev > /dev/null; then
    mount --rbind /dev ${dest_dir}/dev
    echo "[devfs] mounted."
else
    echo "[devfs] already mounted."
fi

# sysfs
if ! echo ${mount_out} | grep ${dest_dir}/sys > /dev/null; then
    mount -t sysfs sysfs ${dest_dir}/sys
    echo "[sysfs] mounted."
else
    echo "[sysfs] already mounted."
fi

# copy resolv.conf
if [ ! -d ${dest_dir}/etc ]; then
    echo "${dest_dir}/etc is not found."
    exit 1
else
    cp /etc/resolv.conf ${dest_dir}/etc/resolv.conf
fi

# mount .ssh dir
if [ ! -d ${dest_dir}/home/${user}/.ssh ]; then
    echo "${dest_dir}"/home/${user}/.ssh is not found.
    exit 1
else
    mount --rbind /home/${user}/.ssh ${dest_dir}/home/${user}/.ssh
fi

# for x application
xhost +local:

# change root!
chroot ${dest_dir} /bin/bash

exit 1
