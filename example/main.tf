# Local
#module "install_nomad" {
#  source = "../."
  # --
#  target_adresses     = local.targets
#  connection_username = local.ssh_username
#  connection_password = local.ssh_password
#  connection_port     = local.ssh_port
#}

# Versioned
module "install_nomad" {
  source  = "Kreditorforeningens-Driftssentral-DA/remote-excec-ansible/null"
  version = "0.1.0"
  # --
  target_adresses     = local.targets
  connection_username = local.ssh_username
  connection_password = local.ssh_password
  connection_port     = local.ssh_port
}