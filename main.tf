# Configure the AWS Provider
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.region}"
}

resource "aws_instance" "es-node" {
  ami = "ami-2d39803a"
  instance_type = "t2.micro"
}