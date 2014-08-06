# Base this image on Ubuntu 14.04 linux
FROM ubuntu:14.04
MAINTAINER Luke Woydziak <github@woydziak.com>

# Add supervisor location to package manager
RUN sh -c 'echo deb http://archive.ubuntu.com/ubuntu trusty main universe > /etc/apt/sources.list.d/supervisor.list'
RUN apt-get update

# Install Java dependencies in this container
RUN apt-get install -y software-properties-common

# Add Oracle Java install location to package manager
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update --fix-missing

# Install miscellaneous dependencies
RUN apt-get install -y wget
RUN apt-get install -y vim
RUN apt-get install -y ssh
RUN apt-get install -y git
RUN apt-get install -y debconf
RUN apt-get install -y supervisor
RUN apt-get install -y openssl
RUN apt-get install -y build-essential
RUN apt-get install -y cpp
RUN apt-get install -y cpp-4.8
RUN apt-get install -y dpkg-dev
RUN apt-get install -y fakeroot
RUN apt-get install -y g++
RUN apt-get install -y g++-4.8
RUN apt-get install -y gcc
RUN apt-get install -y gcc-4.8
RUN apt-get install -y libalgorithm-diff-perl
RUN apt-get install -y libalgorithm-diff-xs-perl
RUN apt-get install -y libalgorithm-merge-perl
RUN apt-get install -y libasan0
RUN apt-get install -y libatomic1
RUN apt-get install -y libc-dev-bin
RUN apt-get install -y libc6-dev
RUN apt-get install -y libcloog-isl4
RUN apt-get install -y libdpkg-perl
RUN apt-get install -y libfakeroot
RUN apt-get install -y libfile-fcntllock-perl
RUN apt-get install -y libgcc-4.8-dev
RUN apt-get install -y libgmp10
RUN apt-get install -y libgomp1
RUN apt-get install -y libisl10
RUN apt-get install -y libitm1
RUN apt-get install -y libmpc3
RUN apt-get install -y libmpfr4
RUN apt-get install -y libquadmath0
RUN apt-get install -y libstdc++-4.8-dev
RUN apt-get install -y libtimedate-perl
RUN apt-get install -y libtsan0
RUN apt-get install -y linux-libc-dev
RUN apt-get install -y make
RUN apt-get install -y manpages
RUN apt-get install -y manpages-dev
RUN apt-get install -y python-colorama
RUN apt-get install -y python-distlib
RUN apt-get install -y python-html5lib
RUN apt-get install -y python-pip
RUN apt-get install -y python-setuptools
RUN apt-get install -y xz-utils
RUN apt-get install -y binutils
RUN apt-get install -y python3-pip
RUN apt-get install -y rsync

# Install Oracle Java
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer

# Add a default administrator for SSH login security
RUN echo '12345six\n12345six\n\n\n\n\n\n\n' | adduser pertino
RUN usermod -a -G sudo pertino && chsh -s /bin/bash pertino

# Configure SSH
RUN rm /etc/nologin
RUN sed -i s/"session    required     pam_loginuid.so"/"#session    required     pam_loginuid.so"/g /etc/pam.d/sshd
RUN echo LANG="en_US.UTF-8" > /etc/default/locale

RUN mkdir .ssh
RUN ssh-keygen -t rsa -N "" -C pertinodemo@woydziak.com -f .ssh/id_rsa
