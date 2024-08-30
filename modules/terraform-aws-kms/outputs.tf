## Alias ##

output "kms_alias_arn" {
  value = try(
    aws_kms_alias.this.*.arn
  )
}

output "kms_alias_id" {
  value = try(
    aws_kms_alias.this.*.id
  )
}

output "kms_alias_name" {
  value = try(
    aws_kms_alias.this.*.name
  )
}

output "kms_alias_target_key_id" {
  value = try(
    aws_kms_alias.this.*.target_key_id
  )
}

output "kms_alias_target_key_arn" {
  value = try(
    aws_kms_alias.this.*.target_key_arn
  )
}

## Ciphertext ##

output "kms_ciphertext_id" {
  value = try(
    aws_kms_ciphertext.this.*.id
  )
}

output "kms_ciphertext_blob" {
  value = try(
    aws_kms_ciphertext.this.*.ciphertext_blob
  )
}

output "kms_ciphertext_context" {
  value = try(
    aws_kms_ciphertext.this.*.context
  )
}

output "kms_ciphertext_key_id" {
  value = try(
    aws_kms_ciphertext.this.*.key_id
  )
}

## Custom Key Store ##

output "custom_key_store_id" {
  value = try(
    aws_kms_custom_key_store.this.*.id
  )
}

output "custom_key_store_cloud_hsm_cluster_id" {
  value = try(
    aws_kms_custom_key_store.this.*.cloud_hsm_cluster_id
  )
}

output "custom_key_store_name" {
  value = try(
    aws_kms_custom_key_store.this.*.custom_key_store_name
  )
}

output "custom_key_store_password" {
  value = sensitive(try(
    aws_kms_custom_key_store.this.*.key_store_password
  ))
}

## External Key ##

output "external_key_id" {
  value = try(
    aws_kms_external_key.this.*.id
  )
}

output "external_key_arn" {
  value = try(
    aws_kms_external_key.this.*.arn
  )
}

output "external_key_valid_to" {
  value = try(
    aws_kms_external_key.this.*.valid_to
  )
}

output "external_keu_usage" {
  value = try(
    aws_kms_external_key.this.*.key_usage
  )
}

## Grant ##

output "grant_id" {
  value = try(
    aws_kms_grant.grant.*.id
  )
}

output "grant_name" {
  value = try(
    aws_kms_grant.grant.*.name
  )
}

output "grant_token" {
  value = try(
    aws_kms_grant.grant.*.grant_token
  )
}

output "grant_grantee_principal" {
  value = try(
    aws_kms_grant.grant.*.grantee_principal
  )
}

## Key ##

output "key_id" {
  value = try(
    aws_kms_key.this.*.id
  )
}

output "key_arn" {
  value = try(
    aws_kms_key.this.*.arn
  )
}

output "key_usage" {
  value = try(
    aws_kms_key.this.*.key_usage
  )
}

output "key_custome_key_store_id" {
  value = try(
    aws_kms_key.this.*.custom_key_store_id
  )
}

## Key Policy ##

output "key_policy_id" {
  value = try(
    aws_kms_key_policy.this.*.id
  )
}

output "key_policy" {
  value = try(
    aws_kms_key_policy.this.*.policy
  )
}

## Replica External Key ##

output "replica_external_key_id" {
  value = try(
    aws_kms_replica_external_key.this.*.id
  )
}

output "replica_external_key_policy" {
  value = try(
    aws_kms_replica_external_key.this.*.policy
  )
}