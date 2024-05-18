prefix = "iburguer"
vpc_cidr_block = "10.0.0.0/16"
load_balancer_arn_menu = "arn:aws:elasticloadbalancing:us-east-1:905418067917:listener/net/k8s-iburguer-iburguer-8983812f58/fae40e2cbfdfb087/d589aaf212afb681"
load_balancer_arn_checkout = "arn:aws:elasticloadbalancing:us-east-1:905418067917:listener/net/k8s-iburguer-iburguer-77a26eac4b/b853bc26afabde5d/d8f84d3a43f8796f"
load_balancer_arn_shopping_cart = "arn:aws:elasticloadbalancing:us-east-1:905418067917:listener/net/k8s-iburguer-iburguer-c905cd4107/7134eb871f564c41/a18d1d1e140f7eb0"
load_balancer_arn_order = "arn:aws:elasticloadbalancing:us-east-1:905418067917:listener/net/k8s-iburguer-iburguer-04b713380c/3adf7e00bd31086b/5d2c17b3d35fe797"

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