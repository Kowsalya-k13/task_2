resource "aws_dynamodb_table" "dynamodb-terraform-lock" {
   name = "kowsalya-terraform-lock"
   hash_key = "LockID"
   billing_mode = "PAY_PER_REQUEST"

   attribute {
      name = "LockID"
      type = "S"
   }
   tags = {
     Name = "Kowsalya Terraform Lock Table"
   }
}