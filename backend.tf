terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "my-terraform-state-demo-1771308527"
    key            = "envs/prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}