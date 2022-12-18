data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "web" {
  count = var.instance_count

  availability_zone = "us-east-1a"
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_attribute.instance_type
  user_data     = file("./modules/aws-instance/init-script.sh")
  key_name = "vockey"
  vpc_security_group_ids = var.instance_attribute.security_group_id

  tags = var.instance_attribute.resource_tags

  lifecycle {
    precondition {
      condition = var.instance_count < 2
      error_message = "Instance number is only limited to one"
    }
  }
}