variable "name" {
  type    = string
  default = ""
}

variable "id" {
  type    = string
  default = ""
}

locals {
  name_filter = var.name == "" ? {} : map("tag:Name", var.name)
  id_filter   = var.id == "" ? {} : map("vpc-id", var.id)
  filters     = merge(local.name_filter, local.id_filter)
}
