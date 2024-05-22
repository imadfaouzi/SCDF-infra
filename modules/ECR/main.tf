resource "aws_ecr_repository" "this" {
  count = var.is_public ? 0 : 1

  name                 = var.repository_name
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = var.tags

  force_delete = true
}

resource "aws_ecrpublic_repository" "this" {
  count = var.is_public ? 1 : 0

  repository_name = var.repository_name

  tags = var.tags
  
}

locals {
  repository_url = var.is_public ? aws_ecrpublic_repository.this[0].repository_uri : "${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.repository_name}:${var.tag}"
}


