output "frontend_public_ip" {
  value = aws_instance.frontend.public_ip
}
output "backend_private_ip" {
  value = aws_instance.backend.private_ip
}

locals {
  privkeyfile = var.privkeyfile == null ? replace(var.pubkeyfile, ".pub", "") : var.privkeyfile
}

output "ansibleinventory" {
  sensitive = true
  value = {
    all = {
      children = {
        backends = {
          hosts = {
            backend = {
              ansible_host                 = aws_instance.backend.private_ip
              ansible_connection           = "ssh"
              ansible_user                 = "ec2-user"
              ansible_ssh_private_key_file = local.privkeyfile
              ansible_ssh_common_args      = "-o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -W %h:%p -i ${local.privkeyfile} -q ec2-user@${aws_instance.frontend.public_ip}\""
              ansible_python_interpreter   = "/usr/bin/python"
            }
          }
        }
        frontends = {
          hosts = {
            frontend = {
              ansible_host                 = aws_instance.frontend.public_ip
              ansible_connection           = "ssh"
              ansible_user                 = "ec2-user"
              ansible_ssh_private_key_file = local.privkeyfile
              ansible_python_interpreter   = "/usr/bin/python"
            }
          }
        }
      }
    }
  }
}
