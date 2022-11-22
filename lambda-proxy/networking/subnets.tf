# ----------------------------------------------------------------------------------------------
# AWS Subnet - database
# ----------------------------------------------------------------------------------------------
resource "aws_subnet" "database" {
  count             = length(local.database_availability_zones)
  vpc_id            = module.vpc.vpc_id
  cidr_block        = local.database_subnets_cidr_block[count.index]
  availability_zone = local.database_availability_zones[count.index]

  tags = {
    Name = format(
      "rds-database-%s",
      element(local.database_availability_zones, count.index),
    )
  }
}
