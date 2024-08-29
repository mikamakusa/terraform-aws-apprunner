## TAGS

variable "tags" {
  type    = map(string)
  default = {}
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
    id = number
    observability_configuration_name = string
    tags = optional(map(string))
    trace_configuration = optional(list(object({
      vendor = optional(string)
    })))
  }))
  default = []
}

variable "service" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "vpc_connector" {
  type = list(object({
    id = number
  }))
  default = []
}

variable "vpc_ingress_connection" {
  type = list(object({
    id = number
  }))
  default = []
}
