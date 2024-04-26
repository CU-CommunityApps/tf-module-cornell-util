# tf-module-cornell-util/modules/aws/baseline-nacl

This Terraform module creates a standard AWS Network ACL for Cornell AWS VPCs.

# Usage

```
module "baseline_nacl" {
  source = "git::https://github.com/CU-CommunityApps/tf-module-cornell-util.git//modules/aws/baseline-nacl?ref=v1.0.0"
  providers = {
    aws = aws.uswest2
  }

  additional_tags        = {}
  network_acl_name       = "cornell-baseline-nacl"
  network_acl_subnet_ids = var.subnet_ids
  vpc_id                 = var.vpc_id
}
```