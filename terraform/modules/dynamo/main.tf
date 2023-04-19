# resource "aws_dynamodb_table" "terraform_locks" {
#   name         = var.table_name
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

resource "aws_dynamodb_table" "website_counter" {
  name         = var.table_name
  billing_mode = "PROVISIONED"
  read_capacity = 2
  write_capacity = 2
  hash_key     = "record_id"
  
  point_in_time_recovery {
    enabled = false
  }

  attribute {
    name = "record_id"
    type = "S"  #string
  }
}