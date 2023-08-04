data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "dynamo_lambda" {
  name        = "dynamo_lambda"
  description = "Policy for our lambda to have dynamo access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:GetItem",
          "dynamodb:UpadteItem",
          "dynamodb:Query",
          "dynamodb:PutItem",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dynamo_lambda_policy" {
  role = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.dynamo_lambda.arn
}

resource "aws_lambda_function" "lambda" {
  filename      = "../../counter/dynamo.zip" #var.filename and zip file
  function_name = "dynamo_lambda" #var.name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "dynamo_counter.handler"

  runtime = "python3.7"

}
