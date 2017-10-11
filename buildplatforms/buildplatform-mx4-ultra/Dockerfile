FROM debian:8.9

USER root

RUN apt-get update
RUN apt-get install -y wget bzip2

RUN cd / && wget http://hostmobility.org/mx4/tools/gcc-linaro-arm-linux-gnueabihf-2012.09-20120921_linux.tar.bz2

RUN tar xvf /gcc-linaro-arm-linux-gnueabihf-2012.09-20120921_linux.tar.bz2 -C /opt

# We need an old tar version for compatibility with this old build
RUN cd / && wget http://hostmobility.org/mx4/tools/tar_1.26%2bdfsg-0.1%2bdeb7u1_amd64.deb

RUN dpkg --add-architecture i386

RUN apt-get update && dpkg -i /tar_1.26+dfsg-0.1+deb7u1_amd64.deb

RUN apt-get install -y gawk wget git-core sudo cpio flex bison rake \
	diffstat unzip texinfo gcc-multilib u-boot-tools rsync cbootimage bc \
	build-essential chrpath socat mtd-utils device-tree-compiler mtools lzop \
	dosfstools parted kmod python3 locales libsdl1.2-dev file ruby \
    clang rake curl gcc-mingw-w64-i686 doxygen doxygen-gui graphviz cmake \
    qt4-dev-tools libc6-dev-i386 g++-multilib libdb5.3-dev p7zip wine32 vim nano \
    lib32z1-dev && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/wine32 /usr/bin/wine

ENV USER_HOME /home/builder

RUN adduser builder
RUN adduser builder sudo
RUN echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN mkdir -p /media/buildfolder
RUN chown -R builder /media/buildfolder

USER builder

RUN git config --global user.email 'builder@hostmobility.com'
RUN git config --global user.name 'Host Mobility Builder'