# Ingress and egress rules from input strings.
locals {
  ingress_rules = length(var.ingress) > 0 ? [
    for rule in split(";", var.ingress) :
    {
      port   = element(split(",", rule), 0),
      protocol    = element(split(",", rule), 1),
      cidr_blocks = [element(split(",", rule), 2)]
    }
  ] : []

  egress_rules = length(var.egress) > 0 ? [
    for rule in split(";", var.egress) :
    {
      port   = element(split(",", rule), 0),
      protocol    = element(split(",", rule), 1),
      cidr_blocks = [element(split(",", rule), 2)]
    }
  ] : []
}

# AWS security group with dynamic ingress and egress rules.
resource "aws_security_group" "this" {
  name        = format("secgroup-%s", var.name)
  description = "Security group with custom rules"

  dynamic "ingress" {
    for_each = local.ingress_rules
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = local.egress_rules
    content {
      from_port   = egress.value.port
      to_port     = egress.value.port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}
