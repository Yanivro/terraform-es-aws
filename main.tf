# Configure the AWS Provider
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.region}"
}

resource "aws_instance" "es_node" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.es_security_group.id}"]

}

resource "aws_launch_configuration" "es_asg_conf" {
  image_id = "ami-2d39803a"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.es_security_group.id}"]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "es_asg_cluster" {
  launch_configuration = "${aws_launch_configuration.es_asg_conf.id}"
  availability_zones = ["${data.aws_availability_zones.all.names}"]

  min_size = 3
  max_size = 3
}

resource "aws_vpc" "es_vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
}
resource "aws_security_group" "es_security_group" {
  name = "es_security_group"
  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    vpc_id = "${aws_vpc.es_vpc.id}"
  }
    lifecycle {
    create_before_destroy = true
  }
}

data "aws_availability_zones" "all" {}