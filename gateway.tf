resource "aws_api_gateway_rest_api" "api-gtw" {
  name = "ServerlessExample"
  description = "Terraform Serverless Application Example"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = "${aws_api_gateway_rest_api.api-gtw.id}"
  parent_id = "${aws_api_gateway_rest_api.api-gtw.root_resource_id}"
  path_part = "lambda"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id = "${aws_api_gateway_rest_api.api-gtw.id}"
  resource_id = "${aws_api_gateway_resource.proxy.id}"
  http_method = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
    rest_api_id = "${aws_api_gateway_rest_api.api-gtw.id}"
    resource_id = "${aws_api_gateway_method.proxy.resource_id}"
    http_method = "${aws_api_gateway_method.proxy.http_method}"

    integration_http_method = "POST"
    type = "AWS_PROXY"
    uri = "${aws_lambda_function.test_lambda.invoke_arn}"
}
/*
resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id = "${aws_api_gateway_rest_api.api-gtw.id}"
  resource_id = "${aws_api_gateway_rest_api.api-gtw.root_resource_id}"
  http_method = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_root" {
  rest_api_id = "${aws_api_gateway_rest_api.api-gtw.id}"
  resource_id = "${aws_api_gateway_method.proxy_root.resource_id}"
  http_method = "${aws_api_gateway_method.proxy_root.http_method}"

  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = "${aws_lambda_function.test_lambda.invoke_arn}"
}
*/
resource "aws_api_gateway_deployment" "api-gtw" {
  depends_on = [ 
    aws_api_gateway_integration.lambda
  ]

  rest_api_id = "${aws_api_gateway_rest_api.api-gtw.id}"
  stage_name = "test"
    
}

resource "aws_lambda_permission" "apigw" {
  statement_id = "AllowAPIGatewayInvoke"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.test_lambda.function_name}"
  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api-gtw.execution_arn}/*/*"
}

output "base_url" {
  value = "${aws_api_gateway_deployment.api-gtw.invoke_url}"
}