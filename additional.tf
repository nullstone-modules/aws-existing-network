module "additional" {
  source = "./additional"

  name = local.resource_name
  tags = local.tags

  vpc_id          = data.aws_vpc.this.id
  azs             = data.aws_availability_zones.this.names
  private_subnets = var.additional_private_subnets

  single_nat_gateway = true
  nat_subnet_id      = try(local.public_subnets[0], "")
}
