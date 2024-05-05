variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  description = "cidr blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidr" {
  description = "cidr blocks for private subnets"
  type = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  description = "availability zones for public subnets"
  type        = list(string)
  default = [ "ap-south-1a", "ap-south-1b" ]
}

