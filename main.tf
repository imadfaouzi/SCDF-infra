module "scdf-vpc" {
  source          = "./modules/vpc_module"
  vpc_cidr        = "10.0.0.0/16"
  vpc_name        = "scdf-vpc"    #not required
  azs             = ["us-east-1a", "us-east-1b"]

  public_subnets  = ["10.0.2.0/24", "10.0.4.0/24"]
  private_subnets = ["10.0.1.0/24", "10.0.3.0/24"]

  tags = {
    Environment = "Development"
  }
}


# ECS CLUSTER :
resource "aws_ecs_cluster" "my-mad-cluster" {
  name = "my-imad-cluster"
}

# Task Definition 
module "ecs_task_definition" {
  source = "./modules/ECS/task_definition"

  family          = "my-task-family"
  cpu             = "512"
  memory          = "1024"
  skip_destroy    = true
  container_name  = "my-container"
  docker_image    = "imadfa01/mywebapp:0.0.3"
  container_cpu   = 256
  container_memory = 512

  port_mappings = [
    {
      containerPort = 80
      hostPort      = 80
      protocol      = "tcp"
    }
  ]

}

# SECURI GROIUPE:
module "security_group" {
  source = "./modules/security_group"

  name        = "SecurityGroup_my-imad-service"
  description = "Allow HTTP 80"
  vpc_id      = module.scdf-vpc.vpc_id

  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

#CloudMAP: namespace & service
module "private_dns_namespace" {
  source      = "./modules/Cloudmap/namespace"
  namespace_name = "mynamespace"
  vpc_id         = module.scdf-vpc.vpc_id
  description    = "this name space is for scdf ervices"
}

module "service_discovery" {
  source      = "./modules/Cloudmap/service"  
  service_name           = "webpage80"
  cloudmap_namespace_id  = module.private_dns_namespace.namespace_id
}




# sercvice :
module "ecs_service" {
  source = "./modules/ECS/service"

  name                  = "my-mad-webpage-service"
  cluster_id            = aws_ecs_cluster.my-mad-cluster.id
  task_definition_arn   = module.ecs_task_definition.task_definition_arn
  desired_count         = 1
  subnets               =  module.scdf-vpc.private_subnet_ids
  security_groups       = [module.security_group.security_group_id]
  assign_public_ip      = false

  cloud_map_service_arn = module.service_discovery.service_arn
}









// TODO: this is a ec2 instance to test vpc and other ressources :


# SECURITY GROUP:
# module "ec2_security_group_SSH" {
#   source = "./modules/security_group"

#   name        = "ec2_security_group_SSH"
#   description = "Allow SSH 22"
#   vpc_id      = module.scdf-vpc.vpc_id

#   ingress_rules = [
#     {
#       from_port   = 22
#       to_port     = 22
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   ]

#   egress_rules = [
#     {
#       from_port   = 0
#       to_port     = 0
#       protocol    = "-1"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   ]
# }

# resource "aws_instance" "ubuntu_instance" {
#   ami                    = "ami-04b70fa74e45c3917"  # Ubuntu 20.04 LTS AMI ID, you can change this as per your requirement
#   instance_type          = "t2.micro"                # Instance type, adjust as needed
#   key_name               = "myimadkey"               # Key pair name

#   # If you need, you can specify additional configurations like subnet, security group, etc.
#   subnet_id              = module.scdf-vpc.public_subnet_ids[0]        # Example subnet ID
#   security_groups        = [module.ec2_security_group_SSH.security_group_id]  # Use the ID of the created security group

#   tags = {
#     Name = "MyUbuntuInstance"  # Tag your instance appropriately
#   }
# }

# output "ec2_public_ip" {
#   value = aws_instance.ubuntu_instance.public_ip
# }














# module "SkipperRepo" {
#   source = "./modules/ECR"

#   account_id          = var.AccountID
#   region              = var.aws_region
#   repository_name     = "skipper"
#   tag                 = "latest"

#   image_tag_mutability = "IMMUTABLE"
#   scan_on_push         = true
#   is_public            = false

#   tags = {
#     Environment = "Development"
#   }
# }

