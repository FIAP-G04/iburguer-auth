prefix = "iburguer"
vpc_cidr_block = "10.0.0.0/16"
load_balancer_arn_menu = "arn:aws:elasticloadbalancing:us-east-1:905418067917:listener/net/k8s-iburguer-iburguer-dc9d605dc6/31594ec0e3c961e6/7c3311c069565aa2"
load_balancer_arn_checkout = "arn:aws:elasticloadbalancing:us-east-1:905418067917:listener/net/k8s-iburguer-iburguer-d307b3e45a/92229e707ce62b17/3a8d9535966fe76d"
load_balancer_arn_shopping_cart = "arn:aws:elasticloadbalancing:us-east-1:905418067917:listener/net/k8s-iburguer-iburguer-ec4558a6fe/91589e4be222a9a3/6c181253cbc40d71"
load_balancer_arn_order = "arn:aws:elasticloadbalancing:us-east-1:905418067917:listener/net/k8s-iburguer-iburguer-70ec6374cf/a49432662f01b272/a65ddce0de8da85a"

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