module "kms" {
  source = "./modules/terraform-aws-kms"
  key    = var.key
}