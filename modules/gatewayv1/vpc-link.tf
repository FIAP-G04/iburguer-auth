resource "aws_api_gateway_vpc_link" "vpc-link" {
  name = "vpc-link-eks"
  target_arns = [ var.load_balancer_arn ]
}