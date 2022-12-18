provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "web-sg" {
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

module "aws-instance-1" {
  source = "./modules/aws-instance"

  security_group_id = [aws_security_group.web-sg.id]
  resource_tags = {
    Name = "App Server 1.0"
  }
}

module "aws-instance-2" {
  source = "./modules/aws-instance"

  security_group_id = [aws_security_group.web-sg.id]
  resource_tags = {
    Name = "App Server 2.0"
  }
}