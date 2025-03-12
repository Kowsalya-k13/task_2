resource "aws_iam_role" "s3_read_only_role" {
  name = "KowsalyaS3ReadOnlyRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::130759691668:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_TEAM-Devops-Test-Account-Admin_0fe54fc37b81e061"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy_attachment" "s3_read_only_attachment" {
  name       = "kowsalya-s3-readonly-attachment"
  roles      = [aws_iam_role.s3_read_only_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"

  lifecycle {
    ignore_changes = [roles]
  }
}
