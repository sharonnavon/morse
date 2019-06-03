provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  region = "${var.region}"
}

resource "aws_vpc" "vpc_main" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags {
    Name = "vpc-${var.region}"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}
