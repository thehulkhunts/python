resource "aws_security_group" "eks-security" {
  vpc_id = var.vpc_id
  description = "eks-securitygroup"

  ingress = [
    for ports in [22, 80, 443, 8080, 9000, 8081]: {
        description = "ports enabled"
        cidr_blocks = ["0.0.0.0/0"]
        from_port = ports
        to_port = ports
        protocol = "tcp"
        self = false
        prefix_list_ids = []
        security_groups  = []
        ipv6_cidr_blocks = []
    }
  ]
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "vpc_security_group" {
  value = aws_security_group.eks-security.id
}