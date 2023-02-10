resource "random_string" "resource_suffix" {
  length  = 5
  lower   = true
  upper   = false
  numeric = false
  special = false
}

locals {
  resource_name = "${data.ns_workspace.this.block_ref}-${random_string.resource_suffix.result}"
}
