## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kms"></a> [kms](#module\_kms) | ./modules/terraform-aws-kms | n/a |

## Module Usage
### Module
````terraform
module "appruner" {
  source = "."
  auto_scaling_configuration_version          = var.auto_scaling_configuration_version
  connection                                  = var.connection
  custom_domain_association                   = var.custom_domain_association
  default_auto_scaling_configuration_version  = var.default_auto_scaling_configuration_version
  deployment                                  = var.deployment
  observability_configuration                 = var.observability_configuration
  service                                     = var.service
  vpc_connector                               = var.vpc_connector
  vpc_ingress_connection                      = var.vpc_ingress_connection
  vpc_id                                      = var.vpc_id
  vpc_endpoint_id                             = var.vpc_endpoint_id
  tags                                        = var.tags
  key                                         = var.key
}
````

### Variables
````terraform
variable "auto_scaling_configuration_version" {
  type = any
}
variable "connection" {
  type = any
}
variable "custom_domain_association" {
  type = any
}
variable "default_auto_scaling_configuration_version" {
  type = any
}
variable "deployment" {
  type = any
}
variable "observability_configuration" {
  type = any
}
variable "service" {
  type = any
}
variable "vpc_connector" {
  type = any
}
variable "vpc_ingress_connection" {
  type = any
}
variable "vpc_id" {
  type = string
}
variable "vpc_endpoint_id" {
  type = string
}
variable "tags" {
  type = map(string)
}
variable "key" {
  type = any
}
````

### tfvars
````terraform
tags = {
  terraform = "true"
  provider = "aws"
  service = "appruner"
}
key = [
  {
    id                      = 10
    description             = "appruner kms key"
    multi_region            = true
    enable_key_rotation     = true
    deletion_window_in_days = 10
  }
]
vpc_id          = "test"
vpc_endpoint_id = "vpc-ep-test"
auto_scaling_configuration_version = [
  {
    id                              = 9
    auto_scaling_configuration_name = "example"
    max_concurrency                 = 50
    max_size                        = 10
    min_size                        = 2
  }
]
connection = [
  {
    id              = 0
    connection_name = "example"
  }
]
custom_domain_association = [
  {
    id                   = 0
    domain_name          = "example-test.com"
    service_id           = 2
    enable_www_subdomain = true
  }
]
deployment = [
  {
    id          = 1
    service_id  = 2
  }
]
observability_configuration = [
  {
    id                                = 4
    observability_configuration_name  = "obs-conf-example"
  }
]
service = [
  {
    id                            = 2
    service_name                  = "srv-example"
    auto_scaling_configuration_id = 9
    source_configuration = [
      {
        authentication_configuration = [
          {
            connection_id = 3
          }
        ]
        code_repository = [
          {
            code_configuration = [
              {
                configuration_source = "REPOSITORY"
              }
            ]
            repository_url = "https://github.com/example/my-example-python-app"
          }
        ]
      }
    ]
    network_configuration = [
      {
        egress_configuration = [
          {
            egress_type       = "VPC"
            vpc_connector_id  = 6
          }
        ]
      }
    ]
    observability_configuration = [
      {
        observability_enabled           = true
        observability_configuration_id  = 4
      }
    ]
    encryption_configuration = [
      {
        kms_key_id = 10
      }
    ]
  }
]
vpc_connector = [
  {
    id                 = 6
    vpc_connector_name = "name"
    subnets            = ["subnet1", "subnet2"]
    security_groups    = ["sg1", "sg2"]
  }
]
````

## Resources

| Name | Type |
|------|------|
| [aws_apprunner_auto_scaling_configuration_version.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_auto_scaling_configuration_version) | resource |
| [aws_apprunner_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_connection) | resource |
| [aws_apprunner_custom_domain_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_custom_domain_association) | resource |
| [aws_apprunner_default_auto_scaling_configuration_version.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_default_auto_scaling_configuration_version) | resource |
| [aws_apprunner_deployment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_deployment) | resource |
| [aws_apprunner_observability_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_observability_configuration) | resource |
| [aws_apprunner_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_service) | resource |
| [aws_apprunner_vpc_connector.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_vpc_connector) | resource |
| [aws_apprunner_vpc_ingress_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_vpc_ingress_connection) | resource |
| [aws_default_tags.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |
| [aws_subnet.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [aws_vpc_endpoint.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc_endpoint) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_scaling_configuration_version"></a> [auto\_scaling\_configuration\_version](#input\_auto\_scaling\_configuration\_version) | n/a | <pre>list(object({<br>    id                              = number<br>    auto_scaling_configuration_name = string<br>    max_concurrency                 = optional(number)<br>    max_size                        = optional(number)<br>    min_size                        = optional(number)<br>    tags                            = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_connection"></a> [connection](#input\_connection) | n/a | <pre>list(object({<br>    id              = number<br>    connection_name = string<br>    provider_type   = optional(string)<br>    tags            = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_custom_domain_association"></a> [custom\_domain\_association](#input\_custom\_domain\_association) | n/a | <pre>list(object({<br>    id                   = number<br>    domain_name          = string<br>    service_id           = any<br>    enable_www_subdomain = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_default_auto_scaling_configuration_version"></a> [default\_auto\_scaling\_configuration\_version](#input\_default\_auto\_scaling\_configuration\_version) | n/a | <pre>list(object({<br>    id                            = number<br>    auto_scaling_configuration_id = any<br>  }))</pre> | `[]` | no |
| <a name="input_deployment"></a> [deployment](#input\_deployment) | n/a | <pre>list(object({<br>    id         = number<br>    service_id = any<br>  }))</pre> | `[]` | no |
| <a name="input_key"></a> [key](#input\_key) | n/a | `any` | `[]` | no |
| <a name="input_observability_configuration"></a> [observability\_configuration](#input\_observability\_configuration) | n/a | <pre>list(object({<br>    id                               = number<br>    observability_configuration_name = string<br>    tags                             = optional(map(string))<br>    trace_configuration = optional(list(object({<br>      vendor = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_service"></a> [service](#input\_service) | n/a | <pre>list(object({<br>    id                            = number<br>    service_name                  = string<br>    auto_scaling_configuration_id = optional(any)<br>    tags                          = optional(map(string))<br>    source_configuration = list(object({<br>      auto_deployments_enabled = optional(bool)<br>      authentication_configuration = optional(list(object({<br>        access_role_arn = optional(string)<br>        connection_id   = optional(any)<br>      })))<br>      image_repository = optional(list(object({<br>        image_identifier      = string<br>        image_repository_type = string<br>        image_configuration = optional(list(object({<br>          port                          = optional(string)<br>          runtime_environment_secrets   = optional(map(string))<br>          runtime_environment_variables = optional(map(string))<br>          start_command                 = optional(string)<br>        })))<br>      })))<br>      code_repository = optional(list(object({<br>        repository_url   = string<br>        source_directory = optional(string)<br>        code_configuration = optional(list(object({<br>          configuration_source = string<br>          code_configuration_values = optional(list(object({<br>            runtime                       = optional(string)<br>            build_command                 = optional(string)<br>            port                          = optional(string)<br>            runtime_environment_secrets   = optional(map(string))<br>            runtime_environment_variables = optional(map(string))<br>            start_command                 = optional(string)<br>          })))<br>        })))<br>        source_code_version = list(object({<br>          type  = optional(string)<br>          value = string<br>        }))<br>      })))<br>    }))<br>    encryption_configuration = optional(list(object({<br>      kms_key_id = any<br>    })))<br>    health_check_configuration = optional(list(object({<br>      healthy_threshold   = optional(number)<br>      interval            = optional(number)<br>      path                = optional(string)<br>      protocol            = optional(string)<br>      timeout             = optional(number)<br>      unhealthy_threshold = optional(number)<br>    })))<br>    instance_configuration = optional(list(object({<br>      cpu               = optional(string)<br>      instance_role_arn = optional(string)<br>      memory            = optional(string)<br>    })))<br>    network_configuration = optional(list(object({<br>      ip_address_type = optional(string)<br>      ingress_configuration = optional(list(object({<br>        is_publicly_accessible = optional(bool)<br>      })))<br>      egress_configuration = optional(list(object({<br>        egress_type      = optional(string)<br>        vpc_connector_id = optional(any)<br>      })))<br>    })))<br>    observability_configuration = optional(list(object({<br>      observability_enabled          = bool<br>      observability_configuration_id = optional(any)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_vpc_connector"></a> [vpc\_connector](#input\_vpc\_connector) | n/a | <pre>list(object({<br>    id                 = number<br>    security_groups    = list(string)<br>    subnets            = list(string)<br>    vpc_connector_name = string<br>    tags               = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_vpc_endpoint_id"></a> [vpc\_endpoint\_id](#input\_vpc\_endpoint\_id) | n/a | `string` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | `null` | no |
| <a name="input_vpc_ingress_connection"></a> [vpc\_ingress\_connection](#input\_vpc\_ingress\_connection) | n/a | <pre>list(object({<br>    id         = number<br>    name       = string<br>    service_id = any<br>    tags       = optional(map(string))<br>    ingress_vpc_configuration = list(object({<br>      vpc_id          = any<br>      vpc_endpoint_id = any<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_auto_scaling_configuration_version_arn"></a> [auto\_scaling\_configuration\_version\_arn](#output\_auto\_scaling\_configuration\_version\_arn) | n/a |
| <a name="output_auto_scaling_configuration_version_id"></a> [auto\_scaling\_configuration\_version\_id](#output\_auto\_scaling\_configuration\_version\_id) | n/a |
| <a name="output_auto_scaling_configuration_version_name"></a> [auto\_scaling\_configuration\_version\_name](#output\_auto\_scaling\_configuration\_version\_name) | n/a |
| <a name="output_connection_arn"></a> [connection\_arn](#output\_connection\_arn) | n/a |
| <a name="output_connection_id"></a> [connection\_id](#output\_connection\_id) | n/a |
| <a name="output_connection_name"></a> [connection\_name](#output\_connection\_name) | n/a |
| <a name="output_custom_domain_association_domain_name"></a> [custom\_domain\_association\_domain\_name](#output\_custom\_domain\_association\_domain\_name) | n/a |
| <a name="output_custom_domain_association_id"></a> [custom\_domain\_association\_id](#output\_custom\_domain\_association\_id) | n/a |
| <a name="output_custom_domain_association_service_arn"></a> [custom\_domain\_association\_service\_arn](#output\_custom\_domain\_association\_service\_arn) | n/a |
| <a name="output_default_auto_scaling_configuration_version_arn"></a> [default\_auto\_scaling\_configuration\_version\_arn](#output\_default\_auto\_scaling\_configuration\_version\_arn) | n/a |
| <a name="output_default_auto_scaling_configuration_version_id"></a> [default\_auto\_scaling\_configuration\_version\_id](#output\_default\_auto\_scaling\_configuration\_version\_id) | n/a |
| <a name="output_deployment_id"></a> [deployment\_id](#output\_deployment\_id) | n/a |
| <a name="output_deployment_service_arn"></a> [deployment\_service\_arn](#output\_deployment\_service\_arn) | n/a |
| <a name="output_observability_configuration_arn"></a> [observability\_configuration\_arn](#output\_observability\_configuration\_arn) | n/a |
| <a name="output_observability_configuration_id"></a> [observability\_configuration\_id](#output\_observability\_configuration\_id) | n/a |
| <a name="output_service_arn"></a> [service\_arn](#output\_service\_arn) | n/a |
| <a name="output_service_id"></a> [service\_id](#output\_service\_id) | n/a |
| <a name="output_service_name"></a> [service\_name](#output\_service\_name) | n/a |
| <a name="output_vpc_connector_arn"></a> [vpc\_connector\_arn](#output\_vpc\_connector\_arn) | n/a |
| <a name="output_vpc_connector_id"></a> [vpc\_connector\_id](#output\_vpc\_connector\_id) | n/a |
| <a name="output_vpc_connector_name"></a> [vpc\_connector\_name](#output\_vpc\_connector\_name) | n/a |
| <a name="output_vpc_ingress_connection_arn"></a> [vpc\_ingress\_connection\_arn](#output\_vpc\_ingress\_connection\_arn) | n/a |
| <a name="output_vpc_ingress_connection_id"></a> [vpc\_ingress\_connection\_id](#output\_vpc\_ingress\_connection\_id) | n/a |
