# ----------------------------------------------------------------------------------------------
# Lambda Function
# ----------------------------------------------------------------------------------------------
resource "aws_lambda_function" "app" {
  function_name     = "${var.prefix}-app"
  s3_bucket         = data.aws_s3_object.lambda_module.bucket
  s3_key            = data.aws_s3_object.lambda_module.key
  s3_object_version = data.aws_s3_object.lambda_module.version_id
  handler           = "index.handler"
  memory_size       = 128
  role              = var.iam_role_arn_lambda_app
  runtime           = "nodejs14.x"
  timeout           = 10

  vpc_config {
    security_group_ids = [module.app_sg.security_group_id]
    subnet_ids         = var.private_subnets
  }
}

data "aws_s3_object" "lambda_module" {
  bucket = var.lambda_module_bucket_name
  key    = var.lambda_module_bucket_key
}

# ---------------------------------------------------------------------------------------------
# API Gateway Permission
# ---------------------------------------------------------------------------------------------
resource "aws_lambda_permission" "app" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.app.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.this.execution_arn}/*/*/query"
}
