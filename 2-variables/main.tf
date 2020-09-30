resource "random_id" "variables" {
  byte_length = 8
}

resource "aws_s3_bucket" "variables" {
  bucket        = "${var.bucket_name}-${random_id.variables.hex}"
  acl           = "private" # Acceso privado
  force_destroy = true      # OJO: el bucket se destruye aunque contenga objetos.
}

output "s3_bucket" {
  value = aws_s3_bucket.variables.bucket # Output para saber el nombre de nuestro bucket
}

