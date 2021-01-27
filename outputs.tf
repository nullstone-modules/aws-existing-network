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

//output "internal_zone_id" {
//  value       = aws_route53_zone.internal.zone_id
//  description = "string ||| "
//}
