resource "azurerm_public_ip" "lb_public_ip" {
  name                = "lb4928-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Basic"
  domain_name_label   = "lb4928domain"  // Ensure this label is unique in your region
  tags                = var.tags
}

resource "azurerm_lb" "lb" {
  name                = "lb4928"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"

  frontend_ip_configuration {
    name                 = "lb4928-frontend"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }

  tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name            = "lb4928-lb-backend"
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_lb_probe" "lb_probe" {
  name                = "lb4928-probe"
  loadbalancer_id     = azurerm_lb.lb.id
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "lb_rule" {
  name                           = "lb4928-rule"
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool.id]
  probe_id                       = azurerm_lb_probe.lb_probe.id
}

