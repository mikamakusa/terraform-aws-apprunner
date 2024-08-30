data "aws_default_tags" "this" {}

data "aws_vpc" "this" {
  count = var.vpc_id ? 1 : 0
  id    = try(var.vpc_id)
}

data "aws_subnet" "this" {
  count  = (var.vpc_id && var.subnet_id) ? 1 : 0
  vpc_id = try(data.aws_vpc.this.id)
  id     = try(var.subnet_id)
}

data "aws_vpc_endpoint" "this" {
  count  = (var.vpc_id && var.vpc_endpoint_id) ? 1 : 0
  vpc_id = try(data.aws_vpc.this.id)
  id     = try(var.vpc_endpoint_id)
}