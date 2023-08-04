resource "aws_api_gateway_rest_api" "gateway" {
  name = var.apigateway_name
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.gateway.id
  parent_id   = aws_api_gateway_rest_api.gateway.root_resource_id
  path_part   = "dynamo_lambda"
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.gateway.id
}

resource "aws_api_gateway_stage" "stage" {
  rest_api_id = aws_api_gateway_rest_api.gateway.id
  deployment_id = aws_api_gateway_deployment.deployment.id
  stage_name = "prod"
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.apigateway.arn
    format = "$context.requestId"
  }
}

#GET method
resource "aws_api_gateway_method" "method" {
  rest_api_id = aws_api_gateway_rest_api.gateway.id
  resource_id = aws_api_gateway_resource.resource.id 
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.gateway.id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = var.invoke_arn
}

resource "aws_api_gateway_method_response" "response" {
  rest_api_id = aws_api_gateway_rest_api.gateway.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

#OPTIONS Method for Cors
resource "aws_api_gateway_method" "gateway_options" {
  rest_api_id = aws_api_gateway_rest_api.gateway.id
  resource_id = aws_api_gateway_resource.resource.id 
  http_method = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration_options" {
  rest_api_id             = aws_api_gateway_rest_api.gateway.id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.gateway_options.http_method
  type                    = "MOCK"
  uri                     = var.invoke_arn
}

resource "aws_api_gateway_method_response" "response_options" {
  rest_api_id = aws_api_gateway_rest_api.gateway.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.gateway_options.http_method
  status_code = "200"
    response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
}

#Lambda permissions to invoke gateway
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "${aws_api_gateway_rest_api.gateway.execution_arn}/*/GET/${var.function_name}"
}

#Log group
resource "aws_cloudwatch_log_group" "apigateway" {
  name = "api_gateway_execution_logs_${aws_api_gateway_rest_api.gateway.id}"
}
