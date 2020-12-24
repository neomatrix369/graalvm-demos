#!/bin/bash

#Open ports for the services to communicate
sudo firewall-cmd --zone=public --permanent --add-port=8080-8085/tcp
sudo firewall-cmd --zone=public --permanent --add-port=8443/tcp
sudo firewall-cmd --reload

sudo yum install -y git docker-compose

wget https://github.com/oracle/graal/releases/download/vm-19.2.1/graalvm-ce-linux-amd64-19.2.1.tar.gz
tar xzvf graalvm-ce-linux-amd64-19.2.1.tar.gz
export JAVA_HOME=${PWD}/graalvm-ce-19.2.1
export PATH=${JAVA_HOME}/bin:${PATH}

git clone https://github.com/neomatrix369/graalvm-demos/
cd graalvm-demos
git checkout fixes-to-make-it-work-on-oci
cd micronaut-webapp
./gradlew assemble
./deployments/local/build-docker-compose.sh graalvm

echo "-----------------------------------------------------------------------------------------------------------"
echo " ssh onto the box followed by docker-compose: "
echo "     ssh opc@[public-ip-address-of-instance] 'cd graalvm-demos/micronaut-webapp; docker-compose up --build' "
echo "-----------------------------------------------------------------------------------------------------------"