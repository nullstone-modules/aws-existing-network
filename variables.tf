variable "name" {
  type    = string
  description = <<EOF
The Name of the VPC to match.
At least one filter is required: `id`, `name`.
Specifying both is not desired; the module will attempt to filter on both values.
EOF
}

variable "id" {
  type    = string
  description = <<EOF
The ID of the VPC to match.
At least one filter is required: `id`, `name`.
Specifying both is not desired; the module will attempt to filter on both values.
EOF
}

locals {
  name_filter = var.name == "" ? {} : map("tag:Name", var.name)
  id_filter   = var.id == "" ? {} : map("vpc-id", var.id)
  filters     = merge(local.name_filter, local.id_filter)
}
