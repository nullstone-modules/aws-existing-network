data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.this.id
}

data "aws_subnet" "each" {
  for_each = data.aws_subnet_ids.all.ids
  id       = each.value
}

data "aws_route_tables" "all" {
  for_each = data.aws_subnet.each
  filter {
    name   = "association.subnet-id"
    values = [each.value.id]
  }
}

data "aws_route_table" "all" {
  for_each       = data.aws_route_tables.all
  route_table_id = tolist(each.value.ids)[0]
}

locals {
  routes = flatten([for subnet_id, rtb in data.aws_route_table.all : [for rt in rtb.routes : {
    id             = rtb.id
    gateway_id     = rt.gateway_id
    nat_gateway_id = rt.nat_gateway_id
    subnet_id      = subnet_id
  }]])
  all_subnet_ids  = flatten(data.aws_subnet_ids.all.*.ids)
  public_subnets  = toset(compact([for rt in local.routes : (rt.gateway_id != "" ? rt.subnet_id : "")]))
  private_subnets = toset(compact([for rt in local.routes : (rt.nat_gateway_id != "" ? rt.subnet_id : "")]))
  intra_subnets   = setsubtract(setsubtract(local.all_subnet_ids, local.public_subnets), local.private_subnets)
}

data "aws_subnet" "public" {
  for_each = local.public_subnets
  id       = each.value
}

data "aws_subnet" "private" {
  for_each = local.private_subnets
  id       = each.value
}

data "aws_subnet" "intra" {
  for_each = local.intra_subnets
  id       = each.value
}
