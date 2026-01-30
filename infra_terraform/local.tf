locals {
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

