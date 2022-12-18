output "vpc_id" {
  value = aws_vpc.VPC.id
}

output "subnet_id" {
  value = [ aws_subnet.PublicSubnet.id, aws_subnet.PrivateSubnet.id ]
}

output "security_group_id" {
  value = aws_security_group.webSG.id
}

output "region" {
  value = data.aws_region.current.name
}