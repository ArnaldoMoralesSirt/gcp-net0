##############################################################################################################
# FGT ACTIVE VM
##############################################################################################################

# Data template fgt_1
data "template_file" "fgt_mgmt" {
  template = file("${path.module}/templates/fgt-mgmt.conf")

  vars = {
    fgt_id         = var.config_spoke ? "${var.spoke["id"]}-mgmt" : "${var.hub["id"]}-mgmt"
    admin_port     = var.admin_port
    admin_cidr     = var.admin_cidr
    adminusername  = "admin"
    type           = var.license_type
    license_file   = var.license_file_mgmt
    rsa-public-key = trimspace(var.rsa-public-key)
    api_key        = var.api_key == null ? random_string.api_key.result : var.api_key

    onpremise_mgmt_port  = "port1"
    onpremise_mgmt_ip    = var.fgt-mgmt-ni_ips["onpremise_mgmt"]
    onpremise_mgmt_mask  = "255.255.255.255"
    onpremise_mgmt_gw    = cidrhost(var.subnet_cidrs["onpremise_mgmt"], 1)
    onpremise_mgmt_cidr  = var.subnet_cidrs["onpremise_mgmt"]
    mgmt_tools_port = "port2"
    mgmt_tools_ip   = var.fgt-mgmt-ni_ips["mgmt_tools"]
    mgmt_tools_mask = "255.255.255.255"
    mgmt_tools_gw   = cidrhost(var.subnet_cidrs["mgmt_tools"], 1)
    mgmt_tools_cidr = var.subnet_cidrs["mgmt_tools"]

  }
}

/*
data "template_file" "fgt_1_faz-config" {
  template = file("${path.module}/templates/fgt-faz.conf")
  vars = {
    ip                      = var.faz_ip
    sn                      = var.faz_sn
    source-ip               = var.faz_fgt-1_source-ip
    interface-select-method = var.faz_interface-select-method
  }
}

data "template_file" "fgt_1_fmg-config" {
  template = file("${path.module}/templates/fgt-fmg.conf")
  vars = {
    ip                      = var.fmg_ip
    sn                      = var.fmg_sn
    source-ip               = var.fmg_fgt-1_source-ip
    interface-select-method = var.fmg_interface-select-method
  }
}
*/