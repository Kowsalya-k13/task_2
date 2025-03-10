resource "aws_iam_role" "s3_read_only_role" {
  name = "KowsalyaS3ReadOnlyRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:sts::130759691668:assumed-role/AWSReservedSSO_TEAM-Restricted-Admin-DevOps_cad15f5d13cce357/kowsalya.kumar@batonsystems.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy_attachment" "s3_read_only_attachment" {
  name       = "kowsalya-s3-readonly-attachment"
  roles      = [aws_iam_role.s3_read_only_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
