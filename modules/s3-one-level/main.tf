resource "random_id" "this" {
  byte_length = 8
}

resource "aws_s3_bucket" "this" {
  bucket        = "${var.name}-${random_id.this.hex}"
  acl           = "private" # Acceso privado
  force_destroy = true      # OJO: el bucket se destruye aunque contenga objetos.
}
