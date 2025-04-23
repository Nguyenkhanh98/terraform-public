terraform {
  backend "s3" {
    bucket         = "onair-tf"
    key            = "prod/terraform-public.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-lock-2"
  }
}