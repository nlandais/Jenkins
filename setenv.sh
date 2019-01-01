#! /bin/bash -e
agent_port=50000
export JENKINS_HOME="/var/jenkins_home"
export JENKINS_INCREMENTALS_REPO_MIRROR="https://repo.jenkins-ci.org/incrementals"
export COPY_REFERENCE_FILE_LOG="${JENKINS_HOME}/copy_reference_file.log"
export JENKINS_UC="https://updates.jenkins.io"
export JENKINS_SLAVE_AGENT_PORT=$agent_port
export JAVA_OPTS="-Djenkins.install.runSetupWizard=false -DJENKINS_HOME=${JENKINS_HOME}"
export JENKINS_UC="https://updates.jenkins.io"
export JENKINS_UC_EXPERIMENTAL="https://updates.jenkins.io/experimental"
export JENKINS_INCREMENTALS_REPO_MIRROR="https://repo.jenkins-ci.org/incrementals"
#
# # Create ENV variables used by scripts/groovy downstream
# grep -q JENKINS_SLAVE_AGENT_PORT /etc/environment || echo JENKINS_SLAVE_AGENT_PORT=${agent_port} >> /etc/environment
# grep -q COPY_REFERENCE_FILE_LOG /etc/environment || echo COPY_REFERENCE_FILE_LOG=${JENKINS_HOME}/copy_reference_file.log >> /etc/environment
# grep -q JAVA_OPTS /etc/environment || echo 'JAVA_OPTS="-Djenkins.install.runSetupWizard=false -DJENKINS_HOME=${JENKINS_HOME}"' >> /etc/environment
# grep -q JENKINS_UC /etc/environment || echo JENKINS_UC=https://updates.jenkins.io  >> /etc/environment
# grep -q JENKINS_UC_EXPERIMENTAL /etc/environment || echo JENKINS_UC_EXPERIMENTAL=https://updates.jenkins.io/experimental  >> /etc/environment
# grep -q JENKINS_INCREMENTALS_REPO_MIRROR /etc/environment || echo JENKINS_INCREMENTALS_REPO_MIRROR=https://repo.jenkins-ci.org/incrementals >> /etc/environment
