## Requirements

| Name | Version    |
|------|------------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | \>= 5.60.0 |

## Providers

| Name | Version    |
|------|------------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | \>= 5.60.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_ciphertext.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_ciphertext) | resource |
| [aws_kms_custom_key_store.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_custom_key_store) | resource |
| [aws_kms_external_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_external_key) | resource |
| [aws_kms_grant.grant](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_grant) | resource |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_kms_replica_external_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_replica_external_key) | resource |
| [aws_kms_replica_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_replica_key) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_default_tags.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alias"></a> [alias](#input\_alias) | n/a | <pre>list(object({<br>    id            = number<br>    target_key_id = any<br>    name          = optional(string)<br>    name_prefix   = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_ciphertext"></a> [ciphertext](#input\_ciphertext) | n/a | <pre>list(object({<br>    id        = number<br>    key_id    = any<br>    plaintext = string<br>    context   = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_cloud_hsm_cluster_id"></a> [cloud\_hsm\_cluster\_id](#input\_cloud\_hsm\_cluster\_id) | n/a | `string` | `null` | no |
| <a name="input_custom_key_store"></a> [custom\_key\_store](#input\_custom\_key\_store) | n/a | <pre>list(object({<br>    id                       = number<br>    cloud_hsm_cluster_id     = any<br>    custom_key_store_name    = string<br>    key_store_password       = string<br>    trust_anchor_certificate = string<br>  }))</pre> | `[]` | no |
| <a name="input_external_key"></a> [external\_key](#input\_external\_key) | n/a | <pre>list(object({<br>    id                                 = number<br>    bypass_policy_lockout_safety_check = optional(bool)<br>    deletion_window_in_days            = optional(number)<br>    description                        = optional(string)<br>    enabled                            = optional(bool)<br>    key_material_base64                = optional(string)<br>    multi_region                       = optional(bool)<br>    policy                             = optional(string)<br>    tags                               = optional(map(string))<br>    valid_to                           = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_grant"></a> [grant](#input\_grant) | n/a | <pre>list(object({<br>    id                    = number<br>    grantee_principal     = string<br>    key_id                = any<br>    operations            = optional(set(string))<br>    name                  = optional(string)<br>    retiring_principal    = optional(string)<br>    grant_creation_tokens = optional(set(string))<br>    retire_on_delete      = optional(bool)<br>    constraints = optional(list(object({<br>      encryption_context_equals = optional(map(string))<br>      encryption_context_subset = optional(map(string))<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_key"></a> [key](#input\_key) | n/a | <pre>list(object({<br>    id                                 = number<br>    customer_master_key_spec           = optional(string)<br>    deletion_window_in_days            = optional(number)<br>    description                        = optional(string)<br>    enable_key_rotation                = optional(bool)<br>    is_enabled                         = optional(bool)<br>    key_usage                          = optional(string)<br>    policy                             = optional(strng)<br>    tags                               = optional(map(string))<br>    bypass_policy_lockout_safety_check = optional(bool)<br>    custom_key_store_id                = optional(string)<br>    multi_region                       = optional(bool)<br>    rotation_period_in_days            = optional(number)<br>    xks_key_id                         = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_key_policy"></a> [key\_policy](#input\_key\_policy) | n/a | <pre>list(object({<br>    id                                 = number<br>    key_id                             = any<br>    policy                             = string<br>    bypass_policy_lockout_safety_check = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_replica_external_key"></a> [replica\_external\_key](#input\_replica\_external\_key) | n/a | <pre>list(object({<br>    id                                 = number<br>    primary_key_id                     = any<br>    bypass_policy_lockout_safety_check = optional(bool)<br>    deletion_window_in_days            = optional(number)<br>    description                        = optional(string)<br>    enabled                            = optional(bool)<br>    key_material_base64                = optional(string)<br>    policy                             = optional(string)<br>    tags                               = optional(map(string))<br>    valid_to                           = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_replica_key"></a> [replica\_key](#input\_replica\_key) | n/a | <pre>list(object({<br>    id                                 = number<br>    primary_key_id                     = any<br>    bypass_policy_lockout_safety_check = optional(bool)<br>    deletion_window_in_days            = optional(number)<br>    description                        = optional(string)<br>    enabled                            = optional(bool)<br>    policy                             = optional(string)<br>    tags                               = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_key_store_cloud_hsm_cluster_id"></a> [custom\_key\_store\_cloud\_hsm\_cluster\_id](#output\_custom\_key\_store\_cloud\_hsm\_cluster\_id) | n/a |
| <a name="output_custom_key_store_id"></a> [custom\_key\_store\_id](#output\_custom\_key\_store\_id) | n/a |
| <a name="output_custom_key_store_name"></a> [custom\_key\_store\_name](#output\_custom\_key\_store\_name) | n/a |
| <a name="output_custom_key_store_password"></a> [custom\_key\_store\_password](#output\_custom\_key\_store\_password) | n/a |
| <a name="output_external_keu_usage"></a> [external\_keu\_usage](#output\_external\_keu\_usage) | n/a |
| <a name="output_external_key_arn"></a> [external\_key\_arn](#output\_external\_key\_arn) | n/a |
| <a name="output_external_key_id"></a> [external\_key\_id](#output\_external\_key\_id) | n/a |
| <a name="output_external_key_valid_to"></a> [external\_key\_valid\_to](#output\_external\_key\_valid\_to) | n/a |
| <a name="output_grant_grantee_principal"></a> [grant\_grantee\_principal](#output\_grant\_grantee\_principal) | n/a |
| <a name="output_grant_id"></a> [grant\_id](#output\_grant\_id) | n/a |
| <a name="output_grant_name"></a> [grant\_name](#output\_grant\_name) | n/a |
| <a name="output_grant_token"></a> [grant\_token](#output\_grant\_token) | n/a |
| <a name="output_key_arn"></a> [key\_arn](#output\_key\_arn) | n/a |
| <a name="output_key_custome_key_store_id"></a> [key\_custome\_key\_store\_id](#output\_key\_custome\_key\_store\_id) | n/a |
| <a name="output_key_id"></a> [key\_id](#output\_key\_id) | n/a |
| <a name="output_key_policy"></a> [key\_policy](#output\_key\_policy) | n/a |
| <a name="output_key_policy_id"></a> [key\_policy\_id](#output\_key\_policy\_id) | n/a |
| <a name="output_key_usage"></a> [key\_usage](#output\_key\_usage) | n/a |
| <a name="output_kms_alias_arn"></a> [kms\_alias\_arn](#output\_kms\_alias\_arn) | n/a |
| <a name="output_kms_alias_id"></a> [kms\_alias\_id](#output\_kms\_alias\_id) | n/a |
| <a name="output_kms_alias_name"></a> [kms\_alias\_name](#output\_kms\_alias\_name) | n/a |
| <a name="output_kms_alias_target_key_arn"></a> [kms\_alias\_target\_key\_arn](#output\_kms\_alias\_target\_key\_arn) | n/a |
| <a name="output_kms_alias_target_key_id"></a> [kms\_alias\_target\_key\_id](#output\_kms\_alias\_target\_key\_id) | n/a |
| <a name="output_kms_ciphertext_blob"></a> [kms\_ciphertext\_blob](#output\_kms\_ciphertext\_blob) | n/a |
| <a name="output_kms_ciphertext_context"></a> [kms\_ciphertext\_context](#output\_kms\_ciphertext\_context) | n/a |
| <a name="output_kms_ciphertext_id"></a> [kms\_ciphertext\_id](#output\_kms\_ciphertext\_id) | n/a |
| <a name="output_kms_ciphertext_key_id"></a> [kms\_ciphertext\_key\_id](#output\_kms\_ciphertext\_key\_id) | n/a |
| <a name="output_replica_external_key_id"></a> [replica\_external\_key\_id](#output\_replica\_external\_key\_id) | n/a |
| <a name="output_replica_external_key_policy"></a> [replica\_external\_key\_policy](#output\_replica\_external\_key\_policy) | n/a |
