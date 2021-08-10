output "vpc_id" {
  value       = data.aws_vpc.this.id
  description = "string ||| "
}

output "vpc_cidr" {
  value       = data.aws_vpc.this.cidr_block
  description = "string ||| "
}

output "public_subnet_ids" {
  value       = tolist(local.public_subnets)
  description = "list(string) ||| "
}

output "public_cidrs" {
  value       = [for s in data.aws_subnet.public : s.cidr_block]
  description = "list(string) ||| "
}

output "private_subnet_ids" {
  value       = tolist(local.private_subnets)
  description = "list(string) ||| "
}

output "private_cidrs" {
  value       = [for s in data.aws_subnet.private : s.cidr_block]
  description = "list(string) ||| "
}

output "intra_subnet_ids" {
  value       = tolist(local.intra_subnets)
  description = "list(string) ||| "
}

output "intra_cidrs" {
  value       = [for s in data.aws_subnet.intra : s.cidr_block]
  description = "list(string) ||| "
}

output "service_discovery_id" {
  value       = aws_service_discovery_private_dns_namespace.service.id
  description = "string ||| AWS ID for the Private DNS namespace created in this network."
}

output "service_discovery_name" {
  value       = aws_service_discovery_private_dns_namespace.service.name
  description = "string ||| The root TLD for the Private DNS namespace created in this network."
}
