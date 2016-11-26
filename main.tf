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

# Internet gateway for the cluster.
resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.es_vpc.id}"
}

# Lauch configuration to be used by the AutoScalling group.
resource "aws_launch_configuration" "es_asg_conf" {
  image_id = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.es_security_group.id}"]
  key_name = "${var.key_name}"
  lifecycle {
    create_before_destroy = true
  }
}

# Lauching the ASG with configuration
resource "aws_autoscaling_group" "es_asg_cluster" {
  launch_configuration = "${aws_launch_configuration.es_asg_conf.id}"
  vpc_zone_identifier = ["${aws_subnet.es_subnet.id}"]
  min_size = 3
  max_size = 3
  load_balancers = ["${aws_elb.es_elb.name}"]
  health_check_type = "ELB"
}

# Security group configuration with rule for the nodes.
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

# Configure security group for the ELB
resource "aws_security_group" "elb_security_group" {
  name = "elb_security_group"
  vpc_id = "${aws_vpc.es_vpc.id}"
  ingress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# configure Elastic Load Balancer(ELB)
resource "aws_elb" "es_elb" {
  name = "es-elb"
  security_groups = ["${aws_security_group.elb_security_group.id}"]
  subnets = ["${aws_subnet.es_subnet.id}"]
listener {
    lb_port =  22
    lb_protocol = "http"
    instance_port = 22
    instance_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:${var.server_port}/"
  }

}

output "elb_dns_name" {
  value = "${aws_elb.es_elb.dns_name}"
}