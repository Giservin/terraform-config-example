output "instance_public_dns" {
  value = aws_instance.web[0].public_dns
}

output "instance_id" {
  value = aws_instance.web[0].id
}