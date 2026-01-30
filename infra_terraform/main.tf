# VPC
module "vpc" {
  source     = "./modules/vpc"
  cidr_block = var.vpc_cidr_prod
}

# public Subnets
module "public_subnets" {
  source = "./modules/public_subnet"
  count  = length(local.public_cidrs)

  vpc_id            = module.vpc.vpc_id
  cidr_block        = local.public_cidrs[count.index]
  availability_zone = local.availability_zones[count.index]
}


# Private Subnets (2 AZs)
module "private_subnets" {
  source = "./modules/private_subnet"
  count  = length(local.private_cidrs)

  vpc_id            = module.vpc.vpc_id
  cidr_block        = local.private_cidrs[count.index]
  availability_zone = local.availability_zones[count.index]
}

# Internet Gateway
module "igw" {
  source = "./modules/IGW"
  vpc_id = module.vpc.vpc_id
}

# NAT Gateway
module "nat" {
  source           = "./modules/NAT"
  public_subnet_id = module.public_subnets[0].public_subnet_id
  igw_id           = module.igw.IGW_id
  env              = var.env
}

# Public Route Tables
module "public_rts" {
  source    = "./modules/public_routetable"
  count  = length(module.public_subnets)

  vpc_id    = module.vpc.vpc_id
  subnet_id = module.public_subnets[count.index].public_subnet_id
  igw_id    = module.igw.IGW_id
}


# Private Route Tables (Shared NAT)
module "private_rts" {
  source    = "./modules/private_routetable"
  count  = length(module.private_subnets)
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.private_subnets[count.index].private_subnet_id
  nat_id    = module.nat.nat_id
}

#_______________________


module "IAM" {
  source           = "./modules/IAM"
  env              = var.env
  eks_cluster_name = "my-eks-cluster"
}

module "EKS" {
  source       = "./modules/EKS"
  cluster_name = "my-eks-cluster"
  env          = var.env

  # Collect all public and private subnet IDs into one list for EKS cluster
  subnet_ids = concat(
    [for s in module.public_subnets : s.public_subnet_id],
    [for s in module.private_subnets : s.private_subnet_id]
  )

  # Private subnets only for node groups / fargate
  private_subnet_ids = [for s in module.private_subnets : s.private_subnet_id]

  iam_module = module.IAM
}



















































#################################
# module "vpc" {
#   source = "./modules/vpc"
#   cidr_block   = local.vpc_cidr

# }

# module "public_subnet" {
#   source            = "./modules/public_subnet"
#   vpc_id            = module.vpc.vpc_id
#   cidr_block        = local.public_cidr
#   availability_zone = var.availability_zone
# }

# module "private_subnet" {
#   source            = "./modules/private_subnet"
#   vpc_id            = module.vpc.vpc_id
#   cidr_block        = local.private_cidr
#   availability_zone = var.availability_zone
# }


# module "igw" {
#   source = "./modules/IGW"
#   vpc_id = module.vpc.vpc_id
# }


# module "nat" {
#   source           = "./modules/NAT"
#   public_subnet_id = module.public_subnet.public_subnet_id
#   igw_id           = module.igw.IGW_id
#   env              = var.env
# }


# module "public_rt" {
#   source    = "./modules/public_routetable"
#   vpc_id    = module.vpc.vpc_id
#   subnet_id = module.public_subnet.public_subnet_id
#   igw_id    = module.igw.IGW_id
# }

# module "private_rt" {
#   source    = "./modules/private_routetable"
#   vpc_id    = module.vpc.vpc_id
#   subnet_id = module.private_subnet.private_subnet_id
#   nat_id    = module.nat.nat_id
# }


# # module "alb" {
# #   source    = "./modules/ALB"
# #   vpc_id    = module.vpc.vpc_id
# #   subnet_id = module.public_subnet.subnet_id
# # }


# # module "apigw" {
# #   source  = "./modules/APIGW"
# #   alb_arn = module.alb.alb_arn
# # }


# module "IAM" {
#   source           = "./modules/IAM"
#   env              = var.env
#   eks_cluster_name = "my-eks-cluster"
# }

# module "EKS" {
#   source             = "./modules/EKS"
#   cluster_name       = "my-eks-cluster"
#   env                = var.env
#   subnet_ids         = [module.public_subnet.public_subnet_id, module.private_subnet.private_subnet_id]
#   private_subnet_ids = [module.private_subnet.private_subnet_id]
#   iam_module         = module.IAM
# }
