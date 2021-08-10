resource "aws_service_discovery_private_dns_namespace" "service" {
  name = lower(var.service_namespace)
  vpc  = data.aws_vpc.this.id
  tags = data.ns_workspace.this.tags
}
