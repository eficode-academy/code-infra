FROM jenkins:1.651.3

# There was no need for a custom image when jenkins official image was sufficient.
USER root
RUN apt-get update \
      && apt-get install -y sudo \
      && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

# However we need to add plugins to Jenkins
# So to make that work, we need a Dockerfile for jenkins and create our own jenkins image.


# The following passes the following parameter to the jenkins container.
# This means we do not need to pass this to the run command.
CMD ["--prefix=/jenkins"]

# Add plugins to Jenkins:
USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt

# Copy configuration scripts that will be executed by groovy on startup
COPY *.groovy /usr/share/jenkins/ref/init.groovy.d/

# Install Docker
ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.11.0
ENV DOCKER_SHA256 87331b3b75d32d3de5d507db9a19a24dd30ff9b2eb6a5a9bdfaba954da15e16b

RUN set -x \
    && cd \
	&& curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-$DOCKER_VERSION.tgz" -o docker.tgz \
	&& echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
	&& tar -xzvf docker.tgz \
	&& sudo mv docker/* /usr/local/bin/ \
    && ls -al /usr/local/bin \
	&& rmdir docker \
	&& rm docker.tgz \
	&& docker -v


# built it with: docker build --rm -t dod/jenkins .
