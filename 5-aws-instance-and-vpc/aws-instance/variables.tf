variable "keyName" {
  description = "Key for instance"
  type = string
  default = "vockey"
}

variable "instance_name" {
  type = list(string)
  default = ["App 1.0", "App 2.0"]
}