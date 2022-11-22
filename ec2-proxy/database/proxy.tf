resource "aws_db_proxy" "this" {
  name                   = "progresql-proxy-${var.suffix}"
  debug_logging          = false
  engine_family          = "POSTGRESQL"
  idle_client_timeout    = 5400
  require_tls            = false
  role_arn               = var.iam_role_arn_rds_proxy
  vpc_security_group_ids = [aws_security_group.rds_proxy.id]
  vpc_subnet_ids         = var.database_subnet_ids

  auth {
    auth_scheme = "SECRETS"
    iam_auth    = "DISABLED"
    secret_arn  = aws_secretsmanager_secret.this.arn
  }
}

resource "aws_db_proxy_default_target_group" "this" {
  db_proxy_name = aws_db_proxy.this.name

  connection_pool_config {
    connection_borrow_timeout    = 120
    init_query                   = "SET x=1, y=2"
    max_connections_percent      = 100
    max_idle_connections_percent = 50
    session_pinning_filters      = ["EXCLUDE_VARIABLE_SETS"]
  }
}

resource "aws_db_proxy_target" "this" {
  db_instance_identifier = aws_db_instance.this.id
  db_proxy_name          = aws_db_proxy.this.name
  target_group_name      = aws_db_proxy_default_target_group.this.name
}

# resource "aws_db_proxy_endpoint" "this" {
#   db_proxy_name          = aws_db_proxy.this.name
#   db_proxy_endpoint_name = "rds-proxy-endpoint"
#   vpc_subnet_ids         = var.database_subnet_ids
#   target_role            = "READ_ONLY"
# }
