variable "image" {
  default = "ami-022d03f649d12a49d"
}
variable "instance_type" {
  type    = list(string)
  default = ["t2.medium", "t2.micro", "t2.large"]
}
