module "vpc" {

  source         = "../vpc"
  vpc_cidr       = "10.0.0.0/16"
  subnet_cidr    = "10.0.1.0/24"
  subnet_cidr_02 = "10.0.2.0/24"
  az_subnet-01   = "ap-south-1a"
  az_subnet_02   = "ap-south-1b"

}

module "iam-roles" {
  source = "../module-iam"
}

module "eks-cluster" {

  source             = "../module-eks/eks-cluster"
  subnet-01          = module.vpc.subnet-01
  subnet-02          = module.vpc.subnet-02
  eks-iam-role       = module.iam-roles.eks-cluster-iam-role
  eks-cluster-policy = module.iam-roles.eks-iam-policy-attachment

}
module "eks-nodegroup" {

  source                 = "../module-eks/eks-nodegroup"
  subnet-01              = module.vpc.subnet-01
  subnet-02              = module.vpc.subnet-02
  eks-nodegroup-iam-role = module.iam-roles.eks-nodegroup-iam
  eks-nodegroup-policy   = module.iam-roles.eks-nodegroup-policy
  eks-cni                = module.iam-roles.eks-cni
  ec2-readonly           = module.iam-roles.ec2-readonly

}

module "eks-sec-grp" {
  source = "../module-security-groups"
  vpc_id = module.vpc.vpc_id
}

