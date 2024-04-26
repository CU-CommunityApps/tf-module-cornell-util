# tf-module-cornell-util/modules/aws/baseline-nacl

This Terraform module creates a standard AWS Network ACL for Cornell AWS VPCs.

# Usage

```
locals {
  additional_rules = [
    { rule_no = 10, protocol = -1, from = 0, to = 0, rule = "allow", cidr = "1.2.3.4/32" },
  ]
}

module "cornell_network_data" {
  source = "git::https://github.com/CU-CommunityApps/tf-module-cornell-util.git//modules/aws/cornell-network-data?ref=v1.1.0"
}

module "baseline_nacl" {
  source = "git::https://github.com/CU-CommunityApps/tf-module-cornell-util.git//modules/aws/baseline-nacl?ref=v1.1.0"
  providers = {
    aws = aws.uswest2
  }

  additional_egress_rules = local.additional_rules
  additional_ingress_rules = local.additional_rules
  additional_tags        = {}
  excluded_cidrs = concat(
    module.cornell_network_data.directory_server_cidrs,
    module.cornell_network_data.kerberos_server_cidrs,
  )
  network_acl_name       = "cornell-baseline-nacl"
  network_acl_subnet_ids = var.subnet_ids
  vpc_id                 = var.vpc_id
}
```