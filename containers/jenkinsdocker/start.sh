dockerid=$(getent group docker|cut -d":" -f3)
echo "Docker group id on host : $dockerid"

function generateDockerfile(){

cat <<EOF
from jenkins:2.7.2
USER root
RUN apt-get update
RUN apt-get install apt-transport-https ca-certificates software-properties-common -y
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN add-apt-repository 'deb https://apt.dockerproject.org/repo debian-jessie main'
RUN apt-get update -y
RUN apt-cache policy docker-engine
RUN apt-get update -y
RUN apt-get install docker-engine -y
RUN groupadd -g $dockerid dockerg
RUN usermod -a -G dockerg jenkins
USER jenkins
EOF

}

echo "Createing Dockerfile"
generateDockerfile > Dockerfile

echo "Building Jenkins Docker image"
docker build -t dockerjenkins:1 .

echo "Starting Jenkins with Docker"

docker run -d -p 8085:8080 -p 50005:50000 -v /var/run/docker.sock:/var/run/docker.sock -v /data/jenkins:/var/jenkins_home dockerjenkins:1
