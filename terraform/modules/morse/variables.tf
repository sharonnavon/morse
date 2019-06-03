variable "region" {}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "key_name" {}

variable "instance_username" {
  default = "ubuntu"
}
variable "ami_ubuntu" {}

variable "servers_per_az" {
  default = 1
}
