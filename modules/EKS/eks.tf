# EKS Cluster
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.iam_module.cluster_role_arn
  version = "1.32"

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  depends_on = [
    var.iam_module
  ]
}

# Managed Node Group
resource "aws_eks_node_group" "managed" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.env}-managed"
  node_role_arn   = var.iam_module.node_role_arn
  subnet_ids      = var.private_subnet_ids

  instance_types = ["t3.micro"]
  capacity_type  = "ON_DEMAND"

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  depends_on = [aws_eks_cluster.this]
}

# Fargate Profile
resource "aws_eks_fargate_profile" "default" {
  cluster_name           = aws_eks_cluster.this.name
  fargate_profile_name   = "${var.env}-fargate"
  pod_execution_role_arn = var.iam_module.fargate_role_arn
  subnet_ids             = var.private_subnet_ids

  selector {
    namespace = "default"
  }

  depends_on = [aws_eks_cluster.this]
}

# EKS Addons
# resource "aws_eks_addon" "coredns" {
#   cluster_name       = aws_eks_cluster.this.name
#   addon_name         = "coredns"
#   addon_version      = "v1.23.15-eksbuild.2"
#   service_account_role_arn = var.iam_module.fargate_role_arn
# }

# resource "aws_eks_addon" "kube_proxy" {
#   cluster_name  = aws_eks_cluster.this.name
#   addon_name    = "kube-proxy"
#   addon_version = "v1.23.15-eksbuild.2"
# }

# resource "aws_eks_addon" "vpc_cni" {
#   cluster_name  = aws_eks_cluster.this.name
#   addon_name    = "vpc-cni"
#   addon_version = "v1.13.13-eksbuild.1"
# }

resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "coredns"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "kube-proxy"
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "vpc-cni"
}

