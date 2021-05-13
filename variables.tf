variable "id" {
  type        = string
  default     = ""
  description = <<EOF
The ID of the VPC to match.
EOF
}

variable "service_namespace" {
  type        = string
  description = <<EOF
Private DNS Domain to register in the network that is used to attach dynamically allocated services. (e.g. containers)
EOF
  default     = "service"
}

variable "internal_namespace" {
  type        = string
  description = <<EOF
Private DNS Domain to register in the network that is used to attach managed services. (e.g. postgres)
EOF
  default     = "internal"
}

locals {
  id_filter = var.id == "" ? {} : map("vpc-id", var.id)
  filters   = merge(local.id_filter)
}
