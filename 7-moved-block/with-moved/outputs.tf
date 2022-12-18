output "instance_public_dns_1" {
  value = "${module.aws-instance-1.instance_public_dns}/index.html"
}

output "instance_public_dns_2" {
  value = "${module.aws-instance-2.instance_public_dns}/index.html"
}