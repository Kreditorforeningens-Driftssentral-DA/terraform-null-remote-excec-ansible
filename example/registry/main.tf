module "install_nomad" {
  source  = "Kreditorforeningens-Driftssentral-DA/remote-excec-ansible/null"
  version = "0.1.1"
  # --
  target_adresses     = local.targets
  connection_username = local.ssh_username
  connection_password = local.ssh_password
  connection_port     = local.ssh_port
}