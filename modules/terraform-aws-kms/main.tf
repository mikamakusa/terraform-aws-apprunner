resource "aws_kms_alias" "this" {
  count = length(var.key) == 0 ? 0 : length(var.alias)
  target_key_id = try(
    element(aws_kms_key.this.*.id, lookup(var.alias[count.index], "target_key_id"))
  )
  name        = lookup(var.alias[count.index], "name")
  name_prefix = lookup(var.alias[count.index], "name_prefix")
}

resource "aws_kms_ciphertext" "this" {
  count = length(var.key) == 0 ? 0 : length(var.ciphertext)
  key_id = try(
    element(aws_kms_key.this.*.id, lookup(var.ciphertext[count.index], "key_id"))
  )
  plaintext = lookup(var.ciphertext[count.index], "plaintext")
  context   = lookup(var.ciphertext[count.index], "context")
}

resource "aws_kms_custom_key_store" "this" {
  count = length(var.custom_key_store)
  cloud_hsm_cluster_id = try(
    element(var.cloud_hsm_cluster_id, lookup(var.custom_key_store[count.index], "cloud_hsm_cluster_id"))
  )
  custom_key_store_name    = lookup(var.custom_key_store[count.index], "custom_key_store_name")
  key_store_password       = sensitive(lookup(var.custom_key_store[count.index], "key_store_password"))
  trust_anchor_certificate = file(join("/", [path.cwd, "certificate", lookup(var.custom_key_store[count.index], "trust_anchor_certificate")]))
}

resource "aws_kms_external_key" "this" {
  count                              = length(var.external_key)
  bypass_policy_lockout_safety_check = lookup(var.external_key[count.index], "bypass_policy_lockout_safety_check")
  deletion_window_in_days            = lookup(var.external_key[count.index], "deletion_window_in_days")
  description                        = lookup(var.external_key[count.index], "description")
  enabled                            = lookup(var.external_key[count.index], "enabled")
  key_material_base64                = sensitive(lookup(var.external_key[count.index], "key_material_base64"))
  multi_region                       = lookup(var.external_key[count.index], "multi_region")
  policy                             = lookup(var.external_key[count.index], "policy")
  tags = merge(
    data.aws_default_tags.this.tags,
    var.tags,
    lookup(var.external_key[count.index], "tags")
  )
  valid_to = lookup(var.external_key[count.index], "valid_to")
}

resource "aws_kms_grant" "grant" {
  count             = length(var.key) == 0 ? 0 : length(var.grant)
  grantee_principal = lookup(var.grant[count.index], "grantee_principal")
  key_id = try(
    element(aws_kms_key.this.*.id, lookup(var.grant[count.index], "key_id"))
  )
  operations            = lookup(var.grant[count.index], "operations")
  name                  = lookup(var.grant[count.index], "name")
  retiring_principal    = lookup(var.grant[count.index], "retiring_principal")
  grant_creation_tokens = lookup(var.grant[count.index], "grant_creation_tokens")
  retire_on_delete      = lookup(var.grant[count.index], "retire_on_delete")

  dynamic "constraints" {
    for_each = try(lookup(var.grant[count.index], "constraints") == null ? [] : ["constraints"])
    content {
      encryption_context_equals = lookup(constraints.value, "encryption_context_equals")
      encryption_context_subset = lookup(constraints.value, "encryption_context_subset")
    }
  }
}

resource "aws_kms_key" "this" {
  count                    = length(var.key)
  customer_master_key_spec = lookup(var.key[count.index], "customer_master_key_spec")
  deletion_window_in_days  = lookup(var.key[count.index], "deletion_window_in_days")
  description              = lookup(var.key[count.index], "description")
  enable_key_rotation      = lookup(var.key[count.index], "enable_key_rotation")
  is_enabled               = lookup(var.key[count.index], "is_enabled")
  key_usage                = lookup(var.key[count.index], "key_usage")
  policy                   = jsonencode(lookup(var.key[count.index], "policy"))
  tags = merge(
    var.tags,
    lookup(var.key[count.index], tags),
    data.aws_default_tags.this.tags
  )
  bypass_policy_lockout_safety_check = lookup(var.key[count.index], "bypass_policy_lockout_safety_check")
  custom_key_store_id                = lookup(var.key[count.index], "custom_key_store_id")
  multi_region                       = lookup(var.key[count.index], "multi_region")
  rotation_period_in_days            = lookup(var.key[count.index], "rotation_period_in_days")
  xks_key_id                         = lookup(var.key[count.index], "xks_key_id")
}

resource "aws_kms_key_policy" "this" {
  count = length(var.key) == 0 ? 0 : length(var.key_policy)
  key_id = try(
    element(aws_kms_key.this.*.id, lookup(var.key_policy[count.index], "key_id"))
  )
  policy                             = lookup(var.key_policy[count.index], "policy")
  bypass_policy_lockout_safety_check = lookup(var.key_policy[count.index], "bypass_policy_lockout_safety_check")
}

resource "aws_kms_replica_external_key" "this" {
  count = length(var.external_key) == 0 ? 0 : length(var.replica_external_key)
  primary_key_arn = try(
    element(aws_kms_external_key.this.*.arn, lookup(var.replica_external_key[count.index], "primary_key_id"))
  )
  bypass_policy_lockout_safety_check = true
  deletion_window_in_days            = lookup(var.replica_external_key[count.index], "deletion_window_in_days")
  description                        = lookup(var.replica_external_key[count.index], "description")
  enabled                            = lookup(var.replica_external_key[count.index], "enabled")
  key_material_base64                = sensitive(lookup(var.replica_external_key[count.index], "key_material_base64"))
  policy                             = lookup(var.replica_external_key[count.index], "policy")
  tags = merge(
    var.tags,
    data.aws_default_tags.this.tags,
    lookup(var.replica_external_key[count.index], "tags")
  )
  valid_to = lookup(var.replica_external_key[count.index], "valid_to")
}

resource "aws_kms_replica_key" "this" {
  count                              = length(var.key) == 0 ? 0 : length(var.replica_key)
  primary_key_arn                    = try(
    element(aws_kms_key.this.*.arn, lookup(var.replica_key[count.index], "primary_key_id"))
  )
  bypass_policy_lockout_safety_check = true
  deletion_window_in_days            = lookup(var.replica_key[count.index], "deletion_window_in_days")
  description                        = lookup(var.replica_key[count.index], "description")
  enabled                            = lookup(var.replica_key[count.index], "enabled")
  policy                             = lookup(var.replica_key[count.index], "policy")
  tags                               = merge(
    data.aws_default_tags.this.tags,
    var.tags,
    lookup(var.replica_key[count.index], "tags")
  )
}