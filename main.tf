module "vpc" {
  source = "./modules/vpc"
  prefix = var.prefix
}

module "lambda-signin" {
  source = "./modules/lambda"
  subnet_ids = concat(module.vpc.subnet_ids, module.vpc.private_subnet_ids)
  vpc_id = module.vpc.vpc_id
  prefix = var.prefix
  path_to_lambda = var.path_to_lambda_si
  output_path = var.output_path_si
  function_name = var.function_name_si
  runtime = var.runtime
  handler = var.handler_si
  cognito_client_id = module.cognito.pool_client_id
  cognito_user_pool_id = module.cognito.pool_id
}

module "lambda-signup" {
  source = "./modules/lambda"
  subnet_ids = concat(module.vpc.subnet_ids, module.vpc.private_subnet_ids)
  vpc_id = module.vpc.vpc_id
  prefix = var.prefix
  function_name = var.function_name_su
  runtime = var.runtime
  handler = var.handler_su
  output_path = var.output_path_su
  path_to_lambda = var.path_to_lambda_su
  cognito_client_id = module.cognito.pool_client_id
  cognito_user_pool_id = module.cognito.pool_id
}

/*
data "aws_lambda_function" "lambda-signin" {
  function_name = var.function_name_si
}

data "aws_lambda_function" "lambda-signup" {
  function_name = var.function_name_su
}
*/
module "gateway" {
  source = "./modules/gateway"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  prefix = var.prefix
  load_balancer_arn = var.load_balancer_arn

  cognito_endpoint = module.cognito.cognito_endpoint
  cognito_pool_client_id = module.cognito.pool_client_id
  
  lambda_signin_function_name = module.lambda-signin.function_name//data.aws_lambda_function.lambda-signin.function_name //
  lambda_signin_invoke_arn = module.lambda-signin.invoke_arn//data.aws_lambda_function.lambda-signin.invoke_arn //

  lambda_signup_function_name = module.lambda-signup.function_name//data.aws_lambda_function.lambda-signup.function_name //
  lambda_signup_invoke_arn = module.lambda-signup.invoke_arn//data.aws_lambda_function.lambda-signup.invoke_arn //module.lambda-signup.invoke_arn//
}

module "cognito" {
  source = "./modules/cognito"
  prefix = var.prefix
  cognito_domain = var.cognito_domain
}

output "cognito_user_pool_id" {
  value = module.cognito.pool_id
}

output "cognito_user_pool_client_id" {
  value = module.cognito.pool_client_id
}

output "base_url" {
  value = "${module.gateway.base_url}"
}
