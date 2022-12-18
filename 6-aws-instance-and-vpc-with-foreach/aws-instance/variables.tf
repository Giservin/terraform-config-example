variable "keyName" {
  description = "Key for instance"
  type = string
  default = "vockey"
}

variable "instances" {
  type = map(any)
  default = {
    AppOne : {
      instance_type : "t3.micro",
      subnet_number : "0"
    },
    AppTwo : {
      instance_type : "t2.micro",
      subnet_number : "1"
    }
  }
}