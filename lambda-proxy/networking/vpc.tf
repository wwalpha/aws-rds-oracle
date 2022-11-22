# ----------------------------------------------------------------------------------------------
# AWS VPC
# ----------------------------------------------------------------------------------------------
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = "rds-vpc"
  cidr                 = "10.10.0.0/16"
  azs                  = local.availability_zones
  public_subnets       = local.public_subnets_cidr_block
  private_subnets      = local.private_subnets_cidr_block
  enable_nat_gateway   = true
  enable_dns_hostnames = true
}
