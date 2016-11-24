variable "aws_access_key" {
  description = "AWS access key"
}

variable "aws_secret_key" {
  description = "AWS secret access key"
}

variable "region" {
  description = "AWS region to host your network"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "10.128.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  default     = "10.128.0.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for private subnet"
  default     = "10.128.1.0/24"
}

variable "server_port" {
  description = "port to open in security group"
  default     = "9200"
}

/* ES AMIs for each region - according to - https://bitnami.com/stack/elasticsearch/cloud/aws */
variable "amis" {
  description = "Base AMI to launch the instances with"
  type = "map"
  default = {
    us-west-1 = "ami-c2105aa2"
    us-east-1 = "ami-85346e92"
    us-west-2 = "ami-2352f443"
    eu-central-1 = "ami-29a95246"
    ap-southeast-1 = "ami-4a0aab29"
    ap-southeast-2 = "ami-1b427e78"
    ap-northeast-1 = "ami-b83b99d9"
    ap-northeast-2 = "ami-a039edce"
    sa-east-1 = "ami-7a53cf16"
  }
}