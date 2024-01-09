resource "aws_iam_role" "eks-nodegroup-iam-role" {
  name = "eks-iam-nodegroup"
  assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "nodegroup-iam-attachment" {
  role = aws_iam_role.eks-nodegroup-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks-cni" {
  role = aws_iam_role.eks-nodegroup-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ec2-readonly" {
  role = aws_iam_role.eks-nodegroup-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}