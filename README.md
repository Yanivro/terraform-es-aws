# terraform-es-aws

**Prerequisites**
  1. You must create a key-pair in the region you would like to deploy this cluster.
  2. You must accept the terms and conditions of the marketplace AMI:
  
        Go to https://aws.amazon.com/marketplace/fulfillment?productId=5868b990-b461-4439-ace6-397670336b1c&ref_=dtl_psb_continue
        Click "Manual Launch" and then "Accept Software Terms" on the right-hand side.


**This will create(using Terraform):**
  1. An Autoscalling Group(ASG) with 3 nodes that have the elasticsearch aws image on them.
  2. A VPC to house the ASG.
  3. A Security Group that will allow tcp connections on the port specified.
  4. An Elastic Load Balancer(ELB) to load-balance the ASG.

