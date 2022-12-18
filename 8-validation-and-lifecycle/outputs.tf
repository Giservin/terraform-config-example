output "instance_public_dns_1" {
  value = "${module.aws_instance_1.instance_public_dns}/index.html"
}

output "instance_id" {
  value = module.aws_instance_1.instance_id
}