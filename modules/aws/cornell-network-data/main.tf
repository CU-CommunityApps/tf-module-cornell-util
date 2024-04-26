locals {
  public_cidrs = [
    "128.84.0.0/16",
    "128.253.0.0/16",
    "132.236.0.0/16",
    "192.35.82.0/24",
    "192.122.235.0/24",
    "192.122.236.0/24",
  ]

  kerberos_server_cidrs = [
    "52.200.35.38/32",  # kerberos-aws.login.cornell.edu
    "52.201.66.104/32", # kerberos-aws2.login.cornell.edu
  ]

  directory_server_cidrs = [
    "35.170.14.255/32", # Elastic IP of AWS-based PROD directory (test.directory.cornell.edu); IP address #1
    "3.229.3.150/32",   # Elastic IP of AWS-based PROD directory (test.directory.cornell.edu); IP address #2
    "3.228.209.25/32",  # Elastic IP of AWS-based PROD directory (query.directory.cornell.edu); IP address #1
    "3.218.140.210/32", # Elastic IP of AWS-based PROD directory (query.directory.cornell.edu); IP address #2
  ]

  baseline_nacl_ingress_rules = concat([
    { protocol = 6, from = 22, to = 22, rule = "allow", cidr = "0.0.0.0/0" },
    { protocol = 6, from = 80, to = 80, rule = "allow", cidr = "0.0.0.0/0" },
    { protocol = 6, from = 443, to = 443, rule = "allow", cidr = "0.0.0.0/0" },
    { protocol = 6, from = 1024, to = 65535, rule = "allow", cidr = "0.0.0.0/0" },
    { protocol = 17, from = 1024, to = 65535, rule = "allow", cidr = "0.0.0.0/0" },
    { protocol = 17, from = 123, to = 123, rule = "allow", cidr = "0.0.0.0/0" },
    { protocol = -1, from = 0, to = 0, rule = "allow", cidr = "10.0.0.0/8" },
    ], [
    for cidr in local.public_cidrs : {
      protocol = -1,
      from     = 0,
      to       = 0,
      rule     = "allow",
      cidr     = cidr
    }
    ], [
    for cidr in local.kerberos_server_cidrs : {
      protocol = -1,
      from     = 0,
      to       = 0,
      rule     = "allow",
      cidr     = cidr
    }
  ])

  baseline_nacl_egress_rules = concat([
    { protocol = 6, from = 22, to = 22, rule = "allow", cidr = "0.0.0.0/0" },
    { protocol = 6, from = 80, to = 80, rule = "allow", cidr = "0.0.0.0/0" },
    { protocol = 6, from = 443, to = 443, rule = "allow", cidr = "0.0.0.0/0" },
    { protocol = 6, from = 1024, to = 65535, rule = "allow", cidr = "0.0.0.0/0" },
    { protocol = 17, from = 1024, to = 65535, rule = "allow", cidr = "0.0.0.0/0" },
    { protocol = 17, from = 123, to = 123, rule = "allow", cidr = "0.0.0.0/0" },
    { protocol = -1, from = 0, to = 0, rule = "allow", cidr = "10.0.0.0/8" },
    ], [
    for cidr in local.public_cidrs : {
      protocol = -1,
      from     = 0,
      to       = 0,
      rule     = "allow",
      cidr     = cidr
    }
    ], [
    for cidr in local.kerberos_server_cidrs : {
      protocol = -1,
      from     = 0,
      to       = 0,
      rule     = "allow",
      cidr     = cidr
    }
    ], [
    for cidr in local.directory_server_cidrs : {
      protocol = -1,
      from     = 0,
      to       = 0,
      rule     = "allow",
      cidr     = cidr
    }
  ])

}
