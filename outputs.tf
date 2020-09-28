output "number_of_targets" {
  description = "Number of provisioning-targets"
  value       = length(var.target_addresses)
}

output "ids" {
  description = "Provisioner ids"
  value       = [
    for item in null_resource.main:
      item.id
  ]
}

# TODO: Not 100% sure the correlation will be 1-to-1 between ids and addresses..
output "ip_to_id" {
  description = "IP and related ID for the provisioner and targets"
  value       = zipmap(
    flatten([
      for item in null_resource.main:
      item.id
    ]),
    flatten([
      for item in var.target_addresses:
        item
    ])
  )
}