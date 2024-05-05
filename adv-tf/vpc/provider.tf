provider "aws" {
  region  = "ap-south-1"
  profile = "vinay"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.41.0"
    }
  }
}