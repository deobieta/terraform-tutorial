#-------------------------------------------------------------------------
# Un proveedor (provider) es responsable de comprender las interacciones 
# de la API y exponer los recursos.
#-------------------------------------------------------------------------
provider "aws" {
  #access_key = "ACCESS_KEY_HERE"
  #secret_key = "SECRET_KEY_HERE"
  region = "us-east-2"
}

resource "random_id" "intro" {
  byte_length = 8
}

resource "aws_s3_bucket" "intro" {
  bucket        = "terraform-tutorial-${random_id.intro.hex}"
  acl           = "private" # Acceso privado
  force_destroy = true      # OJO: el bucket se destruye aunque contenga objetos.
}

