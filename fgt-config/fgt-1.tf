##############################################################################################################
# FGT ACTIVE VM
##############################################################################################################

# Data template fgt_1
data "template_file" "fgt_active" {
  template = file("${path.module}/templates/fgt-all.conf")

  vars = {
    fgt_id         = var.config_spoke ? "${var.spoke["id"]}-1" : "${var.hub["id"]}-1"
    admin_port     = var.admin_port
    admin_cidr     = var.admin_cidr
    adminusername  = "admin"
    type           = var.license_type
    license_file   = var.license_file_1
    rsa-public-key = trimspace(var.rsa-public-key)
    api_key        = var.api_key == null ? random_string.api_key.result : var.api_key

    public_port  = var.public_port
    public_ip    = var.fgt-active-ni_ips["public"]
    public_mask  = "255.255.255.255"
    public_gw    = cidrhost(var.subnet_cidrs["public"], 1)
    public_cidr  = var.subnet_cidrs["public"]
    private1_port = var.private1_port
    private1_ip   = var.fgt-active-ni_ips["private1"]
    private1_mask = "255.255.255.255"
    private1_gw   = cidrhost(var.subnet_cidrs["private1"], 1)
    private1_cidr = var.subnet_cidrs["private1"]
    mgmt_port    = var.mgmt_port
    mgmt_ip      = var.fgt-active-ni_ips["mgmt"]
    mgmt_mask    = "255.255.255.255"
    mgmt_gw      = cidrhost(var.subnet_cidrs["mgmt"], 1)
    mgmt_cidr    = var.subnet_cidrs["mgmt"]
    onpremise_port = var.onpremise_port
    onpremise_ip   = var.fgt-active-ni_ips["onpremise"]
    onpremise_mask = "255.255.255.255"

    fgt_ha-fgcp-config     = var.config_fgcp ? data.template_file.fgt_ha-fgcp-active-config.rendered : ""
    fgt_ha-fgsp-config     = var.config_fgsp ? data.template_file.fgt_ha-fgsp-active-config.rendered : ""
    fgt_fmg-config         = var.config_fmg ? data.template_file.fgt_1_fmg-config.rendered : ""
    fgt_faz-config         = var.config_faz ? data.template_file.fgt_1_faz-config.rendered : ""
    fgt_xlb-config         = var.config_xlb ? data.template_file.fgt_xlb-config.rendered : ""
    fgt_extra-config       = var.fgt_active_extra-config
  }
}

data "template_file" "fgt_ha-fgcp-active-config" {
  template = file("${path.module}/templates/gcp_fgt-ha-fgcp.conf")
  vars = {
    fgt_priority = 200
    ha_port      = var.mgmt_port
    ha_gw        = cidrhost(var.subnet_cidrs["mgmt"], 1)
    ha_mask      = cidrnetmask(var.subnet_cidrs["mgmt"])
    peerip       = var.fgt-passive-ni_ips["mgmt"]
  }
}

data "template_file" "fgt_ha-fgsp-active-config" {
  template = file("${path.module}/templates/fgt-ha-fgsp.conf")
  vars = {
    mgmt_port     = var.mgmt_port
    mgmt_gw       = cidrhost(var.subnet_cidrs["mgmt"], 1)
    peerip        = var.fgt-passive-ni_ips["mgmt"]
    master_secret = random_string.fgsp_auto-config_secret.result
    master_ip     = ""
  }
}

data "template_file" "fgt_active_static-config" {
  template = templatefile("${path.module}/templates/fgt-static.conf", {
    vpc-spoke_cidr = var.vpc-spoke_cidr
    port           = var.private1_port
    gw             = cidrhost(var.subnet_cidrs["private1"], 1)
  })
}

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

data "template_file" "fgt_xlb-config" {
  template = templatefile("${path.module}/templates/gcp_fgt-xlb.conf", {
    private1_port = var.private1_port
    ilb1_ip       = var.ilb1_ip
  })
}



#------------------------------------------------------------------------------------
# Generate random strings
#------------------------------------------------------------------------------------
# Create new random API key to be provisioned in FortiGates.

# Create new random FGSP secret
resource "random_string" "fgsp_auto-config_secret" {
  length  = 10
  special = false
  numeric = true
}

# Create new random FGSP secret
resource "random_string" "api_key" {
  length  = 30
  special = false
  numeric = true
}