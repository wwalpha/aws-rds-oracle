resource "aws_db_instance" "this" {
  allocated_storage            = 100
  identifier                   = "postgres-${var.suffix}"
  engine                       = "postgres"
  engine_version               = "14.5"
  instance_class               = "db.t3.medium"
  username                     = "adminuser"
  password                     = "Session10+"
  parameter_group_name         = "default.postgres14"
  db_subnet_group_name         = aws_db_subnet_group.this.name
  skip_final_snapshot          = true
  performance_insights_enabled = false
  storage_encrypted            = true
  copy_tags_to_snapshot        = true
  backup_retention_period      = 7

  lifecycle {
    ignore_changes = [
      latest_restorable_time
    ]
  }
}

