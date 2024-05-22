

module "my_vpc" {
  source          = "./modules/vpc_module"
  vpc_cidr        = "10.0.0.0/16"
  vpc_name        = "my-vpc"    #not required
  azs             = ["us-east-1a", "us-east-1b"]

  public_subnets  = ["10.0.2.0/24", "10.0.4.0/24"]
  private_subnets = ["10.0.1.0/24", "10.0.3.0/24"]

  tags = {
    Environment = "Development"
  }
}


module "dataflowRepo" {
  source = "./modules/ECR"

  account_id          = var.AccountID
  region              = var.aws_region
  repository_name     = "dataflow"
  tag                 = "latest"

  image_tag_mutability = "IMMUTABLE"
  scan_on_push         = true
  is_public            = false

  tags = {
    Environment = "Development"
  }
}

module "SkipperRepo" {
  source = "./modules/ECR"

  account_id          = var.AccountID
  region              = var.aws_region
  repository_name     = "skipper"
  tag                 = "latest"

  image_tag_mutability = "IMMUTABLE"
  scan_on_push         = true
  is_public            = false

  tags = {
    Environment = "Development"
  }
}

output "dataflowURL" {
  value = module.dataflowRepo.repository_url
}