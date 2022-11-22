# # ----------------------------------------------------------------------------------------------
# # Lambda Function - Cognito
# # ----------------------------------------------------------------------------------------------
# resource "aws_lambda_function" "rds_proxy" {
#   function_name     = "rds-proxy-${var.suffix}"
#   s3_bucket         = data.aws_s3_object.lambda_module.bucket
#   s3_key            = data.aws_s3_object.lambda_module.key
#   s3_object_version = data.aws_s3_object.lambda_module.version_id
#   handler           = "index.handler"
#   memory_size       = 128
#   role              = var.iam_role_arn_lambda_proxy
#   runtime           = "nodejs16.x"
#   timeout           = 10

#   vpc_config {
#     security_group_ids = [aws_security_group.lambda_proxy.id]
#     subnet_ids         = var.database_subnets
#   }
# }

# data "aws_s3_object" "lambda_module" {
#   bucket = var.lambda_module_bucket_name
#   key    = var.lambda_module_bucket_key
# }
