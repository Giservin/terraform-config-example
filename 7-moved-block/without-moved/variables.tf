variable "security_group_id" {
  description = "List ID of Security Group"
  type = list(string)
  default = []
}

variable "resource_tags" {
  description = "Instance Name"
  type = map(string)
  default = {}
}