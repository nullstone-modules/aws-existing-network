resource "aws_eip" "nat" {
  count = local.nat_gateway_count

  vpc  = true
  tags = merge({ "Name" = format("%s-%s", var.name, element(var.azs, var.single_nat_gateway ? 0 : count.index)) }, var.tags)
}

resource "aws_nat_gateway" "this" {
  count = local.nat_gateway_count

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = var.nat_subnet_id
  tags          = merge({ "Name" = format("%s-%s", var.name, element(var.azs, var.single_nat_gateway ? 0 : count.index)) }, var.tags)
}

resource "aws_route" "private_nat_gateway" {
  count = local.nat_gateway_count

  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.this.*.id, count.index)

  timeouts {
    create = "5m"
  }
}
