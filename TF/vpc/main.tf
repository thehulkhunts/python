resource "aws_vpc" "eks-vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "eks"
    Environment = "prod"
  }
}

resource "aws_subnet" "eks-public-subnet-01" {
  vpc_id = aws_vpc.eks-vpc.id
  cidr_block = var.subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = var.az_subnet-01

  tags = {
    Name = "subnet-01"
    Environment = "prod"
  }

}

resource "aws_subnet" "eks-public-subnet-02" {
  vpc_id = aws_vpc.eks-vpc.id
  cidr_block = var.subnet_cidr_02
  map_public_ip_on_launch = true
  availability_zone = var.az_subnet_02

  tags = {
    Name = "subnet-02"
    Environment = "prod"
  }
  
}

resource "aws_internet_gateway" "eks-igw" {
  vpc_id = aws_vpc.eks-vpc.id

  tags = {
    Name = "Eks-Igw"
    Environment = "prod"
  }
}

resource "aws_route_table" "eks-rt" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-igw.id
  }
  depends_on = [ aws_internet_gateway.eks-igw ]
}

resource "aws_route_table_association" "rt-subnet-01" {
  route_table_id = aws_route_table.eks-rt.id
  subnet_id = aws_subnet.eks-public-subnet-01.id
}

resource "aws_route_table_association" "rt-subnet-02" {
  route_table_id = aws_route_table.eks-rt.id
  subnet_id = aws_subnet.eks-public-subnet-02.id
}