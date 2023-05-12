##############################################################################################################
# FGT Proxy 2 VM
##############################################################################################################

# Data template fgt_1
data "template_file" "fgt_proxy_2" {
  template = file("${path.module}/templates/fgt-proxy-2.conf")

  vars = {
    fgt_id         = "fgt-proxy2"
    admin_port     = var.admin_port
    admin_cidr     = var.admin_cidr
    adminusername  = "admin"
    type           = var.license_type
    license_file   = var.license_file_proxy2
    rsa-public-key = trimspace(var.rsa-public-key)
    api_key        = var.api_key == null ? random_string.api_key.result : var.api_key

    private1_port = var.private1_port
    private1_ip   = var.fgt-proxy-2-ni_ips["private1"]
    private1_mask = "255.255.255.255"
    private1_gw   = cidrhost(var.subnet_cidrs["private1"], 1)
    private1_cidr = var.subnet_cidrs["private1"]
    mgmt_port    = var.mgmt_port
    mgmt_ip      = var.fgt-proxy-2-ni_ips["mgmt"]
    mgmt_mask    = "255.255.255.255"
    mgmt_gw      = cidrhost(var.subnet_cidrs["mgmt"], 1)
    mgmt_cidr    = var.subnet_cidrs["mgmt"]
    onpremise_port = var.onpremise_port
    onpremise_ip   = var.fgt-proxy-2-ni_ips["onpremise"]
    onpremise_mask = "255.255.255.255"

  }
}
