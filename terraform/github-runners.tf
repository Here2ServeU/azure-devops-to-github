provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "runner_rg" {
  name     = "github-runner-rg"
  location = "East US"
}

resource "azurerm_virtual_network" "runner_vnet" {
  name                = "github-runner-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.runner_rg.location
  resource_group_name = azurerm_resource_group.runner_rg.name
}

resource "azurerm_subnet" "runner_subnet" {
  name                 = "github-runner-subnet"
  resource_group_name  = azurerm_resource_group.runner_rg.name
  virtual_network_name = azurerm_virtual_network.runner_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "runner_nic" {
  name                = "github-runner-nic"
  location            = azurerm_resource_group.runner_rg.location
  resource_group_name = azurerm_resource_group.runner_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.runner_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "runner_vm" {
  name                  = "github-runner-vm"
  location              = azurerm_resource_group.runner_rg.location
  resource_group_name   = azurerm_resource_group.runner_rg.name
  size                  = "Standard_B2s"
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.runner_nic.id]

  admin_password = "ChangeMe123!"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  provision_vm_agent = true

  custom_data = filebase64("${path.module}/cloud-init-runner.sh")
}
