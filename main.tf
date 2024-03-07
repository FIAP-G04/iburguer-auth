module "vpc" {
  source = "./modules/vpc"
  prefix = var.prefix
  vpc_cidr_block = var.vpc_cidr_block
}

module "lambda" {
  source = "./modules/lambda"
  subnet_ids = module.vpc.subnet_ids
  security_group_ids = module.vpc.security_group_id
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
}

output "base_url" {
  value = "${module.gateway.base_url}"
}