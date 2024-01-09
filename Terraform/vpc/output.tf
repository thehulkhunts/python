output "subnet-01" {
  value = aws_subnet.eks-public-subnet-01.id
}
output "subnet-02" {
  value = aws_subnet.eks-public-subnet-02.id
}
output "vpc_id" {
  value = aws_vpc.eks-vpc.id
}