FROM jenkins:2.60.2

ENV DEBIAN_FRONTEND noninteractive

# We need to change to root to be able to install with apt-get
USER root

RUN apt-get update

RUN apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

RUN apt-get update

RUN apt-get install -y docker-ce && rm -rf /var/lib/apt/lists/*

# Install google git-repo
RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo
RUN chmod a+x /usr/bin/repo

# We need to add jenkins to sudo and sudoers because we currently have an
# ugly script in hostmobility/mx4 repo that requires some commands to be
# run as sudo (unpack/pack rootfs) and without asking for password to
# be able to run it in an jenkins environment
RUN adduser jenkins sudo
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Location where Jenkins workspace is stored and it is the location
# where most of build time will be spent. Preferred if this
# location is on a SSD and if you bind-mount this directory from
# host using -v.
RUN mkdir -p /media/jenkins
RUN chown -R jenkins /media/jenkins

# Location where build history is stored. Usually a large HDD
# bind-mounted from host with -v.
RUN mkdir -p /media/storage/jenkins
RUN chown -R jenkins /media/storage/jenkins

# Jenkins http port
EXPOSE 8888

# Switch to user jenkins
USER jenkins

RUN git config --global user.email 'builder@hostmobility.com'
RUN git config --global user.name 'Host Mobility Builder'

RUN install-plugins.sh \
	multiple-scms:0.6 \
	git:3.3.1 \
	git-client:2.4.6 \
	github:1.27.0 \
	ssh-credentials:1.13 \
	role-strategy:2.5.0 \
	blueocean:1.1.2 \
	blueocean-pipeline-editor:0.2.0 \
	delivery-pipeline-plugin:1.0.2 \
	jobConfigHistory:2.16 \
	email-ext:2.58 \
	mailer:1.20 \
	repo:1.10.7 \
