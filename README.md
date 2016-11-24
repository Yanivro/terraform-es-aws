# terraform-es-aws


This will launch an AWS ASG ElasticSearch cluster Inside a VPC with an ELB in front and also create a security group that allows traffic only through port

This will create(using Terraform):

  1.An Autoscalling Group(ASG) with 3 nodes that have the elasticsearch aws image on them.

  2.A VPC to house the ASG.

  3.A Security Group that will allow tcp connections on the port specified.

  4.An Elastic Load Balancer(ELB) to load-balance the ASG.
  
