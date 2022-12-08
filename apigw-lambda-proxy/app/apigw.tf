# ---------------------------------------------------------------------------------------------
# API Gateway
# ---------------------------------------------------------------------------------------------
resource "aws_apigatewayv2_api" "this" {
  name          = "${var.prefix}-api"
  protocol_type = "HTTP"
}

# ---------------------------------------------------------------------------------------------
# API Gateway Stage
# ---------------------------------------------------------------------------------------------
resource "aws_apigatewayv2_stage" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = "$default"
  auto_deploy = true
}

# ---------------------------------------------------------------------------------------------
# API Gateway Integration 
# ---------------------------------------------------------------------------------------------
resource "aws_apigatewayv2_integration" "app" {
  api_id               = aws_apigatewayv2_api.this.id
  integration_type     = "AWS_PROXY"
  connection_type      = "INTERNET"
  description          = "Lambda example"
  integration_method   = "POST"
  integration_uri      = aws_lambda_function.app.invoke_arn
  passthrough_behavior = "WHEN_NO_MATCH"
}

# ---------------------------------------------------------------------------------------------
# API Gateway Route
# ---------------------------------------------------------------------------------------------
resource "aws_apigatewayv2_route" "app" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "GET /query"
  target    = "integrations/${aws_apigatewayv2_integration.app.id}"
}
