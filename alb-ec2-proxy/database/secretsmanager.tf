resource "aws_secretsmanager_secret" "this" {
  name = "demo/rdsproxy/postgresql"
}

resource "aws_secretsmanager_secret_version" "this" {
  depends_on = [aws_db_instance.this]
  secret_id  = aws_secretsmanager_secret.this.id
  secret_string = jsonencode({
    username             = var.database_username,
    password             = var.database_password,
    engine               = aws_db_instance.this.engine,
    host                 = aws_db_instance.this.address,
    port                 = aws_db_instance.this.port,
    dbInstanceIdentifier = aws_db_instance.this.identifier
  })
}
# aws rds describe-db-proxies --db-proxy-name progresql-proxy-c7865e23
# aws rds describe-db-proxy-target-groups --db-proxy-name progresql-proxy-c7865e23
