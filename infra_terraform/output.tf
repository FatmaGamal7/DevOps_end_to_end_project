# VPC
output "vpc_id" {
  value = module.vpc.vpc_id
}

# Public Subnets
output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.public_subnets[*].public_subnet_id
}

# Private Subnets
output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.private_subnets[*].private_subnet_id
}

# NAT Gateway
output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = module.nat.nat_id
}

output "nat_eip" {
  description = "Elastic IP associated with NAT Gateway"
  value       = module.nat.nat_eip
}

# EKS
output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = module.EKS.cluster_name
}

output "eks_cluster_arn" {
  description = "EKS cluster ARN"
  value       = module.EKS.cluster_arn
}

# IAM (EKS)
output "eks_cluster_role_arn" {
  description = "IAM role ARN for EKS cluster"
  value       = module.IAM.cluster_role_arn
}

output "eks_node_role_arn" {
  description = "IAM role ARN for EKS managed node group"
  value       = module.IAM.node_role_arn
}
