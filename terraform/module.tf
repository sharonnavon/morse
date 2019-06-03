module "us-east-1" {
  source = "./morse"
  region = "us-east-1"
  ami_ubuntu = "ami-0a313d6098716f372"
  key_name = "aws_ec2"
}

module "us-west-1" {
  source = "./morse"
  region = "us-west-1"
  ami_ubuntu = "ami-06397100adf427136"
  key_name = "aws_ec2_us-west-1"
}
