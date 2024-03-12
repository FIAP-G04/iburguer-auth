variable "prefix" {}

#Gateway
variable "vpc_cidr_block" {}
variable "load_balancer_arn" {}

#Cognito
variable "cognito_domain" {}

#Lambda
variable "path_to_lambda" {}
variable "output_path" {}
variable "function_name" {}
variable "runtime" {}
variable "handler" {}

variable "output_path_auth" {}
variable "path_to_lambda_auth" {}