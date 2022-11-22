# resource "aws_db_security_group" "this" {
#   name = "rds_sg_${var.suffix}"

#   ingress {
#     cidr = var.private_subnet_ids[0]
#   }

#   ingress {
#     cidr = var.private_subnet_ids[1]
#   }
# }
