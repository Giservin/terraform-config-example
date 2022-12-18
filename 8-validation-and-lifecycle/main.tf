provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "web_sg" {
  name = "app-sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "aws_instance_1" {
  source = "./modules/aws-instance"

  instance_attribute = {
    security_group_id = [aws_security_group.web_sg.id]
    resource_tags = {
      Name = "With Moved"
    }
    instance_type = "t2.micro"
  }

}

data "aws_instance" "tes_postcondition" {
  instance_id = module.aws_instance_1.instance_id

  lifecycle {
    postcondition {
      condition = self.ebs_optimized == false
      error_message = "Please choose the instance that support EBS optimizing"
    }
  }
}