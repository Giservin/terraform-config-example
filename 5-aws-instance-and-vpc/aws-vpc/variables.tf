variable "VpcCidr" {
  description = "CIDR for VPC"
  type = string
  default = "10.0.0.0/20"
}

variable "publicSubnetCidr" {
  description = "CIDR for Public Subnet"
  type = string
  default = "10.0.0.0/24"
}

variable "privateSubnetCidr" {
  description = "CIDR for Private Subnet"
  type = string
  default = "10.0.1.0/24"
}

variable "dnsSupport" {
  description = "Whether the VPC want to automatically assign Public DNS to instance or not"
  type = bool
  default = true
}