module "vpc" {
  source = "./modules/vpc"
  prefix = var.prefix
}

module "lambda" {
  source = "./modules/lambda"
  subnet_ids = module.vpc.subnet_ids
  vpc_id = module.vpc.vpc_id
  prefix = var.prefix
  path_to_lambda = var.path_to_lambda
  output_path = var.output_path
  function_name = var.function_name
  runtime = var.runtime
  handler = var.handler
}

module "lambda-auth" {
  source = "./modules/lambda"
  subnet_ids = module.vpc.subnet_ids
  vpc_id = module.vpc.vpc_id
  prefix = var.prefix
  function_name = "iburguer-auth-lambda"
  runtime = var.runtime
  handler = var.handler
  output_path = var.output_path_auth
  path_to_lambda = var.path_to_lambda_auth
}

module "gateway" {
  source = "./modules/gateway"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  lambda_function_name = module.lambda.function_name
  lambda_invoke_arn = module.lambda.invoke_arn
  prefix = var.prefix
  load_balancer_arn = var.load_balancer_arn
  auth_lambda_invoke_arn = module.lambda-auth.invoke_arn
  auth_lambda_function_name = module.lambda-auth.function_name
}

module "cognito" {
  source = "./modules/cognito"
  prefix = var.prefix
  cognito_domain = var.cognito_domain
}

output "base_url" {
  value = "${module.gateway.base_url}"
}
