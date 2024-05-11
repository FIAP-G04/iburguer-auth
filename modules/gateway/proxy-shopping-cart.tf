resource "aws_apigatewayv2_integration" "vpc-link-integration-shopping-cart" {
  api_id = aws_apigatewayv2_api.api-gtw.id

  request_parameters = {
    "overwrite:path"           = "/$request.path.proxy"
  }

  integration_uri =  var.load_balancer_arn_shopping_cart
  integration_type = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type = "VPC_LINK"
  connection_id = aws_apigatewayv2_vpc_link.vpc-link-eks.id
}

resource "aws_apigatewayv2_route" "iburguer-route-shopping-cart" {
  api_id = aws_apigatewayv2_api.api-gtw.id

  authorizer_id = aws_apigatewayv2_authorizer.cognito-authorizer.id
  authorization_type = "JWT"
  
  route_key = "ANY /iburguer/shopping-cart/{proxy+}"
  target = "integrations/${aws_apigatewayv2_integration.vpc-link-integration-shopping-cart.id}"
}