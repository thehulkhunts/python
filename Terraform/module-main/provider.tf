provider "aws" {
  region                   = "ap-south-1"
  profile                  =  "vinay" 
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
    bucket = "viin-ultimate-bucket"  // name of your bucket choice
    key = "EKS/terraform.tfstate"   // key match to the path
    region = "us-east-1"  //region
    dynamodb_table = "vin-ultimate-db" // name of your dynamodb table 
  }
}