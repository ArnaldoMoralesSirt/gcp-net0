##############################################################################################################
# FGT Proxy 1 VM
##############################################################################################################

# Data template fgt_1
data "template_file" "fgt_proxy_1" {
  template = file("${path.module}/templates/fgt-proxy-1.conf")

  vars = {
    fgt_id         = "nus-gcp-prxnet0-01-eswa"
    admin_port     = var.admin_port
    admin_cidr     = var.admin_cidr
    adminusername  = "admin"
    type           = var.license_type
    license_file   = var.license_file_proxy1
    rsa-public-key = trimspace(var.rsa-public-key)
    api_key        = var.api_key == null ? random_string.api_key.result : var.api_key

    public_port    = var.public_port
    public_ip      = var.fgt-proxy-1-ni_ips["public"]
    public_mask    = "255.255.255.255"
    public_gw      = cidrhost(var.subnet_cidrs["public"], 1)
    public_cidr    = var.subnet_cidrs["public"]
    onpremise_port = var.onpremise_port
    onpremise_ip   = var.fgt-proxy-1-ni_ips["onpremise"]
    onpremise_mask = "255.255.255.255"
    private1_port = var.private1_port
    private1_ip   = var.fgt-proxy-1-ni_ips["private1"]
    private1_mask = "255.255.255.255"
    private1_gw   = cidrhost(var.subnet_cidrs["private1"], 1)
    private1_cidr = var.subnet_cidrs["private1"]
    private2_port = var.private2_port
    private2_ip   = var.fgt-proxy-1-ni_ips["private2"]
    private2_mask = "255.255.255.255"
    private2_gw   = cidrhost(var.subnet_cidrs["private2"], 1)
    private2_cidr = var.subnet_cidrs["private2"]
    private3_port = var.private3_port
    private3_ip   = var.fgt-proxy-1-ni_ips["private3"]
    private3_mask = "255.255.255.255"
    private3_gw   = cidrhost(var.subnet_cidrs["private3"], 1)
    private3_cidr = var.subnet_cidrs["private3"]
    private4_port = var.private4_port
    private4_ip   = var.fgt-proxy-1-ni_ips["private4"]
    private4_mask = "255.255.255.255"
    private4_gw   = cidrhost(var.subnet_cidrs["private4"], 1)
    private4_cidr = var.subnet_cidrs["private4"]

  }
}
