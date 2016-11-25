# Configure the AWS Provider
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.region}"
}
# VPC configuration
resource "aws_vpc" "es_vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
}

# Subnet configuration
resource "aws_subnet" "es_subnet" {
  vpc_id = "${aws_vpc.es_vpc.id}"
  cidr_block = "${var.public_subnet_cidr}"
}

# Lauch configuration to be used by the AutoScalling group.
resource "aws_launch_configuration" "es_asg_conf" {
  image_id = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.es_security_group.id}"]
  lifecycle {
    create_before_destroy = true
  }
}
# Lauching the ASG with configuration
resource "aws_autoscaling_group" "es_asg_cluster" {
  launch_configuration = "${aws_launch_configuration.es_asg_conf.id}"
  availability_zones = ["${data.aws_availability_zones.all.names}"]

  min_size = 3
  max_size = 3
}

# Security group configuration with rule
resource "aws_security_group" "es_security_group" {
  name = "es_security_group"
  vpc_id = "${aws_vpc.es_vpc.id}"
  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    lifecycle {
    create_before_destroy = true
  }
}

# Get availablity zones for ASG
data "aws_availability_zones" "all" {}