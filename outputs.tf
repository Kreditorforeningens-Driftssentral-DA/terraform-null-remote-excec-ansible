output "number_of_targets" {
  value = length(var.target_adresses)
}

output "ids" {
  value = null_resource.main[*].id
}
output "ip_to_id" {
  value = zipmap(
    flatten(list(null_resource.main[*].id)),
    flatten(list(var.target_adresses[*], )),
  )
}