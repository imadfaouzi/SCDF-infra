resource "aws_service_discovery_service" "service_discovery" {
  name              = var.service_name
  dns_config {
    namespace_id    = var.cloudmap_namespace_id
    dns_records {
      ttl           = 60
      type          = "A"
    }
  }
}

# how to use it :


# module "private_dns_namespace" {
#   source      = "./modules/private_dns_namespace"  // Path to the directory containing the private_dns_namespace module
#   namespace_name = var.namespace_name
#   vpc_id         = var.vpc_id
#   description    = var.description
# }