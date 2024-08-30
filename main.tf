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
  count                          = length(var.service)
  service_name                   = lookup(var.service[count.index], "service_name")
  auto_scaling_configuration_arn = try(element(aws_apprunner_auto_scaling_configuration_version.this.*.arn, lookup(var.service[count.index], "auto_scaling_configuration_id")))
  tags                           = merge(var.tags, data.aws_default_tags.this.tags, lookup(var.service[count.index], "tags"))

  dynamic "source_configuration" {
    for_each = lookup(var.service[count.index], "source_configuration")
    iterator = sou
    content {
      auto_deployments_enabled = lookup(sou.value, "auto_deployments_enabled", true)

      dynamic "authentication_configuration" {
        for_each = try(lookup(sou.value, "authentication_configuration") == null ? [] : ["authentication_configuration"])
        iterator = aut
        content {
          access_role_arn = lookup(aut.value, "access_role_arn")
          connection_arn  = try(element(aws_apprunner_connection.this.*.arn, lookup(aut.value, "connection_id")))
        }
      }
      dynamic "image_repository" {
        for_each = try(lookup(sou.value, "image_repository") == null ? [] : ["image_repository"])
        iterator = ima
        content {
          image_identifier      = lookup(ima.value, "image_identifier")
          image_repository_type = lookup(ima.value, "image_repository_type")

          dynamic "image_configuration" {
            for_each = try(lookup(ima.value, "image_configuration") == null ? [] : ["image_configuration"])
            iterator = imc
            content {
              port                          = lookup(imc.value, "port", "8080")
              runtime_environment_secrets   = lookup(imc.value, "runtime_environment_secrets")
              runtime_environment_variables = lookup(imc.value, "runtime_environment_variables")
              start_command                 = lookup(imc.value, "start_command")
            }
          }
        }
      }
      dynamic "code_repository" {
        for_each = try(lookup(sou.value, "code_repository") == null ? [] : ["code_repository"])
        iterator = cod
        content {
          repository_url   = lookup(cod.value, "repository_url")
          source_directory = lookup(cod.value, "source_directory")

          dynamic "code_configuration" {
            for_each = try(lookup(cod.value, "code_configuration") == null ? [] : ["code_configuration"])
            iterator = cco
            content {
              configuration_source = lookup(cco.value, "configuration_source")

              dynamic "code_configuration_values" {
                for_each = try(lookup(cco.value, "code_configuration_values") == null ? [] : ["code_configuration_values"])
                iterator = ccv
                content {
                  runtime                       = lookup(ccv.value, "runtime")
                  build_command                 = lookup(ccv.value, "build_command")
                  port                          = lookup(ccv.value, "port", "8080")
                  runtime_environment_secrets   = lookup(ccv.value, "runtime_environment_secrets")
                  runtime_environment_variables = lookup(ccv.value, "runtime_environment_variables")
                  start_command                 = lookup(ccv.value, "start_command")
                }
              }
            }
          }

          dynamic "source_code_version" {
            for_each = lookup(cod.value, "source_code_version")
            iterator = scv
            content {
              type  = lookup(scv.value, "type", "BRANCH")
              value = lookup(scv.value, "value")
            }
          }
        }
      }
    }
  }

  dynamic "encryption_configuration" {
    for_each = try(lookup(var.service[count.index], "encryption_configuration") == null ? [] : ["encryption_configuration"])
    iterator = enc
    content {
      kms_key = try(element(module.kms.*.key_arn, lookup(enc.key, "kms_key_id")))
    }
  }

  dynamic "health_check_configuration" {
    for_each = try(lookup(var.service[count.index], "health_check_configuration") == null ? [] : ["health_check_configuration"])
    iterator = hea
    content {
      healthy_threshold   = lookup(hea.value, "healthy_threshold")
      interval            = lookup(hea.value, "interval")
      path                = lookup(hea.value, "path")
      protocol            = lookup(hea.value, "protocol")
      timeout             = lookup(hea.value, "timeout")
      unhealthy_threshold = lookup(hea.value, "unhealthy_threshold")
    }
  }

  dynamic "instance_configuration" {
    for_each = try(lookup(var.service[count.index], "instance_configuration") == null ? [] : ["instance_configuration"])
    iterator = inst
    content {
      cpu               = lookup(inst.value, "cpu", "1024 vCPU")
      instance_role_arn = lookup(inst.value, "instance_role_arn")
      memory            = lookup(inst.value, "memory", "2048 GB")
    }
  }

  dynamic "network_configuration" {
    for_each = try(lookup(var.service[count.index], "network_configuration") == null ? [] : ["network_configuration"])
    iterator = net
    content {
      ip_address_type = lookup(net.value, "ip_address_type")

      dynamic "ingress_configuration" {
        for_each = try(lookup(net.value, "ingress_configuration") == null ? [] : ["ingress_configuration"])
        iterator = ing
        content {
          is_publicly_accessible = lookup(ing.value, "is_publicly_accessible")
        }
      }

      dynamic "egress_configuration" {
        for_each = try(lookup(net.value, "egress_configuration") == null ? [] : ["egress_configuration"])
        iterator = egr
        content {
          egress_type       = lookup(egr.value, "egress_type")
          vpc_connector_arn = lookup(egr.value, "egress_type") == "VPC" ? try(element(aws_apprunner_vpc_connector.this.*.arn, lookup(egr.value, "vpc_connector_id"))) : null
        }
      }
    }
  }

  dynamic "observability_configuration" {
    for_each = try(lookup(var.service[count.index], "observability_configuration") == null ? [] : ["observability_configuration"])
    iterator = obs
    content {
      observability_enabled           = lookup(obs.value, "observability_enabled")
      observability_configuration_arn = lookup(obs.value, "observability_enabled") == true ? try(element(aws_apprunner_observability_configuration.this.*.arn, lookup(obs.value, "observability_configuration_id"))) : null
    }
  }
}

resource "aws_apprunner_vpc_connector" "this" {
  count              = length(var.vpc_connector)
  security_groups    = lookup(var.vpc_connector[count.index], "security_groups")
  subnets            = lookup(var.vpc_connector[count.index], "subnets")
  vpc_connector_name = lookup(var.vpc_connector[count.index], "vpc_connector_name")
  tags               = merge(var.tags, data.aws_default_tags.this.tags, lookup(var.vpc_connector[count.index], "tags"))
}

resource "aws_apprunner_vpc_ingress_connection" "this" {
  count       = length(var.service) == 0 ? 0 : length(var.vpc_ingress_connection)
  name        = lookup(var.vpc_ingress_connection[count.index], "name")
  service_arn = try(element(aws_apprunner_service.this.*.arn, lookup(var.vpc_ingress_connection[count.index], "service_id")))
  tags        = merge(var.tags, data.aws_default_tags.this.tags, lookup(var.vpc_ingress_connection[count.index], "tags"))

  dynamic "ingress_vpc_configuration" {
    for_each = lookup(var.vpc_ingress_connection[count.index], "ingress_vpc_configuration")
    iterator = ivc
    content {
      vpc_id          = try(data.aws_vpc.this.id)
      vpc_endpoint_id = try(data.aws_vpc_endpoint.this.id)
    }
  }
}