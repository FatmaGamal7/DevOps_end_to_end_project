locals {
#   vpc_cidr     = "10.0.0.0/16"
#   public_cidr_1  = "10.0.1.0/24"
#   public_cidr_2  = "10.0.2.0/24"
#   private_cidr_1 = "10.0.101.0/24"
#   private_cidr_2 = "10.0.102.0/24"

  public_cidr  = var.env == "prod" ? var.public_cidr_prod : var.public_cidr_nonprod
  private_cidr = var.env == "prod" ? var.private_cidr_prod : var.private_cidr_nonprod
}

locals {
  public_cidrs = [
    var.public_cidr_prod,
    var.public_cidr_nonprod
  ]

  private_cidrs = [
    var.private_cidr_prod,
    var.private_cidr_nonprod
  ]

  availability_zones = [
    var.availability_zone_1,
    var.availability_zone_2
  ]
}

