run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "kms" {
  command = [plan,apply]

  variables {
    alias = [
      {
        id            = 0
        name          = "alias/my-key-alias"
        target_key_id = 0
      }
    ]
    ciphertext = [
      {
        id      = 0
        key_id  = 1
        plaintext = {
          client_id     = "e587dbae22222f55da22"
          client_secret = "8289575d00000ace55e1815ec13673955721b8a5"
        }
      }
    ]
    custom_key_store = [
      {
        id                        = 0
        cloud_hsm_cluster_id      = var.cloud_hsm_cluster_id
        custom_key_store_name     = "kms-custom-key-store-test"
        key_store_password        = "noplaintextpasswords1"
        trust_anchor_certificate  = file("anchor-certificate.crt")
      }
    ]
    external_key = [
      {
        id          = 0
        description = "KMS EXTERNAL for AMI encryption"
      },
      {
        id                      = 1
        description             = "Multi-Region primary key"
        deletion_window_in_days = 30
        multi_region            = true
        enabled                 = true
      }
    ]
    grant = [
      {
        id = 0
      }
    ]
    key = [
      {
        id          = 0
        is_enabled  = true
      },
      {
        id          = 1
        description = "oauth config"
        is_enabled  = true
      },
      {
        id = 2
        description             = "An example symmetric encryption KMS key"
        enable_key_rotation     = true
        deletion_window_in_days = 20
        is_enabled              = true
      },
      {
        id                      = 3
        description             = "Multi-Region primary key"
        deletion_window_in_days = 30
        multi_region            = true
      }
    ]
    replica_external_key = [
      {
        id                      = 0
        description             = "Multi-Region replica key"
        deletion_window_in_days = 7
        primary_key_id          = 1
      }
    ]
    replica_key = [
      {
        id = 0
        description             = "Multi-Region replica key"
        deletion_window_in_days = 7
        primary_key_id          = 3
      }
    ]
  }
}