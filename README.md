# terraform-null-remote-excec-ansible

NOTE: No parameters are actually required, even if terraform registry states they are.

A minimum set of parameters SHOULD be set to make the module do anything useful:

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

Target node has to have ansible installed.

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

See the 'example' folder