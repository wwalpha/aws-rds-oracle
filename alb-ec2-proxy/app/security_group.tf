# ----------------------------------------------------------------------------------------------
# AWS Security Group - Lambda Proxy
# ----------------------------------------------------------------------------------------------
# resource "aws_security_group" "lambda_proxy" {
#   name   = "lambda_proxy"
#   vpc_id = var.vpc_id

#   ingress {
#     from_port   = 5432
#     to_port     = 5432
#     protocol    = "tcp"
#     cidr_blocks = var.private_subnet_cidr_block
#   }
# }

# ----------------------------------------------------------------------------------------------
# AWS Security Group - EC2
# ----------------------------------------------------------------------------------------------
# resource "aws_security_group" "ec2" {
#   name   = "ec2_sg"
#   vpc_id = var.vpc_id

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port       = 5432
#     to_port         = 5432
#     protocol        = "tcp"
#     security_groups = [var.rds_proxy_sg_id]
#   }
# }
