data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
}

data "aws_route_tables" "all" {
  for_each = toset(data.aws_subnets.all.ids)
  filter {
    name   = "association.subnet-id"
    values = [each.value]
  }
}

data "aws_route_table" "all" {
  for_each       = { for subnet_id, rtbs in data.aws_route_tables.all : subnet_id => rtbs.ids if length(rtbs.ids) > 0 }
  route_table_id = tolist(each.value)[0]
}

locals {
  routes = flatten([for subnet_id, rtb in data.aws_route_table.all : [for rt in rtb.routes : {
    id             = rtb.id
    gateway_id     = rt.gateway_id
    nat_gateway_id = rt.nat_gateway_id
    subnet_id      = subnet_id
  }]])
  all_subnet_ids  = data.aws_subnets.all.ids
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
