resource "aws_apprunner_auto_scaling_configuration_version" "this" {
  count                           = length(var.auto_scaling_configuration_version)
  auto_scaling_configuration_name = lookup(var.auto_scaling_configuration_version[count.index], "auto_scaling_configuration_name")
  max_concurrency                 = lookup(var.auto_scaling_configuration_version[count.index], "max_concurrency")
  max_size                        = lookup(var.auto_scaling_configuration_version[count.index], "max_size")
  min_size                        = lookup(var.auto_scaling_configuration_version[count.index], "min_size")
  tags                            = merge(var.tags, data.aws_default_tags.this.tags, lookup(var.auto_scaling_configuration_version[count.index], "tags"))
}

resource "aws_apprunner_connection" "this" {
  count           = length(var.connection)
  connection_name = lookup(var.connection[count.index], "connection_name")
  provider_type   = lookup(var.connection[count.index], "provider_type", "GITHUB")
  tags            = merge(var.tags, data.aws_default_tags.this.tags, lookup(var.connection[count.index], "tags"))
}

resource "aws_apprunner_custom_domain_association" "this" {
  count                = length(var.service) == 0 ? 0 : length(var.custom_domain_association)
  domain_name          = lookup(var.custom_domain_association[count.index], "domain_name")
  service_arn          = try(element(aws_apprunner_service.this.*.arn, lookup(var.custom_domain_association[count.index], "service_id")))
  enable_www_subdomain = lookup(var.custom_domain_association[count.index], "enable_www_subdomain", true)
}

resource "aws_apprunner_default_auto_scaling_configuration_version" "this" {
  count                          = length(var.auto_scaling_configuration_version) == 0 ? 0 : length(var.default_auto_scaling_configuration_version)
  auto_scaling_configuration_arn = try(element(aws_apprunner_auto_scaling_configuration_version.this.*.arn, lookup(var.default_auto_scaling_configuration_version[count.index], "auto_scaling_configuration_id")))
}

resource "aws_apprunner_deployment" "this" {
  count       = length(var.service) == 0 ? 0 : length(var.deployment)
  service_arn = try(element(aws_apprunner_service.this.*.arn, lookup(var.deployment[count.index], "service_id")))
}

resource "aws_apprunner_observability_configuration" "this" {
  count                            = length(var.observability_configuration)
  observability_configuration_name = lookup(var.observability_configuration[count.index], "observability_configuration_name")
  tags                             = merge(var.tags, data.aws_default_tags.this.tags, lookup(var.observability_configuration[count.index], "tags"))

  dynamic "trace_configuration" {
    for_each = try(lookup(var.observability_configuration[count.index], "trace_configuration") == null ? [] : ["trace_configuration"])
    content {
      vendor = lookup(trace_configuration.value, "vendor", "AWSXRAY")
    }
  }
}

resource "aws_apprunner_service" "this" {
  service_name = ""
}

resource "aws_apprunner_vpc_connector" "this" {
  security_groups    = []
  subnets            = []
  vpc_connector_name = ""
}

resource "aws_apprunner_vpc_ingress_connection" "this" {
  name        = ""
  service_arn = ""
}