resource "aws_apigatewayv2_authorizer" "authorizer" {
  api_id = aws_apigatewayv2_api.api-gtw.id
  authorizer_type = "REQUEST"
  authorizer_uri = var.auth_lambda_invoke_arn
  identity_sources = [ "$request.header.Authorization" ]
  name = "${var.prefix}-gateway-authorizer"
  authorizer_payload_format_version = "2.0"
}

resource "aws_lambda_permission" "apigw-auth" {
  statement_id = "AllowAPIGatewayInvoke"
  action = "lambda:InvokeFunction"
  function_name = "${var.auth_lambda_function_name}"
  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.api-gtw.execution_arn}/*/*"
}