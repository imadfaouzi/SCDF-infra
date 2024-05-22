output "repository_url" {
  value = local.repository_url
}

output "repository_arn" {
  value = var.is_public ? aws_ecrpublic_repository.this[0].arn : aws_ecr_repository.this[0].arn
}