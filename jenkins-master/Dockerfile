# Base this container on the "iteration" image
FROM iteration
MAINTAINER Luke Woydziak <github@woydziak.com>

# Add Jenkins location to the package manager
RUN sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
RUN wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN apt-get update

# Install Jenkins in our container
RUN apt-get install -y jenkins
RUN echo "jenkins:12345six" | chpasswd

# Install template jobs
RUN mkdir -p /var/lib/jenkins/.jenkins/jobs

# Install Dynamic Machine
RUN pip3 install -U --process-dependency-links "git+git://github.com/Pertino/dynamic_machine#egg=dynamic_machine-1.0.0"

# Add supervisor configuration
RUN mkdir -p /var/log/supervisor /var/run/sshd
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Allow ssh connection to dynamic machines
RUN cp -R /.ssh/ /var/lib/jenkins/
RUN chown -R jenkins:jenkins /var/lib/jenkins

# Expose the SSH and Jenkins TCP/IP ports 
EXPOSE 22 8080 54525

# Upon any run of this container, run supervisor
ENTRYPOINT ["/usr/bin/supervisord"]
