resource "aws_service_discovery_private_dns_namespace" "this" {
  count       = var.instance_discovery == "API calls and DNS queries in VPCs" ? 1 : 0

  name        = var.namespace_name
  vpc         = var.vpc_id
  description = var.description
}

resource "aws_service_discovery_public_dns_namespace" "this" {
  count       = var.instance_discovery == "API calls and public DNS queries" ? 1 : 0

  name        = var.namespace_name
  description = var.description
}

resource "aws_service_discovery_http_namespace" "this" {
  count       = var.instance_discovery == "API calls" ? 1 : 0
  
  name        = var.namespace_name
  description = var.description
}
