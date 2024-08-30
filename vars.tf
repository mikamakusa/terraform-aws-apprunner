## DATAS

variable "vpc_id" {
  type    = string
  default = null
}

variable "subnet_id" {
  type    = string
  default = null
}

variable "vpc_endpoint_id" {
  type    = string
  default = null
}

## TAGS

variable "tags" {
  type    = map(string)
  default = {}
}

## MODULES

variable "key" {
  type    = any
  default = []
}

## RESOURCES

variable "auto_scaling_configuration_version" {
  type = list(object({
    id                              = number
    auto_scaling_configuration_name = string
    max_concurrency                 = optional(number)
    max_size                        = optional(number)
    min_size                        = optional(number)
    tags                            = optional(map(string))
  }))
  default = []
}

variable "connection" {
  type = list(object({
    id              = number
    connection_name = string
    provider_type   = optional(string)
    tags            = optional(map(string))
  }))
  default = []
}

variable "custom_domain_association" {
  type = list(object({
    id                   = number
    domain_name          = string
    service_id           = any
    enable_www_subdomain = optional(bool)
  }))
  default = []
}

variable "default_auto_scaling_configuration_version" {
  type = list(object({
    id                            = number
    auto_scaling_configuration_id = any
  }))
  default = []
}

variable "deployment" {
  type = list(object({
    id         = number
    service_id = any
  }))
  default = []
}

variable "observability_configuration" {
  type = list(object({
    id                               = number
    observability_configuration_name = string
    tags                             = optional(map(string))
    trace_configuration = optional(list(object({
      vendor = optional(string)
    })))
  }))
  default = []
}

variable "service" {
  type = list(object({
    id                            = number
    service_name                  = string
    auto_scaling_configuration_id = optional(any)
    tags                          = optional(map(string))
    source_configuration = list(object({
      auto_deployments_enabled = optional(bool)
      authentication_configuration = optional(list(object({
        access_role_arn = optional(string)
        connection_id   = optional(any)
      })))
      image_repository = optional(list(object({
        image_identifier      = string
        image_repository_type = string
        image_configuration = optional(list(object({
          port                          = optional(string)
          runtime_environment_secrets   = optional(map(string))
          runtime_environment_variables = optional(map(string))
          start_command                 = optional(string)
        })))
      })))
      code_repository = optional(list(object({
        repository_url   = string
        source_directory = optional(string)
        code_configuration = optional(list(object({
          configuration_source = string
          code_configuration_values = optional(list(object({
            runtime                       = optional(string)
            build_command                 = optional(string)
            port                          = optional(string)
            runtime_environment_secrets   = optional(map(string))
            runtime_environment_variables = optional(map(string))
            start_command                 = optional(string)
          })))
        })))
        source_code_version = list(object({
          type  = optional(string)
          value = string
        }))
      })))
    }))
    encryption_configuration = optional(list(object({
      kms_key_id = any
    })))
    health_check_configuration = optional(list(object({
      healthy_threshold   = optional(number)
      interval            = optional(number)
      path                = optional(string)
      protocol            = optional(string)
      timeout             = optional(number)
      unhealthy_threshold = optional(number)
    })))
    instance_configuration = optional(list(object({
      cpu               = optional(string)
      instance_role_arn = optional(string)
      memory            = optional(string)
    })))
    network_configuration = optional(list(object({
      ip_address_type = optional(string)
      ingress_configuration = optional(list(object({
        is_publicly_accessible = optional(bool)
      })))
      egress_configuration = optional(list(object({
        egress_type      = optional(string)
        vpc_connector_id = optional(any)
      })))
    })))
    observability_configuration = optional(list(object({
      observability_enabled          = bool
      observability_configuration_id = optional(any)
    })))
  }))
  default = []

  validation {
    condition     = length([for a in var.service : true if a.health_check_configuration.healthy_threshold >= 1 && a.health_check_configuration.healthy_threshold <= 20]) == length(var.service)
    error_message = "Values accepted in a range between 1 and 20."
  }

  validation {
    condition     = length([for b in var.service : true if b.health_check_configuration.interval >= 1 && b.health_check_configuration.interval <= 20]) == length(var.service)
    error_message = "Values accepted in a range between 1 and 20."
  }

  validation {
    condition     = length([for c in var.service : true if c.health_check_configuration.timeout >= 1 && c.health_check_configuration.timeout <= 20]) == length(var.service)
    error_message = "Values accepted in a range between 1 and 20."
  }

  validation {
    condition     = length([for d in var.service : true if d.health_check_configuration.unhealthy_threshold >= 1 && d.health_check_configuration.unhealthy_threshold <= 20]) == length(var.service)
    error_message = "Values accepted in a range between 1 and 20."
  }

  validation {
    condition     = length([for e in var.service : true if contains(["TCP", "HTTP"], e.health_check_configuration.protocol)]) == length(var.service)
    error_message = "Values accepted in a range between 1 and 20."
  }

  validation {
    condition     = length([for f in var.service : true if contains(["256", "512", "1024", "2048", "4096"], f.instance_configuration.cpu)]) == length(var.service)
    error_message = "Valid values: 256|512|1024|2048|4096|(0.25|0.5|1|2|4) vCPU."
  }

  validation {
    condition     = length([for g in var.service : true if contains(["512","1024", "2048", "3072", "4096", "6144", "8192", "10240", "12288"], g.instance_configuration.memory)]) == length(var.service)
    error_message = "Valid values: 512|1024|2048|3072|4096|6144|8192|10240|12288| GB."
  }

  validation {
    condition     = length([for h in var.service : true if contains(["IPV4","DUAL_STACK"], h.network_configuration.ip_address_type)]) == length(var.service)
    error_message = "Valid values: IPV4 or DUAL_STACK."
  }

  validation {
    condition     = length([for i in var.service : true if contains(["DEFAULT","VPC"], i.network_configuration.egress_configuration.egress_type)]) == length(var.service)
    error_message = "Valid values: DEFAULT or VPC."
  }

  validation {
    condition     = length([for j in var.service : true if contains(["ECR","ECR_PUBLIC"], j.source_configuration.image_repository.image_repository_type)]) == length(var.service)
    error_message = "Valid values: ECR or ECR_PUBLIC."
  }

  validation {
    condition     = length([for k in var.service : true if contains(["API","REPOSITORY"], k.source_configuration.code_repository.code_configuration.configuration_source)]) == length(var.service)
    error_message = "Valid values: API or REPOSITORY."
  }

  validation {
    condition     = length([for l in var.service : true if contains(["PYTHON_3", "NODEJS_12", "NODEJS_14", "NODEJS_16", "CORRETTO_8", "CORRETTO_11", "GO_1", "DOTNET_6", "PHP_81", "RUBY_31"], l.source_configuration.code_repository.code_configuration.code_configuration_values)]) == length(var.service)
    error_message = "Valid values: PYTHON_3, NODEJS_12, NODEJS_14, NODEJS_16, CORRETTO_8, CORRETTO_11, GO_1, DOTNET_6, PHP_81, RUBY_31."
  }
}

variable "vpc_connector" {
  type = list(object({
    id                 = number
    security_groups    = list(string)
    subnets            = list(string)
    vpc_connector_name = string
    tags               = optional(map(string))
  }))
  default = []
}

variable "vpc_ingress_connection" {
  type = list(object({
    id         = number
    name       = string
    service_id = any
    tags       = optional(map(string))
    ingress_vpc_configuration = list(object({
      vpc_id          = any
      vpc_endpoint_id = any
    }))
  }))
  default = []
}
