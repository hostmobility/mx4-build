FROM debian:9.9

ENV DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get update && apt-get install -y gawk wget git-core sudo cpio \
diffstat unzip texinfo gcc-multilib u-boot-tools rsync cbootimage bc \
build-essential kmod chrpath socat mtd-utils device-tree-compiler mtools \
lzop dosfstools parted libncurses5-dev patchutils tmux vim curl python python3 locales \
libsdl1.2-dev libssl-dev && rm -rf /var/lib/apt/lists/*

# Install google git-repo
RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo
RUN chmod a+x /usr/bin/repo

ENV USER_HOME /home/builder

RUN adduser builder
RUN adduser builder sudo
RUN echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN mkdir -p /media/buildfolder
RUN chown -R builder /media/buildfolder

## Set LOCALE to UTF8
# NEEDED FOR bitbake python!
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8 

USER builder

RUN git config --global user.email 'builder@hostmobility.com'
RUN git config --global user.name 'Host Mobility Builder'