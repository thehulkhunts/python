// eks-cluster outputs

output "eks-cluster-iam-role" {
  value = aws_iam_role.eks-cluster-role.arn
}
output "eks-iam-policy-attachment" {
  value = aws_iam_role_policy_attachment.eks-cluster-policy.id
}

// eks-nodegroup outputs from here

output "eks-nodegroup-iam" {
  value = aws_iam_role.eks-nodegroup-iam-role.arn
}

output "eks-nodegroup-policy" {
  value = aws_iam_role_policy_attachment.nodegroup-iam-attachment.id
}

output "eks-cni" {
  value = aws_iam_role_policy_attachment.eks-cni.id
}

output "ec2-readonly" {
  value = aws_iam_role_policy_attachment.ec2-readonly.id
}