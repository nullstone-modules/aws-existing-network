variable "id" {
  type        = string
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

variable "additional_private_subnets" {
  type        = list(string)
  description = "Network ranges for additional private subnets created in the VPC. Devices in private subnets communicate to internet through a NAT Gateway."
  default     = []
}
