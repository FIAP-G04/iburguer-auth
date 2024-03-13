variable "prefix" {}

#Gateway
variable "vpc_cidr_block" {}
variable "load_balancer_arn" {}

#Cognito
variable "cognito_domain" {}

#Lambda SignIn
variable "path_to_lambda_si" {}
variable "output_path_si" {}
variable "function_name_si" {}
variable "runtime" {}
variable "handler_si" {}

#Lambda Signup
variable "output_path_su" {}
variable "path_to_lambda_su" {}
variable "function_name_su" {}
variable "handler_su" {}