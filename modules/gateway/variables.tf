variable "vpc_id" {}
variable "subnet_ids" {}
variable "private_subnet_ids" {}
variable "prefix" {}

variable "load_balancer_arn_menu" {}
variable "load_balancer_arn_checkout" {}
variable "load_balancer_arn_shopping_cart" {}
variable "load_balancer_arn_order" {}

variable "cognito_pool_client_id" {}
variable "cognito_endpoint" {}

variable "lambda_signin_invoke_arn" {}
variable "lambda_signin_function_name" {}

variable "lambda_signup_invoke_arn" {}
variable "lambda_signup_function_name" {}