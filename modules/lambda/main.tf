data "archive_file" "lambda" {
  type        = "zip"
  source_file = "./example/main.js"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "auth_lambda" {
  filename      = "lambda_function_payload.zip"
  function_name = "ServerlessExample"
  handler       = "main.handler"
  role          = "${aws_iam_role.iam_for_lambda.arn}"

  vpc_config {
    subnet_ids = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "nodejs18.x"
}

