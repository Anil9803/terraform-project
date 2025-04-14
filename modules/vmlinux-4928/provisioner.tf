resource "null_resource" "display_hostnames" {
  for_each = azurerm_linux_virtual_machine.linux_vm
  depends_on = [azurerm_linux_virtual_machine.linux_vm]

  connection {
    type        = "ssh"
    host        = azurerm_public_ip.linux_public_ip[each.key].fqdn
    user        = "azureuser"
    private_key = file("~/.ssh/id_rsa")
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Provisioning done for:' $(hostname)"
    ]
  }
}

