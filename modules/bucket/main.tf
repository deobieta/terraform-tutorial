resource "aws_s3_bucket" "this" {
  bucket        = var.name
  acl           = "private" # Acceso privado
  force_destroy = true      # OJO: el bucket se destruye aunque contenga objetos.
}
