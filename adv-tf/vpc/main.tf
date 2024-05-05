resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "EKS_VPC"
    Environment = "prod"
  }
}

resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name        = "public_subnets"
    Environment = "prod"
  }
}

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "vpc_igw"
    Environment="prod"
  }
}

resource "aws_route_table" "public_rt_assoc" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }

  tags = {
    Name = "public_route_table"
    Environment = "prod"
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
   count =  length(var.public_subnets_cidr)
   subnet_id = element(aws_subnet.public_subnets.*.id, count.index)
   route_table_id = aws_route_table.public_rt_assoc.id
}


resource "aws_subnet" "private_subnets" {
  vpc_id = aws_vpc.main.id
  count = length(var.private_subnets_cidr)
  cidr_block = element(var.private_subnets_cidr, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "private_subnets"
    Environment = "prod"
  }
}

resource "aws_eip" "nateip_1" {
  count = 2
  depends_on = [ aws_internet_gateway.vpc_igw ]
}

resource "aws_nat_gateway" "nat" {
   count = length(aws_eip.nateip_1)
   allocation_id = element(aws_eip.nateip_1.*.id, count.index)
   subnet_id = element(aws_subnet.public_subnets.*.id, count.index)
   depends_on = [ aws_internet_gateway.vpc_igw ]

   tags = {
     Name = "nat_gateways"
     Environment = "prod"
   }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  count = length(aws_nat_gateway.nat)

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat.*.id, count.index)
  }

  tags = {
    Name = "Private_route_table"
    Environment = "prod"
  }
}

resource "aws_route_table_association" "private_rt_assoc" {
  count = length(aws_subnet.private_subnets)
  subnet_id = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = element(aws_route_table.private_rt.*.id, count.index)
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnets" {
  value = element(aws_subnet.private_subnets.*.id, 0)
}