output "number_of_targets" {
  description = "Number of provisioning-targets"
  value       = length(var.target_adresses)
}

output "ids" {
  description = "Provisioner ids"
  value       = null_resource.main[*].id
}
output "ip_to_id" {
  description = "Ip and related id for the provisioner and targets"
  value       = zipmap(
    flatten(list(null_resource.main[*].id)),
    flatten(list(var.target_adresses[*], )),
  )
}