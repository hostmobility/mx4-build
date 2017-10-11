FROM debian:8.9

USER root

RUN apt-get update && apt-get install -y gawk wget git-core sudo cpio \
diffstat unzip texinfo gcc-multilib u-boot-tools rsync cbootimage bc \
build-essential kmod chrpath socat mtd-utils device-tree-compiler mtools \
lzop dosfstools parted libncurses5-dev patchutils tmux vim curl python \
libsdl1.2-dev libssl-dev && rm -rf /var/lib/apt/lists/*

ENV USER_HOME /home/builder

RUN adduser builder
RUN adduser builder sudo
RUN echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN mkdir -p /media/buildfolder
RUN chown -R builder /media/buildfolder

USER builder

RUN git config --global user.email 'builder@hostmobility.com'
RUN git config --global user.name 'Host Mobility Builder'