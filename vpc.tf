data "aws_vpc" "this" {
  dynamic "filter" {
    for_each = local.filters

    content {
      name   = filter.key
      values = [filter.value]
    }
  }
}
