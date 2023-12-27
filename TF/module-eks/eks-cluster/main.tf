resource "aws_eks_cluster" "Eks" {
  name = var.eks_cluster_name
  role_arn = var.eks-iam-role
  version = "1.28"

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access =  true

    subnet_ids = [
        var.subnet-01,
        var.subnet-02
    ]
  }
  depends_on = [var.eks-cluster-policy]
}
