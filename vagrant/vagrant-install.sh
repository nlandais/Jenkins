#! /bin/bash -e
user=jenkins
group=jenkins
http_port=8080

source /vagrant/setenv.sh

# jenkins version being installed
JENKINS_VERSION="${JENKINS_VERSION:-2.164.2}"
# jenkins.war checksum, download will be validated using it
JENKINS_SHA=c851b603e3d320295eed671fde7c661209645c818da9b7564caee8371e52bede
# Can be used to customize where jenkins.war get downloaded from
JENKINS_URL="https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war"

apt-get update
# apt-get upgrade -y
apt-get install -y git openssh-client curl unzip bash ttf-dejavu coreutils

addgroup $group
adduser --home "$JENKINS_HOME" --ingroup $group --shell /bin/bash --disabled-login $user
mkdir -p $JENKINS_HOME

# `/usr/share/jenkins/ref/` contains all reference configuration we want
# to set on a fresh new installation. Use it to bundle additional plugins
# or config file with your custom jenkins Docker image.
mkdir -p /usr/share/jenkins/ref/init.groovy.d
cp /vagrant/init.groovy /usr/share/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy
cp /vagrant/default-user.groovy /usr/share/jenkins/ref/init.groovy.d/default-user.groovy

# could use ADD but this one does not check Last-Modified header neither does it allow to control checksum
# see https://github.com/docker/docker/issues/8331
curl -fsSL ${JENKINS_URL} -o /usr/share/jenkins/jenkins.war \
  && echo "${JENKINS_SHA}  /usr/share/jenkins/jenkins.war" | sha256sum -c -

chown -R ${user}:${group} "$JENKINS_HOME" /usr/share/jenkins

cp /vagrant/jenkins-support /usr/local/bin/jenkins-support
cp /vagrant/setenv.sh /usr/share/jenkins/setenv.sh
cp /vagrant/jenkins.sh /usr/local/bin/jenkins.sh
chmod u+x /usr/local/bin/jenkins.sh
cp /vagrant/jenkins.service /etc/systemd/system

systemctl enable jenkins
cp /vagrant/plugins.sh /usr/local/bin/plugins.sh
cp /vagrant/install-plugins.sh /usr/local/bin/install-plugins.sh
cp /vagrant/plugins.txt /usr/share/jenkins/ref/plugins.txt
xargs /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Create seed job
mkdir -p /usr/share/jenkins/ref/jobs/seed-job
cp /vagrant/seedJob.xml /usr/share/jenkins/ref/jobs/seed-job/config.xml
sleep 10
systemctl start jenkins
