output "auto_scaling_configuration_version_id" {
  value = try(
    aws_apprunner_auto_scaling_configuration_version.this.*.id
  )
}

output "auto_scaling_configuration_version_arn" {
  value = try(
    aws_apprunner_auto_scaling_configuration_version.this.*.arn
  )
}

output "auto_scaling_configuration_version_name" {
  value = try(
    aws_apprunner_auto_scaling_configuration_version.this.*.auto_scaling_configuration_name
  )
}

output "connection_id" {
  value = try(aws_apprunner_connection.this.*.id)
}

output "connection_arn" {
  value = try(aws_apprunner_connection.this.*.arn)
}

output "connection_name" {
  value = try(aws_apprunner_connection.this.*.connection_name)
}

output "custom_domain_association_id" {
  value = try(aws_apprunner_custom_domain_association.this.*.id)
}

output "custom_domain_association_domain_name" {
  value = try(aws_apprunner_custom_domain_association.this.*.domain_name)
}

output "custom_domain_association_service_arn" {
  value = try(aws_apprunner_custom_domain_association.this.*.service_arn)
}

output "default_auto_scaling_configuration_version_id" {
  value = try(aws_apprunner_default_auto_scaling_configuration_version.this.*.id)
}

output "default_auto_scaling_configuration_version_arn" {
  value = try(aws_apprunner_default_auto_scaling_configuration_version.this.*.auto_scaling_configuration_arn)
}

output "deployment_id" {
  value = try(aws_apprunner_deployment.this.*.id)
}

output "deployment_service_arn" {
  value = try(aws_apprunner_deployment.this.*.service_arn)
}

output "observability_configuration_id" {
  value = try(aws_apprunner_observability_configuration.this.*.id)
}

output "observability_configuration_arn" {
  value = try(aws_apprunner_observability_configuration.this.*.arn)
}

output "service_id" {
  value = try(aws_apprunner_service.this.*.id)
}

output "service_arn" {
  value = try(aws_apprunner_service.this.*.arn)
}

output "service_name" {
  value = try(aws_apprunner_service.this.*.service_name)
}

output "vpc_connector_id" {
  value = try(aws_apprunner_vpc_connector.this.*.id)
}

output "vpc_connector_arn" {
  value = try(aws_apprunner_vpc_connector.this.*.arn)
}

output "vpc_connector_name" {
  value = try(aws_apprunner_vpc_connector.this.*.vpc_connector_name)
}

output "vpc_ingress_connection_id" {
  value = try(aws_apprunner_vpc_ingress_connection.this.*.id)
}

output "vpc_ingress_connection_arn" {
  value = try(aws_apprunner_vpc_ingress_connection.this.*.arn)
}