locals {

  connection = {
    # { this line is included due to visual bug in editor, and serves no purpose }
    type        = var.connection_type
    username    = var.connection_username
    password    = var.connection_password
    port        = var.connection_port
    timeout     = var.connection_timeout
  }

  ssh = {
    # { this line is included due to visual bug in editor, and serves no purpose }
    private_key    = var.ssh_private_key
    certificate    = var.ssh_certificate
    agent          = var.ssh_agent
    agent_identity = var.ssh_agent_identity
    host_key       = var.ssh_host_key
  }

  winrm = {
    # { this line is included due to visual bug in editor, and serves no purpose }
    https    = var.winrm_https
    insecure = var.winrm_insecure
    use_ntlm = var.winrm_use_ntlm
    cacert   = var.winrm_cacert
  }

  ansible = {
    # { this line is included due to visual bug in editor, and serves no purpose }
    settings     = var.ansible_settings_b64     != null ? var.ansible_settings_b64     : filebase64("${path.module}/templates/ansible.cfg")
    hosts        = var.ansible_hosts_b64        != null ? var.ansible_hosts_b64        : filebase64("${path.module}/templates/all.yml")
    requirements = var.ansible_requirements_b64 != null ? var.ansible_requirements_b64 : filebase64("${path.module}/templates/requirements.yml")
    playbook     = var.ansible_playbook_b64     != null ? var.ansible_playbook_b64     : filebase64("${path.module}/templates/playbook.yml")
    commands     = var.ansible_commands
  }
}

# ===============================================
# OPTIONAL
# ===============================================

variable "target_adresses" {
  type        = list(string)
  description = "(Optional) List of addresses to provision."
  default     = []
}

# ===============================================
# Connection override settings
# ===============================================

variable "connection_type"     { default = null }
variable "connection_username" { default = null }
variable "connection_password" { default = null }
variable "connection_port"     { default = null }
variable "connection_timeout"  { default = null }
variable "ssh_private_key"     { default = null }
variable "ssh_certificate"     { default = null }
variable "ssh_agent"           { default = null }
variable "ssh_agent_identity"  { default = null }
variable "ssh_host_key"        { default = null }
variable "winrm_https"         { default = null }
variable "winrm_insecure"      { default = null }
variable "winrm_use_ntlm"      { default = null }
variable "winrm_cacert"        { default = null }

# ===============================================
# Ansible settings
# ===============================================

variable "ansible_settings_b64" {
  type        = string
  description = "(Optional) Ansible settings-file. Provide as a base64encoded string"
  default     = null
}

variable "ansible_hosts_b64"{
  type        = string
  description = "(Optional) Ansible hosts-file. Provide as a base64encoded string"
  default     = null
}

variable "ansible_requirements_b64" {
  type        = string
  description = "(Optional) Requirements-file processed by ansible-galaxy before running playbook. Provide as a base64encoded string"
  default     = null
}

variable "ansible_playbook_b64" {
  type        = string
  description = "(Optional) Playbook executed by ansible. Provide as a base64encoded string"
  default     = null
}

variable "ansible_commands" {
  type        = list(string)
  description = "(Optional) List of commands to execute at end of provisioning."
  default     = [
    "cd /tmp/ansible",
    "ansible-galaxy install -r roles/requirements.yml",
    "ansible-playbook playbook.yml",
  ]
}
