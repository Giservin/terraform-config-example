variable "private_ip" {
  description = "List of Private IP of an instances"
  type = list(string)
  default = ["10.138.10.60", "10.138.10.75"]
}