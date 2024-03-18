resource "aws_apigatewayv2_route" "proxy-signin" {
  api_id = "${aws_apigatewayv2_api.api-gtw.id}"
  route_key = "POST /customers/signin"
  target = "integrations/${aws_apigatewayv2_integration.lambda-signin.id}"
}
resource "aws_apigatewayv2_integration" "lambda-signin" {
    api_id = "${aws_apigatewayv2_api.api-gtw.id}"

    integration_method = "POST"
    integration_type = "AWS_PROXY"
    integration_uri = "${var.lambda_signin_invoke_arn}"
}

resource "aws_lambda_permission" "apigw-signin" {
  statement_id = "AllowAPIGatewayInvoke"
  action = "lambda:InvokeFunction"
  function_name = "${var.lambda_signin_function_name}"
  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.api-gtw.execution_arn}/*/*"
}