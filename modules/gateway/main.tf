resource "aws_apigatewayv2_api" "api-gtw" {
  name = "iburguer"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "api-gtw" {
  api_id = aws_apigatewayv2_api.api-gtw.id

  name = "dev"
  auto_deploy = true
}

resource "aws_apigatewayv2_deployment" "api-gtw" {
  depends_on = [ 
    aws_apigatewayv2_integration.lambda,
    aws_apigatewayv2_integration.vpc-link-integration
  ]

  api_id = "${aws_apigatewayv2_api.api-gtw.id}"
}



