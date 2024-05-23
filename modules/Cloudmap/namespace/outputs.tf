output "namespace_id" {
  description = "The ID of the created private DNS namespace"
  value       = aws_service_discovery_private_dns_namespace.this.id
}

output "namespace_arn" {
  description = "The ARN of the created private DNS namespace"
  value       = aws_service_discovery_private_dns_namespace.this.arn
}

output "namespace_name" {
  description = "The name of the created private DNS namespace"
  value       = aws_service_discovery_private_dns_namespace.this.name
}

output "namespace_description" {
  description = "The description of the created private DNS namespace"
  value       = aws_service_discovery_private_dns_namespace.this.description
}
