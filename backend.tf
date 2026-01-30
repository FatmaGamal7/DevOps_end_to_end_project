terraform {
  backend "s3" {
    bucket         = "terraform-state-fatma"
    key            = "final_project/terraform.tfstate"
    region         = "us-east-1"
  }
}