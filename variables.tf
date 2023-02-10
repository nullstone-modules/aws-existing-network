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
