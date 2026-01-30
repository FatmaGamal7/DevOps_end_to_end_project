variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "env" {
  description = "Environment (prod/nonprod)"
  type        = string
}

variable "subnet_ids" {
  description = "List of public + private subnet IDs for the cluster"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for node group and Fargate"
  type        = list(string)
}

variable "iam_module" {
  description = "IAM module outputs (cluster, node, fargate roles)"
  type        = any
}
