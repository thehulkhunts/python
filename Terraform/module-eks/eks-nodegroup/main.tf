resource "aws_eks_node_group" "eks-nodegroup" {
  node_group_name = "eks-nodegroup"
  cluster_name = "eks"
  node_role_arn = var.eks-nodegroup-iam-role
  
  subnet_ids = [
    var.subnet-01,
    var.subnet-02
  ]
  scaling_config {
    min_size = 2
    max_size = 5
    desired_size = 2
  }
  ami_type = "AL2_x86_64"
  instance_types = ["t2.medium"]
  capacity_type = "ON_DEMAND"
  disk_size = 20
  version = "1.28"
  force_update_version = false

  labels = {
    Name = "eks-nodegroup"
  }

  depends_on = [var.eks-nodegroup-policy,
                var.eks-cni, 
                var.ec2-readonly]

}