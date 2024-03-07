resource "aws_api_gateway_rest_api" "api-gtw" {
  name = "${var.prefix}-gateway"
  endpoint_configuration {
    types = [ "REGIONAL" ]
  }
}