variable "additional_egress_rules" {
  description = "Egress rules to add to the NACL, in addition to the standard rules."
  default = []
}

variable "additional_ingress_rules" {
  description = "Ingress rules to add to the NACL, in addition to the standard rules."
  default = []
}

variable "additional_tags" {
  default = {}
}

variable "excluded_cidrs" {
  description = "CIDRs in standard rules to exclude from the NACL."
  default = []
}

variable "network_acl_name" {
  description = "The name of the NACL."
  default = null
}

variable "network_acl_subnet_ids" {
  description = "The IDs of subnets that should be associated with the NACL."
  default = []
}

variable "vpc_id" {
  description = "The ID of the VPC where the NACL should be created. Leave null to avoid creation of a new NACL."
}
