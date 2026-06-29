terraform {
  backend "s3" {
    bucket = "terraform-state-gatus"
    key    = "persistent/terraform.tfstate"
    region = "eu-west-2"
    use_lockfile = true
  }
}