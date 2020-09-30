module "random-id" {
  source = "../random-id"
}

module "bucket" {
  source = "../bucket"
  name   = "${var.name}-${module.random-id.id}"
}
