# ----------------------------------------------------------------------------------------------
# AWS Security Group - Lambda Proxy
# ----------------------------------------------------------------------------------------------
resource "aws_security_group" "lambda_proxy" {
  name        = "lambda_proxy"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.private_subnet_cidr_block
  }
}
