variable "additional_tags" {
  default = {}
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
