# Create DynamoDB table for Terraform state locking
resource "aws_dynamodb_table" "lock_table" {
  name         = "${var.project}-lock-table"
  billing_mode = "PAY_PER_REQUEST"  # Serverless billing (no need to set capacity)
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "${var.project}-lock-table"
  }
}
