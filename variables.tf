variable "aws_access_key" {
  description = "AWS access key"
}

variable "aws_secret_key" {
  description = "AWS secret access key"
}

variable "region" {
  description = "AWS region to host your network"
  default     = "eu-central-1"
}

variable "key_name" {
  description = "The key pair name to use for the nodes"
  default     = "es_key"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "10.128.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR for public subnet"
  default     = "10.128.0.0/24"
}

variable "instance_ips" {
  type = "map"
  default = {
    "0" = "10.128.0.5"
    "1" = "10.128.0.6"
    "2" = "10.128.0.7"
  }
}

variable "server_port" {
  description = "port to open in security group"
  default     = "9200"
}

variable "cdir_restrict" {
  description = "cdir block for IP restrcition access"
  default     = "0.0.0.0/0"
}

/* ES AMIs for each region from the AWS Marketplace
 (You must accept the terms and conditions in the marketplace ONCE in order to launch this images)*/
variable "amis" {
  description = "Base AMI to launch the instances with"
  type = "map"
  default = {
    us-east-1 = "ami-18257d0f"
    us-east-2 = "ami-b02379d5"
    us-west-1 = "ami-bdeda6dd"
    us-west-2 = "ami-57d77137"
    eu-central-1 = "ami-5c5ba333"
    eu-west-1 = "ami-bbade6c8"
    ap-south-1 = "ami-19b7c376"
    ap-southeast-1 = "ami-2859f84b"
    ap-southeast-2 = "ami-f0724e93"
    ap-northeast-1 = "ami-051bb864"
    ap-northeast-2 = "ami-643ce80a"
    sa-east-1 = "ami-e9bf2385"
  }
}