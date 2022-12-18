variable "instance_name" {
  description = "Value of the Name tag for EC2 Instance"
  type = string
  default = "App Server 2.0"
}

variable "instance_type" {
  description = "Value of instance type"
  type = string
  default = "t2.micro"
}