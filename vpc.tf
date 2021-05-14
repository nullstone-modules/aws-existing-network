data "aws_vpc" "this" {
  filter {
    name   = "vpc-id"
    values = [var.id]
  }
}
