output "private_subnets_cidr_block" {
  value = module.networking.private_subnets_cidr_blocks
}

output "aws_db_proxy_endpoint" {
  value = module.database.aws_rds_proxy.endpoint
}

output "aws_db_endpoint" {
  value = module.database.aws_rds_instance.address
}

output "aws_db_instance_id" {
  value = module.database.aws_rds_instance.id
}

# aws rds describe-db-proxies --db-proxy-name progresql-proxy-c7865e23

# aws rds describe-db-proxy-target-groups --db-proxy-name progresql-proxy-c7865e23

# psql -h postgres-c7865e23.c71cbtvdqkpj.ap-northeast-1.rds.amazonaws.com -U adminuser

# psql -h progresql-proxy-c7865e23.proxy-c71cbtvdqkpj.ap-northeast-1.rds.amazonaws.com -U adminuser
