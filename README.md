# terraform-null-remote-excec-ansible

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

## Examples

See the 'example' folder