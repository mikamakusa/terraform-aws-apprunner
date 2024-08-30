variable "tags" {
  type    = map(string)
  default = {}
}

variable "cloud_hsm_cluster_id" {
  type    = string
  default = null
}

variable "alias" {
  type = list(object({
    id            = number
    target_key_id = any
    name          = optional(string)
    name_prefix   = optional(string)
  }))
  default = []
}

variable "ciphertext" {
  type = list(object({
    id        = number
    key_id    = any
    plaintext = string
    context   = optional(map(string))
  }))
  default = []
}

variable "custom_key_store" {
  type = list(object({
    id                       = number
    cloud_hsm_cluster_id     = any
    custom_key_store_name    = string
    key_store_password       = string
    trust_anchor_certificate = string
  }))
  default = []
}

variable "external_key" {
  type = list(object({
    id                                 = number
    bypass_policy_lockout_safety_check = optional(bool)
    deletion_window_in_days            = optional(number)
    description                        = optional(string)
    enabled                            = optional(bool)
    key_material_base64                = optional(string)
    multi_region                       = optional(bool)
    policy                             = optional(string)
    tags                               = optional(map(string))
    valid_to                           = optional(string)
  }))
  default = []
}

variable "grant" {
  type = list(object({
    id                    = number
    grantee_principal     = string
    key_id                = any
    operations            = optional(set(string))
    name                  = optional(string)
    retiring_principal    = optional(string)
    grant_creation_tokens = optional(set(string))
    retire_on_delete      = optional(bool)
    constraints = optional(list(object({
      encryption_context_equals = optional(map(string))
      encryption_context_subset = optional(map(string))
    })), [])
  }))
  default = []

  validation {
    condition = lenght([
      for a in var.grant : true if contains(["Decrypt", "Encrypt", "GenerateDataKey", "GenerateDataKeyWithoutPlaintext", "ReEncryptFrom", "ReEncryptTo", "Sign", "Verify", "GetPublicKey", "CreateGrant", "RetireGrant", "DescribeKey", "GenerateDataKeyPair", "GenerateDataKeyPairWithoutPlaintext"], a.operations)
    ]) == length(var.grant)
    error_message = "Valid values are Decrypt, Encrypt, GenerateDataKey, GenerateDataKeyWithoutPlaintext, ReEncryptFrom, ReEncryptTo, Sign, Verify, GetPublicKey, CreateGrant, RetireGrant, DescribeKey, GenerateDataKeyPair, or GenerateDataKeyPairWithoutPlaintext."
  }
}

variable "key" {
  type = list(object({
    id                                 = number
    customer_master_key_spec           = optional(string)
    deletion_window_in_days            = optional(number)
    description                        = optional(string)
    enable_key_rotation                = optional(bool)
    is_enabled                         = optional(bool)
    key_usage                          = optional(string)
    policy                             = optional(string)
    tags                               = optional(map(string))
    bypass_policy_lockout_safety_check = optional(bool)
    custom_key_store_id                = optional(string)
    multi_region                       = optional(bool)
    rotation_period_in_days            = optional(number)
    xks_key_id                         = optional(string)
  }))
  default = []

  validation {
    condition = length([
      for a in var.key : true if contains(["ENCRYPT_DECRYPT", "SIGN_VERIFY", "GENERATE_VERIFY_MAC"], a.key_usage)
    ]) == length(var.key)
    error_message = "Valid values: ENCRYPT_DECRYPT, SIGN_VERIFY, or GENERATE_VERIFY_MAC."
  }

  validation {
    condition = length([
      for b in var.key : true if contains(["SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, HMAC_256, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1"], b.customer_master_key_spec)
    ]) == length(var.key)
    error_message = " Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, HMAC_256, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1."
  }
}

variable "key_policy" {
  type = list(object({
    id                                 = number
    key_id                             = any
    policy                             = string
    bypass_policy_lockout_safety_check = optional(bool)
  }))
  default = []
}

variable "replica_external_key" {
  type = list(object({
    id                                 = number
    primary_key_id                     = any
    bypass_policy_lockout_safety_check = optional(bool)
    deletion_window_in_days            = optional(number)
    description                        = optional(string)
    enabled                            = optional(bool)
    key_material_base64                = optional(string)
    policy                             = optional(string)
    tags                               = optional(map(string))
    valid_to                           = optional(string)
  }))
  default = []
}

variable "replica_key" {
  type = list(object({
    id                                 = number
    primary_key_id                     = any
    bypass_policy_lockout_safety_check = optional(bool)
    deletion_window_in_days            = optional(number)
    description                        = optional(string)
    enabled                            = optional(bool)
    policy                             = optional(string)
    tags                               = optional(map(string))
  }))
  default = []
}