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

  security_group_id = [aws_security_group.web_sg.id]
  resource_tags = {
    Name = "With Moved"
  }
}

moved {
  from = aws_instance.web
  to = module.aws_instance_1.aws_instance.web
}

moved {
  from = aws_security_group.web-sg
  to = aws_security_group.web_sg
}