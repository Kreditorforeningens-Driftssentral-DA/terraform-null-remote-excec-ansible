module "example" {
  source = "../../."
  # --
  target_addresses     = local.targets
  connection_username = local.ssh_username
  connection_password = local.ssh_password
  connection_port     = local.ssh_port
}
