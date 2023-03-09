provider "aws" { 
    region = "us-east-2"
}

provider "aws" {
    alias = "acm"
    region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "ey-resume-tfstate"
    key = "global/s3/terraform.terraform.tfstate"
    region = "us-east-2"

    dynamodb_table = "terraform"
    encrypt = true
  }
}