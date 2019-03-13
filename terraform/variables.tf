variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.

Example: ~/.ssh/terraform.pub
DESCRIPTION
  default = "~/.ssh/<redacted>"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-east-1"
}
# export TF_VAR_my_ip=`(dig +short myip.opendns.com @resolver1.opendns.com)`
variable "my_ip" {
}

variable "aws_vpc" {
  default = "<redacted>"
}

variable "aws_subnet" {
  default = "<redacted>"
}

variable "ssh_key_id" {
  default = "<redacted>"
}

# Ubuntu Precise 18.04 LTS (x64)
variable "aws_amis" {
  default = {
    us-east-1 = "ami-0ac019f4fcb7cb7e6"
    us-west-1 = "ami-063aa838bd7631e0b"
    us-west-2 = "ami-0bbe6b35405ecebdb"
  }
}
