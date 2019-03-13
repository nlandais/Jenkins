# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
}

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "jenkins" {
  name        = "jenkins"
  description = "Used to secure the Jenkins instance"
  vpc_id      = "${var.aws_vpc}"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    # The default username for our AMI
    user = "ubuntu"
  }

  instance_type = "t2.micro"

  # Lookup the correct AMI based on the region
  # we specified
  ami = "${lookup(var.aws_amis, var.aws_region)}"
  key_name = "${var.ssh_key_id}"
  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.jenkins.id}"]
  subnet_id = "${var.aws_subnet}"

  # Provisioner the instance and run admin/install tasks.
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt install -y apt-transport-https ca-certificates curl software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable'",
      "sudo apt update",
      "apt-cache policy docker-ce",
      "sudo apt install -y docker-ce",
      "sudo gpasswd -a $USER docker"
    ]
  }

  # Create the Docker image and start Jenkins.
  provisioner "remote-exec" {
    inline = [
      "git clone https://github.com/nlandais/Jenkins.git",
      "cd Jenkins",
      "docker build -t nic-jenkins:latest .",
      "docker run -d --name nic-jenkins -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home nic-jenkins:latest"
    ]
  }
}
