data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "web" {
  availability_zone = "us-east-1a"
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  user_data     = file("./modules/aws-instance/init-script.sh")
  key_name = "vockey"
  vpc_security_group_ids = var.security_group_id

  tags = var.resource_tags
}