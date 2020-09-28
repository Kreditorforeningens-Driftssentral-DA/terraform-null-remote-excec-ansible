# TERRAFORM NULL MODULE ([remote-excec-ansible](https://registry.terraform.io/modules/Kreditorforeningens-Driftssentral-DA/remote-excec-ansible/null))

![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/Kreditorforeningens-Driftssentral-DA/terraform-null-remote-excec-ansible)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/Kreditorforeningens-Driftssentral-DA/terraform-null-remote-excec-ansible)
![GitHub issues](https://img.shields.io/github/issues/Kreditorforeningens-Driftssentral-DA/terraform-null-remote-excec-ansible)

**NOTE: No parameters are actually required, even if terraform registry states they are.**

## DESCRIPTION

A module for running ansible provisioning (roles & playbook) on a list of targets
It is possible to customize connection parameters & ansible-settings/command(s)

#### Limitations

- The module will create a single requirements-file and a single playbook-file on the 
target host.
- There is nothing stopping you from overriding the 'ansible_command' variable with
anything you like. It's just a simple inline-command


## Using the module

A minimum set of parameters SHOULD be set to make the module do anything useful:

- target_adresses
- connection_username
- ssh_private_key (or other authentication method)
- ansible_requirements_b64
- ansible_playbook_b64

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

## EXAMPLES

```bash

# /example
# |--- terraform
# |    |--- main.tf
# |    |--- playbook.yml
# |    |--- requirements.yml
# |    |--- .secrets
# |    |    |--- id_rsa

module "vms" {
  source  = "www-aiqu-no/linux-vm/vsphere"
  version = "0.2.0"
  # -- 
  # ... module parameters
}

module "provisioning" {
  source  = "Kreditorforeningens-Driftssentral-DA/remote-excec-ansible/null"
  version = "0.1.3"
  # --
  target_adresses     = module.vms.ip
  connection_username = local.ansible.username
  ssh_private_key     = local.ansible.private_key
  # --
  ansible_playbook_b64     = local.ansible.playbook_b64
  ansible_requirements_b64 = local.ansible.requirements_b64
}

locals {
  ansible = {
    username         = "ansible"
    private_key      = file("${path.module}/.secrets/id_rsa")
    playbook_b64     = filebase64("${path.module}/playbook.yml")
    requirements_b64 = filebase64("${path.module}/requirements.yml")
  }
}


```

See the 'example' folder for working examples
