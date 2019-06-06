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
