terraform {
  backend "s3" {
    bucket = "test-vashkevich"
    key    = "tf-demo/terraform.tfstate"
    region = "eu-central-1"
  }
}