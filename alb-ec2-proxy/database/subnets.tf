resource "aws_db_subnet_group" "this" {
  name       = "rds-subnets-${var.suffix}"
  subnet_ids = var.database_subnet_ids
}
