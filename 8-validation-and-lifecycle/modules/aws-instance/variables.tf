variable "instance_attribute" {
  description = "all attributes of instance"
  type = object({
    security_group_id = list(string)
    resource_tags = optional(map(string))
    instance_type = string
  })

  validation {
    condition = var.instance_attribute.resource_tags["Name"] == lower(var.instance_attribute.resource_tags["Name"])
    error_message = "Please ensure the name is in lowercase!"
  }
}

variable "instance_count" {
  description = "Count of Instances"
  type = number
}