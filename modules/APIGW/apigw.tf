resource "aws_apigatewayv2_api" "this" {
  name          = "api-gateway"
  protocol_type = "HTTP"
}
