terraform {
  backend "s3" {
    bucket         = "baton-intern-kowsalya-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
  }
}
