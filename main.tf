# Configure the AWS Provider
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.region}"
}

resource "aws_instance" "es-node" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
}