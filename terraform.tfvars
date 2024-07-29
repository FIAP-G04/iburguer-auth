prefix = "iburguer"
vpc_cidr_block = "10.0.0.0/16"
load_balancer_arn_menu = "arn:aws:elasticloadbalancing:us-east-1:905418067917:listener/net/k8s-iburguer-iburguer-18c6cdeb5e/0a94c72513610875/b3e715a23b6eb8f9"
load_balancer_arn_checkout = "arn:aws:elasticloadbalancing:us-east-1:905418067917:listener/net/k8s-iburguer-iburguer-8e1bb74900/2e2d2f8da2c999e4/bd02af3d5faf4e58"
load_balancer_arn_shopping_cart = "arn:aws:elasticloadbalancing:us-east-1:905418067917:listener/net/k8s-iburguer-iburguer-410ea2a92d/4f11c37567af1178/95153a368507010b"
load_balancer_arn_order = "arn:aws:elasticloadbalancing:us-east-1:905418067917:listener/net/k8s-iburguer-iburguer-110ee5a817/2ca4c3bd6b000944/b2e3860957f010de"

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

output_path_disable = "lambda_disable_payload.zip"
path_to_lambda_disable = "./lambdas/IBurguer.Onboarding.Disable/src/IBurguer.Onboarding.Disable/bin/Release/lambda-publish"
function_name_disable = "iburguer-lambda-disable"
handler_disable = "iBurguer.Onboarding.Disable::iBurguer.Onboarding.Disable.Function::FunctionHandler"