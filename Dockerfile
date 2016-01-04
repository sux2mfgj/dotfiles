FROM debian:jessie

MAINTAINER himaaaatti

RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get install -y git #ncurses

RUN useradd -m -s /bin/bash hima

#  ADD setup.sh /home/hima/setup.sh
ENV HOME /home/hima
WORKDIR /home/hima
ADD ./setup.sh ./setup.sh
RUN git clone http://github.com/himaaaatti/dotfiles

WORKDIR /home/hima/dotfiles

RUN ["./setup.sh"]
