output "service_id" {
  description = "The ID of the created service"
  value       = aws_service_discovery_service.service_discovery.id
}

output "service_name" {
  description = "The name of the created service"
  value       = aws_service_discovery_service.service_discovery.name
}

output "service_arn" {
  description = "The ARN of the created service"
  value       = aws_service_discovery_service.service_discovery.arn
}
