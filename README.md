# dayofdocker15

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

    git clone https://github.com/praqma-training/code-infra

Create a vitual machine for running the CI system:

    docker-machine create code --driver virtualbox
    eval $(docker-machine env code)



Create the data filesystems for the servers:

    docker-machine ssh code
    docker@code:~$ cat > make_data.sh
    echo "You should not be running any containers in /opt/containers when you run this script."
    echo "Removing old directory structure from /opt/containers"
    rm /opt/containers/* -fr
    echo "Re-creating directory structure inside /opt/containers"
    mkdir -p /opt/containers/jenkins_home
    mkdir -p /opt/containers/artifactory/data
    mkdir -p /opt/containers/artifactory/logs
    mkdir -p /opt/containers/artifactory/backup
    mkdir -p /opt/containers/registry
    echo "Changing ownership of /opt/containers to 1000:50 recursively"
    chown 1000:50 /opt/containers -R
    echo "Done."

    docker@code:~$ chmod u+x make_data.sh
    docker@code:~$ sudo ./make_data.sh
    docker@code:~$ exit


# Set up jenkins build environment

    $ cd containers
    $ docker-compose -up
