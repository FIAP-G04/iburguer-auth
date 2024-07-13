variable "prefix" {}

#Gateway
variable "vpc_cidr_block" {}
variable "load_balancer_arn_menu" {}
variable "load_balancer_arn_checkout" {}
variable "load_balancer_arn_shopping_cart" {}
variable "load_balancer_arn_order" {}

#Cognito
variable "cognito_totem_domain" {}
variable "cognito_admin_domain" {}

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

#Lambda Disable
variable "output_path_disable" {}
variable "path_to_lambda_disable" {}
variable "function_name_disable" {}
variable "handler_disable" {}