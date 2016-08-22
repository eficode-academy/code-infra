# Continuous Delivery Infrastructure

You need docker and docker-compose to run this setup.

Jenkins runs at http://YOUR-DOCKER-HOST:8080/jenkins
Artifactory runs at http://YOUR-DOCKER-HOST:8090/artifactory
Registry run at http://http://YOUR-DOCKER-HOST:5000

The testing web server (written in Go) will be accessible at http://YOUR-DOCKER-HOST:8000 - when you compile it and run it.

There is a centos-slave Docker container, which you may need to build yourself if you decide to modify it.

The containers home directories (data directories) are in /opt/containers .
The /opt/containers directory tree needs to be owned by uid 1000 and gid 50. They are setup to have this ownership.
If you want to do something manually to these directories, you need to use sudo.

There is a GoWebServer directory which contains http.go file. You can run it and it will open a port 8000 and listen on it.
This is the test project, which will be compiled by the students through jenkins.

# setup

Fork this git repository for the go web server:


Create the data filesystems for the servers:

    git clone https://github.com/praqma-training/code-infra
    cd code-infra/containers
    sudo ./create-homes.sh


# Bring up the containers (apache, jenkins, registry, artifactory

    $ docker-compose up -d
