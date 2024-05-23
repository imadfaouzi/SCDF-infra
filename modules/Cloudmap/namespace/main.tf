resource "aws_service_discovery_private_dns_namespace" "this" {
  name        = var.namespace_name
  vpc         = var.vpc_id
  description = var.description
}
# how to use it :

# module "private_dns_namespace" {
#   source      = "./modules/private_dns_namespace"  // Path to the directory containing the private_dns_namespace module
#   namespace_name = var.namespace_name
#   vpc_id         = var.vpc_id
#   description    = var.description
# }