provider "aws" {
  profile = "vnay"
  region  = "ap-south-1"
}

terraform {
  required_version = ">=1.6.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.31.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "viin-ultimate-bucket"
    key = "bastion/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "vin-ultimate-db"
  }
}