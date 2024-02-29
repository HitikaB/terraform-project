
resource "aws_ecr_repository" "ecr_repo" {
  name                 = var.ecr
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
