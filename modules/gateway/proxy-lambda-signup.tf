resource "aws_apigatewayv2_route" "proxy-signup" {
  api_id = "${aws_apigatewayv2_api.api-gtw.id}"
  route_key = "POST /signup"
  target = "integrations/${aws_apigatewayv2_integration.lambda-signup.id}"
}
resource "aws_apigatewayv2_integration" "lambda-signup" {
    api_id = "${aws_apigatewayv2_api.api-gtw.id}"

    integration_method = "POST"
    integration_type = "AWS_PROXY"
    integration_uri = "${var.lambda_signup_invoke_arn}"
}

resource "aws_lambda_permission" "apigw-signup" {
  statement_id = "AllowAPIGatewayInvoke"
  action = "lambda:InvokeFunction"
  function_name = "${var.lambda_signup_function_name}"
  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.api-gtw.execution_arn}/*/*"
}