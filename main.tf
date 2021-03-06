resource "null_resource" "main" {
  #count = length(var.target_addresses)
  for_each = toset(var.target_addresses)

  # Re-run in case any addresses change
  triggers = {
    id = join(";", var.target_addresses)
  }

  connection {
    #host     = element(var.target_addresses,count.index)
    host     = each.key
    port     = local.connection.port
    type     = local.connection.type
    user     = local.connection.username
    password = local.connection.password
    timeout  = local.connection.timeout
    # -- ssh
    private_key    = local.ssh.private_key
    certificate    = local.ssh.certificate
    agent          = local.ssh.agent
    agent_identity = local.ssh.agent_identity
    host_key       = local.ssh.host_key
    # -- winrm
    https    = local.winrm.https
    insecure = local.winrm.insecure
    use_ntlm = local.winrm.use_ntlm
    cacert   = local.winrm.cacert
  }

  # Create ansible folders on remote host
  provisioner "remote-exec" {
    inline = [
      "mkdir -p /tmp/ansible/roles",
      "mkdir -p /tmp/ansible/hosts",
    ]
  }

  # Create ansible settings file
  provisioner "file" {
    destination = "/tmp/ansible/ansible.cfg"
    content     = base64decode(local.ansible.settings)
  }

  # Create ansible inventory file
  provisioner "file" {
    destination = "/tmp/ansible/hosts/all.yml"
    content     = base64decode(local.ansible.hosts)
  }

  # Create ansible requirements file (roles)
  provisioner "file" {
    destination = "/tmp/ansible/roles/requirements.yml"
    content     = base64decode(local.ansible.requirements)
  }

  # Create ansible playbook file
  provisioner "file" {
    destination = "/tmp/ansible/playbook.yml"
    content     = base64decode(local.ansible.playbook)
  }

  # Execute ansible commands
  provisioner "remote-exec" {
    inline = local.ansible.commands
  }
}
