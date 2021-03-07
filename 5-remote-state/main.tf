#-------------------------------------------------------------------------
# Un proveedor (provider) es responsable de comprender las interacciones 
# de la API y exponer los recursos.
#-------------------------------------------------------------------------
provider "aws" {
  #access_key = "ACCESS_KEY_HERE"
  #secret_key = "SECRET_KEY_HERE"
  region = "us-east-2"
}

resource "random_id" "remote_state" {
  byte_length = 8
}

resource "aws_s3_bucket" "remote_state" {
  bucket        = "terraform-tutorial-remote-state-${random_id.remote_state.hex}"
  acl           = "private"
  force_destroy = true
}

output "remote_state_bucket" {
  value = aws_s3_bucket.remote_state.bucket
}
