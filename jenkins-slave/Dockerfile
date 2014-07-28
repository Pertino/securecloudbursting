FROM iteration
MAINTAINER Luke Woydziak <github@woydziak.com>

# Make docker package discoverable
RUN apt-get update
RUN apt-get install -y apt-transport-https	
RUN apt-get install -y apparmor
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
RUN sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
RUN apt-get update

# Docker install
RUN apt-get install -y lxc-docker

# Specific Build dependencies 
RUN apt-get install -y curl

# Supervisor startup
RUN mkdir -p /var/log/supervisor /var/run/sshd
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add Jenkins to the image
RUN adduser --quiet jenkins

# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd
ADD run_slave.sh /usr/bin/run_slave.sh

# make docker runnable
RUN groupadd docker || true
RUN gpasswd -a jenkins docker
ADD wrapdocker /usr/bin/wrapdocker

EXPOSE 22

ENTRYPOINT ["/usr/bin/supervisord"]
