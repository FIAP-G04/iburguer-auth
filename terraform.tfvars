prefix = "iburguer"
vpc_cidr_block = "10.0.0.0/16"
load_balancer_arn_menu = "arn:aws:elasticloadbalancing:us-east-1:905418067917:listener/net/k8s-iburguer-iburguer-b89cc2f88a/09e01980480e7b56/3acf4bfcad1d39db"
load_balancer_arn_checkout = "arn:aws:elasticloadbalancing:us-east-1:905418067917:listener/net/k8s-iburguer-iburguer-b89cc2f88a/09e01980480e7b56/3acf4bfcad1d39db"
load_balancer_arn_shopping_cart = "arn:aws:elasticloadbalancing:us-east-1:905418067917:listener/net/k8s-iburguer-iburguer-998bd3e6d1/a395bd4887fae335/8d796f98c59cad0a"
load_balancer_arn_order = "arn:aws:elasticloadbalancing:us-east-1:905418067917:listener/net/k8s-iburguer-iburguer-b89cc2f88a/09e01980480e7b56/3acf4bfcad1d39db"

cognito_totem_domain = "iburguer-auth-totem"
cognito_admin_domain = "iburguer-auth-admin"

runtime = "dotnet8"

path_to_lambda_si = "./lambdas/IBurguer.Onboarding.SignIn/src/IBurguer.Onboarding.SignIn/bin/Release/lambda-publish"
output_path_si = "lambda_signin_payload.zip"
function_name_si = "iburguer-lambda-signin"
handler_si = "iBurguer.Onboarding.SignIn::iBurguer.Onboarding.SignIn.Function::FunctionHandler"

output_path_su = "lambda_signup_payload.zip"
path_to_lambda_su = "./lambdas/IBurguer.Onboarding.SignUp/src/IBurguer.Onboarding.SignUp/bin/Release/lambda-publish"
function_name_su = "iburguer-lambda-signup"
handler_su = "iBurguer.Onboarding.SignUp::iBurguer.Onboarding.SignUp.Function::FunctionHandler"