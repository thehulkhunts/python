resource "aws_iam_role" "eks-cluster-role" {
  name = "eks-iam-cluster-role"
  assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}
 

resource "aws_iam_role_policy_attachment" "eks-cluster-policy" {
  role = aws_iam_role.eks-cluster-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}