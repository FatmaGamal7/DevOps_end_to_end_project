output "cluster_role_arn" {
  description = "EKS Cluster IAM Role ARN"
  value       = aws_iam_role.cluster.arn
}

output "node_role_arn" {
  description = "EKS Node Group IAM Role ARN"
  value       = aws_iam_role.node.arn
}

output "fargate_role_arn" {
  description = "EKS Fargate Pod Execution Role ARN"
  value       = aws_iam_role.fargate.arn
}
