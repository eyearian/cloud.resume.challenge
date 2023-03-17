resource "aws_apigatewayv2_api" "website" {
  name = var.apigateway_name
  protocol_type = "HTTP"
}