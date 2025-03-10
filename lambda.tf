# Define the Lambda function
resource "aws_lambda_function" "blog_lambda" {
  function_name    = "blogLambdaFunction"
  package_type     = "Image"
  image_uri        = "${var.aws_account_id}.dkr.ecr.${var.region}.amazonaws.com/blog_python_lambda:latest"
  publish       = true
  timeout = 10

  # Define Lambda execution role
  role = aws_iam_role.lambda_exec_role.arn
  environment {
    variables = {
      DOC_DB_PROTOCOL = var.doc_db_protocol
      DOC_DB_PASS = var.doc_db_pass
      DOC_DB_USER = var.doc_db_user
      DOC_DB_HOST = var.doc_db_host
		}
	}
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# managed_policyのattachはこれで
resource "aws_iam_role_policy_attachments_exclusive" "managed_policy" {
  role_name      = aws_iam_role.lambda_exec_role.name
  policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/aws/lambda/${aws_lambda_function.blog_lambda.function_name}"
  retention_in_days = 30
}

resource "aws_lambda_permission" "api_gateway_invoke_blog2" {
  statement_id  = "AllowExecutionFromApiGateway2"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.blog_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.blog_api2.execution_arn}/*/*"
}

