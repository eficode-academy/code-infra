dockerid=$(getent group docker|cut -d":" -f3)
echo "Docker group id on host : $dockerid"

function generateDockerfile(){

cat <<EOF
from jenkins:2.7.2
USER root
RUN apt-get update -y
RUN apt-get install docker.io -y
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

docker run -d -p 8080:8080 -p 50000:50000 -v /var/run/docker.sock:/var/run/docker.sock -v /data/jenkins:/var/jenkins_home dockerjenkins:1
