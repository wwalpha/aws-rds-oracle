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
