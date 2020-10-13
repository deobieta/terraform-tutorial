variable name_1 {}

module "s3_bucket_1" {
  count  = terraform.workspace == "dev" ? 1 : 0 # condicional para crear solo en dev
  source = "../modules/s3-one-level"
  name   = "${terraform.workspace}-${var.name_1}"
}

output "s3_bucket_1_name" {
  value = module.s3_bucket_1.*.bucket
}

variable name_2 {}

module "s3_bucket_2" {
  source = "../modules/s3-one-level"
  name   = "${terraform.workspace}-${var.name_2}"
}

output "s3_bucket_2_name" {
  value = module.s3_bucket_2.*.bucket
}

