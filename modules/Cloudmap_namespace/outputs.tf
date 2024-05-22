output "private_dns_namespace_id" {
  value       = aws_service_discovery_private_dns_namespace.this.*.id
  description = "The ID of the private DNS namespace."
}

output "public_dns_namespace_id" {
  value       = aws_service_discovery_public_dns_namespace.this.*.id
  description = "The ID of the public DNS namespace."
}

output "http_namespace_id" {
  value       = aws_service_discovery_http_namespace.this.*.id
  description = "The ID of the HTTP namespace."
}
