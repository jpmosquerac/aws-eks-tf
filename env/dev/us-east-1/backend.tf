terraform {
  backend "s3" {
    bucket         = "terraform-state-231112207161"
    key            = "terraform-state"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}