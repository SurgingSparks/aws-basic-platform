terraform {
  backend "s3" {
    bucket         = "tf-state-testing-2025"
    key            = "envs/dev/network/terraform.tfstate"
    region         = "ap-southeast-2"
    use_lockfile = "tf-state-locks"
    encrypt        = true
  }
}