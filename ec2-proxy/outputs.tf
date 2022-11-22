output "private_subnets_cidr_block" {
  value = module.networking.private_subnets_cidr_blocks
}

output "aws_db_proxy_endpoint" {
  value = module.database.aws_db_proxy.endpoint
}

output "aws_db_instance_id" {
  value = module.database.aws_rds_instance.id
}
