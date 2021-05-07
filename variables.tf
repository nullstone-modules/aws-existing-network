variable "id" {
  type    = string
  default = ""
  description = <<EOF
The ID of the VPC to match.
EOF
}

locals {
  id_filter   = var.id == "" ? {} : map("vpc-id", var.id)
  filters     = merge(local.id_filter)
}
