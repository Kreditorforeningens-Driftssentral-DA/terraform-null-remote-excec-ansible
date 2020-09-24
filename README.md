# terraform-null-remote-excec-ansible

Note that no parameters are required, even if terrafor registry states them as required
A minimum of parameters SHOULD be:

```bash
- target_adresses
- connection_username
- ssh_private_key (or other authentication method)
- ansible_requirements_b64
- ansible_playbook_b64
```

## DESCRIPTION

Module for running ansible provisioning on a list of targets
It is possible to customize connection parameters

Target node(s) has to have ansible installed.

You can pass the following files to the ansible provisioner (as a base64-encoded string) for now:

```bash
# /tmp/ansible/ansible.cfg            -> ansible settings
# /tmp/ansible/hosts/all.yml          -> hosts file
# /tmp/ansible/roles/requirements.yml -> galaxy roles to download/install
# /tmp/ansible/playbook.yml           -> playbook to execute
```

Default executed commands:

```bash
# Change to ansible root folder
cd /tmp/ansible

# Install roles
ansible-galaxy install -r roles/requirements.yml

# Run playbook
ansible-playbook playbook.yml
```

## Examples

```bash
module "install_something" {
  source  = "Kreditorforeningens-Driftssentral-DA/remote-excec-ansible/null"
  version = "0.1.0"
  # --
  target_adresses     = ["10.0.200.10","10.0.200.11","10.0.200.12"]
  connection_username = "provisioner"
  connection_password = "YouShouldUseKeyInstead"
  connection_port     = 22
}
```
See the 'example' folder for working example