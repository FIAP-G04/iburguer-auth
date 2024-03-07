resource "aws_api_gateway_resource" "eks" {
  rest_api_id = aws_api_gateway_rest_api.api-gtw.id
  parent_id = aws_api_gateway_rest_api.api-gtw.root_resource_id
  path_part = "{proxy+}"
}

resource "aws_api_gateway_method" "eks" {
  rest_api_id = aws_api_gateway_rest_api.api-gtw.id
  resource_id = aws_api_gateway_resource.eks.id
  http_method = "ANY"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.proxy"           = true
    "method.request.header.Authorization" = true
  }
}

resource "aws_api_gateway_integration" "eks" {
  rest_api_id = aws_api_gateway_rest_api.api-gtw.id
  resource_id = aws_api_gateway_resource.eks.id
  http_method = "ANY"

  integration_http_method = "ANY"
  type = "HTTP_PROXY"
  uri = "http://${var.load_balancer_dns}/{proxy}"
  passthrough_behavior = "WHEN_NO_MATCH"
  content_handling = "CONVERT_TO_TEXT"

  request_parameters = {
    "integration.request.path.proxy"           = "method.request.path.proxy"
    "integration.request.header.Accept"        = "'application/json'"
    "integration.request.header.Authorization" = "method.request.header.Authorization"
  }

  connection_type = "VPC_LINK"
  connection_id = aws_api_gateway_vpc_link.vpc-link.id
}