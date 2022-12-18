provider "aws" {
  region = local.vpc_output.region
}

data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "../aws-vpc/terraform.tfstate"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

locals {
  vpc_output = data.terraform_remote_state.vpc.outputs
}

resource "aws_instance" "web_instance" {
  count = 2

  ami = data.aws_ami.amazon_linux.id
  key_name = var.keyName
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.vpc_output.security_group_id]

  subnet_id = local.vpc_output.subnet_id[count.index % length(local.vpc_output.subnet_id) ]

  tags = {
    Name : var.instance_name[count.index]
  }

}

