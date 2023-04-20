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

resource "aws_lambda_function" "lambda" {
  filename      = "../../counter/dynamo.zip" #var.filename and zip file
  function_name = "dynamo_lambda" #var.name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "dynamo_counter.handler"

  runtime = "python3.7"

}

## need to add these to an iam role and remove full access policy
            #   - Effect: Allow
            #     Action:
            #       - "dynamodb:GetItem"
            #       - "dynamodb:UpdateItem"
            #       - "dynamodb:Query"
            #       - "dynamodb:PutItem"