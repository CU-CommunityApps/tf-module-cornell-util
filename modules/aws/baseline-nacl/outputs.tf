output "network_acl_id" {
  value = aws_network_acl.baseline.id
}

output "network_acl_tags" {
  value = {
    for k, nacl in toset([aws_network_acl.baseline]) : nacl.arn => nacl.tags
  }
}