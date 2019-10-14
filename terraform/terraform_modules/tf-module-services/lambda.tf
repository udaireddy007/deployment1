############### AWS Lambda #################

resource "aws_lambda_function" "aws_lambda_test_function" {
  s3_bucket     = "aws-lambda-test-bucket-${var.env}"
  s3_key        = "aws-lambda-test-function.zip"
  function_name = "aws-lambda-test-function-${var.env}"
  handler       = "index.handler"
  role          = "${aws_iam_role.aws__lambda_role.arn}"
  runtime       = "nodejs10.x"
  memory_size   = 128
  timeout       = 3

  environment {
    variables = {
      ENV        = "${var.env}"
    }
  }

  tags {
    BusinessUnit  = "BusinessUnit-Name"
    Application   = "${var.application}"
    "Charge Code" = "${var.charge_code}"
    Environment   = "${var.env}"
    Owner         = "${var.owner}"
  }
}
