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
  cognito_client_id = module.cognito-totem.pool_client_id
  cognito_user_pool_id = module.cognito-totem.pool_id
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
  cognito_client_id = module.cognito-totem.pool_client_id
  cognito_user_pool_id = module.cognito-totem.pool_id
}

module "lambda-disable" {
  source = "./modules/lambda"
  subnet_ids = concat(module.vpc.subnet_ids, module.vpc.private_subnet_ids)
  vpc_id = module.vpc.vpc_id
  prefix = var.prefix
  function_name = var.function_name_disable
  runtime = var.runtime
  handler = var.handler_disable
  output_path = var.output_path_disable
  path_to_lambda = var.path_to_lambda_disable
  cognito_client_id = module.cognito-totem.pool_client_id
  cognito_user_pool_id = module.cognito-totem.pool_id
}

module "gateway-totem" {
  source = "./modules/gateway-base"

  gateway_name = "totem-gateway"
  gateway_stage = "iburguer-totem"
  gateway_routes = [ 
  // Menu  
  {
    route = "/api/menu/categories"
    method = "GET"
    load_balancer_arn = var.load_balancer_arn_menu
  }, {
    route = "/api/menu/items"
    method = "GET"
    load_balancer_arn = var.load_balancer_arn_menu
  }, 
  // Shopping Cart
  {
    route = "/api/carts/{shoppingCartId}"
    method = "GET"
    load_balancer_arn = var.load_balancer_arn_shopping_cart
  }, {
    route = "/api/carts"
    method = "POST"
    load_balancer_arn = var.load_balancer_arn_shopping_cart
  }, {
    route = "/api/carts/anonymous"
    method = "POST"
    load_balancer_arn = var.load_balancer_arn_shopping_cart
  }, {
    route = "/api/carts/{shoppingCartId}/items"
    method = "POST"
    load_balancer_arn = var.load_balancer_arn_shopping_cart
  }, {
    route = "/api/carts/{shoppingCartId}/items"
    method = "DELETE"
    load_balancer_arn = var.load_balancer_arn_shopping_cart
  }, {
    route = "/api/carts/{shoppingCartId}/items/{cartItemId}"
    method = "DELETE"
    load_balancer_arn = var.load_balancer_arn_shopping_cart
  }, {
    route = "/api/carts/{shoppingCartId}/item/{cartItemId}/decremented"
    method = "PATCH"
    load_balancer_arn = var.load_balancer_arn_shopping_cart
  }, {
    route = "/api/carts/{shoppingCartId}/items/{cartItemId}/incremented"
    method = "PATCH"
    load_balancer_arn = var.load_balancer_arn_shopping_cart
  }, {
    route = "/api/carts/{shoppingCartId}/checkout"
    method = "PATCH"
    load_balancer_arn = var.load_balancer_arn_shopping_cart
  } ]

  gateway_lambdas = [ {
    route = "POST /signin"
    lambda_invoke_arn = module.lambda-signin.invoke_arn
    function_name = module.lambda-signin.function_name
  }, {
    route = "POST /signup"
    lambda_invoke_arn = module.lambda-signup.invoke_arn
    function_name = module.lambda-signup.function_name
  }, {
    route = "POST /disable"
    lambda_invoke_arn = module.lambda-disable.invoke_arn
    function_name = module.lambda-disable.function_name
  }]

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  prefix = var.prefix

  use_cognito = true
  cognito_endpoint = module.cognito-totem.cognito_endpoint
  cognito_pool_client_id = module.cognito-totem.pool_client_id
}

module "gateway-admin" {
  source = "./modules/gateway-base"

  gateway_name = "admin-gateway"
  gateway_stage = "iburguer-admin"
  gateway_routes = [ 
  // Menu  
  {
    route = "/api/menu/items"
    method = "GET"
    load_balancer_arn = var.load_balancer_arn_menu
  }, {
    route = "/api/menu/items/{id}"
    method = "GET"
    load_balancer_arn = var.load_balancer_arn_menu
  }, {
    route = "/api/menu/items"
    method = "POST"
    load_balancer_arn = var.load_balancer_arn_menu
  }, {
    route = "/api/menu/items/{id}"
    method = "PUT"
    load_balancer_arn = var.load_balancer_arn_menu
  }, {
    route = "/api/menu/items/{id}"
    method = "DELETE"
    load_balancer_arn = var.load_balancer_arn_menu
  }, {
    route = "/api/menu/items/{id}/enabled"
    method = "PATCH"
    load_balancer_arn = var.load_balancer_arn_menu
  }, {
    route = "/api/menu/items/{id}/disabled"
    method = "PATCH"
    load_balancer_arn = var.load_balancer_arn_menu
  }, 
  // Orders
  {
    route = "/api/orders"
    method = "GET"
    load_balancer_arn = var.load_balancer_arn_order
  }, {
    route = "/api/orders"
    method = "POST"
    load_balancer_arn = var.load_balancer_arn_order
  }, {
    route = "/api/orders/{id}/canceled"
    method = "PATCH"
    load_balancer_arn = var.load_balancer_arn_order
  }, {
    route = "/api/orders/{id}/completed"
    method = "PATCH"
    load_balancer_arn = var.load_balancer_arn_order
  }, {
    route = "/api/orders/{id}/confirmed"
    method = "PATCH"
    load_balancer_arn = var.load_balancer_arn_order
  }, {
    route = "/api/orders/{id}/delivered"
    method = "PATCH"
    load_balancer_arn = var.load_balancer_arn_order
  }, {
    route = "/api/orders/{id}/started"
    method = "PATCH"
    load_balancer_arn = var.load_balancer_arn_order
  } ]

  gateway_lambdas = [  ]

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  prefix = var.prefix

  //use_cognito = true
  cognito_endpoint = module.cognito-admin.cognito_endpoint
  cognito_pool_client_id = module.cognito-admin.pool_client_id
}

module "gateway-payments" {
  source = "./modules/gateway-base"

  gateway_name = "payments-gateway"
  gateway_stage = "iburguer-payments"
  gateway_routes = [ 
  // Payments  
  {
    route = "/api/payments"
    method = "POST"
    load_balancer_arn = var.load_balancer_arn_checkout
  }, {
    route = "/api/payments/{id}/confirmed"
    method = "PATCH"
    load_balancer_arn = var.load_balancer_arn_checkout
  }, {
    route = "/api/payments/{id}/refused"
    method = "PATCH"
    load_balancer_arn = var.load_balancer_arn_checkout
  } ]

  gateway_lambdas = [  ]

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  prefix = var.prefix
}

module "cognito-totem" {
  source = "./modules/cognito"
  prefix = "${var.prefix}-totem"
  cognito_domain = var.cognito_totem_domain
}

module "cognito-admin" {
  source = "./modules/cognito"
  prefix = "${var.prefix}-admin"
  cognito_domain = var.cognito_admin_domain
}

output "cognito_totem_user_pool_id" {
  value = module.cognito-totem.pool_id
}

output "cognito_totem_user_pool_client_id" {
  value = module.cognito-totem.pool_client_id
}

output "cognito_admin_user_pool_id" {
  value = module.cognito-admin.pool_id
}

output "cognito_admin_user_pool_client_id" {
  value = module.cognito-admin.pool_client_id
}

output "base_url_totem" {
  value = "${module.gateway-totem.base_url}"
}

output "base_url_admin" {
  value = "${module.gateway-admin.base_url}"
}

output "base_url_payments" {
  value = "${module.gateway-payments.base_url}"
}
