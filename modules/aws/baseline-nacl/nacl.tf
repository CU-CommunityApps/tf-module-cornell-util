module "cornell_data" {
  source = "../cornell-network-data"
}

locals {
  modified_ingress_rules = [
    for rule in module.cornell_data.baseline_nacl_ingress_rules : rule if !contains(var.excluded_cidrs, rule["cidr"])
  ]
  modified_egress_rules = [
    for rule in module.cornell_data.baseline_nacl_egress_rules : rule if !contains(var.excluded_cidrs, rule["cidr"])
  ]
}

resource "aws_network_acl" "baseline" {
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = local.modified_ingress_rules
    content {
      rule_no    = (index(module.cornell_data.baseline_nacl_ingress_rules, ingress.value) + 1) * 100
      protocol   = ingress.value["protocol"]
      action     = ingress.value["rule"]
      cidr_block = ingress.value["cidr"]
      from_port  = ingress.value["from"]
      to_port    = ingress.value["to"]
    }
  }

  dynamic "ingress" {
    for_each = var.additional_ingress_rules
    content {
      rule_no    = ingress.value["rule_no"]
      protocol   = ingress.value["protocol"]
      action     = ingress.value["rule"]
      cidr_block = ingress.value["cidr"]
      from_port  = ingress.value["from"]
      to_port    = ingress.value["to"]
    }
  }

  dynamic "egress" {
    for_each = local.modified_egress_rules
    content {
      rule_no    = (index(module.cornell_data.baseline_nacl_egress_rules, egress.value) + 1) * 100
      protocol   = egress.value["protocol"]
      action     = egress.value["rule"]
      cidr_block = egress.value["cidr"]
      from_port  = egress.value["from"]
      to_port    = egress.value["to"]
    }
  }

  dynamic "egress" {
    for_each = var.additional_egress_rules
    content {
      rule_no    = egress.value["rule_no"]
      protocol   = egress.value["protocol"]
      action     = egress.value["rule"]
      cidr_block = egress.value["cidr"]
      from_port  = egress.value["from"]
      to_port    = egress.value["to"]
    }
  }

  tags = merge({
      Name       = var.network_acl_name == null ? "baseline-nacl" : var.network_acl_name
      "cit:name" = var.network_acl_name == null ? "baseline-nacl" : var.network_acl_name
    },
    var.additional_tags)
}

resource "aws_network_acl_association" "private" {
  for_each = toset(var.network_acl_subnet_ids)

  network_acl_id = aws_network_acl.baseline.id
  subnet_id      = each.key
}
