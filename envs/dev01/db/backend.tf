terraform {
  backend "s3" {
    bucket         = "tf-state-testing-2025"
    key            = "envs/dev01/db/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "tf-state-locks"
    encrypt        = true
  }
}

