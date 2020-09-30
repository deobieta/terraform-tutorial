module "s3_bucket_1" {
  source = "../modules/s3-one-level"
  name   = "uno"
}

output "s3_bucket_1_name" {
  value = module.s3_bucket_1.bucket
}

module "s3_bucket_2" {
  source = "../modules/s3-one-level"
  name   = "dos"
}

output "s3_bucket_2_name" {
  value = module.s3_bucket_2.bucket
}

