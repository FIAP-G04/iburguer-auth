resource "aws_apigatewayv2_route" "proxy" {
  api_id = "${aws_apigatewayv2_api.api-gtw.id}"
  route_key = "GET /lambda"
  target = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}
resource "aws_apigatewayv2_integration" "lambda" {
    api_id = "${aws_apigatewayv2_api.api-gtw.id}"

    integration_method = "POST"
    integration_type = "AWS_PROXY"
    integration_uri = "${var.lambda_invoke_arn}"
}

resource "aws_lambda_permission" "apigw" {
  statement_id = "AllowAPIGatewayInvoke"
  action = "lambda:InvokeFunction"
  function_name = "${var.lambda_function_name}"
  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.api-gtw.execution_arn}/*/*"
}