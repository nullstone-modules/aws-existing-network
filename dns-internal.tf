resource "aws_route53_zone" "internal" {
  name    = var.internal_namespace
  comment = "Supports internal DNS discovery of services"

  vpc {
    vpc_id = data.aws_vpc.this.id
  }

  tags = data.ns_workspace.this.tags
}
