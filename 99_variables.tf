variable "pubkeyfile" {
  description = "Public sshkey for ssh access"
}

variable "privkeyfile" {
  description = "Private sshkey for ssh access (Only for 'ansibleinventory' output)"
  default = null
}
