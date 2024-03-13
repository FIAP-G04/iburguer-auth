prefix = "iburguer"
vpc_cidr_block = "10.0.0.0/16"
load_balancer_arn = "arn:aws:elasticloadbalancing:us-east-1:905418067917:listener/net/k8s-iburguer-iburguer-150a43b911/c443e55d133d18a2/5a9d4046f1dfd29d"
cognito_domain = "iburguer-auth-lambdas"

runtime = "dotnet8"

path_to_lambda_si = "./lambdas/IBurguer.Onboarding.SignIn/src/IBurguer.Onboarding.SignIn/bin/Release/lambda-publish"
output_path_si = "lambda_signin_payload.zip"
function_name_si = "iburguer-lambda-signin"
handler_si = "iBurguer.Onboarding.SignIn::iBurguer.Onboarding.SignIn.Function::FunctionHandler"

output_path_su = "lambda_signup_payload.zip"
path_to_lambda_su = "./lambdas/IBurguer.Onboarding.SignUp/src/IBurguer.Onboarding.SignUp/bin/Release/lambda-publish"
function_name_su = "iburguer-lambda-signup"
handler_su = "iBurguer.Onboarding.SignUp::iBurguer.Onboarding.SignUp.Function::FunctionHandler"