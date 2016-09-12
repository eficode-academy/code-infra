# Continuous Delivery Infrastructure

You need docker and docker-compose to run this setup.

  * Jenkins runs at http://YOUR-DOCKER-HOST:8081/jenkins
  * Artifactory runs at http://YOUR-DOCKER-HOST:8090/artifactory
  * Registry run at http://http://YOUR-DOCKER-HOST:5000

The containers home directories (data directories) are in /opt/containers, except for jenkins which is mounted on /var/jenkins_home to be compatible with jenkins workspace paths.
These directory trees need to be owned by uid 1000 and gid 50. They are setup to have this ownership when you run the create-homes.sh script.

# Setup

Create the data filesystems for the servers:

    git clone https://github.com/praqma-training/code-infra
    cd code-infra/containers
    sudo ./create-homes.sh


# Run the system (apache, jenkins, registry, artifactory)

    $ docker-compose up -d
