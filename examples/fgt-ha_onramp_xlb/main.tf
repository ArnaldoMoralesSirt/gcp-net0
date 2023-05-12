#------------------------------------------------------------------------------------------------------------
# Create VPCs and subnet Fortigate
# - VPC for MGMT and HA interface
# - VPC for Public interface
# - VPC for Private interface  
#------------------------------------------------------------------------------------------------------------
module "fgt_vpc" {
  source = "../../vpc-fgt"

  region = local.region
  prefix = local.prefix

  vpc-sec_cidr = local.onramp["cidr"]
}
#------------------------------------------------------------------------------------------------------------
# Create FGT cluster config
#------------------------------------------------------------------------------------------------------------
module "fgt_config" {
  source = "../../fgt-config"

  admin_cidr     = local.admin_cidr
  admin_port     = local.admin_port
  rsa-public-key = trimspace(tls_private_key.ssh-rsa.public_key_openssh)

  subnet_cidrs          = module.fgt_vpc.subnet_cidrs
  fgt-active-ni_ips     = module.fgt_vpc.fgt-active-ni_ips
  fgt-passive-ni_ips    = module.fgt_vpc.fgt-passive-ni_ips
  fgt-mgmt-ni_ips       = module.fgt_vpc.fgt-mgmt-ni_ips
  fgt-proxy-1-ni_ips    = module.fgt_vpc.fgt-proxy-1-ni_ips
  fgt-proxy-2-ni_ips    = module.fgt_vpc.fgt-proxy-2-ni_ips

  config_fgcp  = local.cluster_type == "fgcp" ? true : false
  config_fgsp  = local.cluster_type == "fgsp" ? true : false
  config_spoke = true
  config_xlb   = true
  spoke        = local.onramp
  ilb1_ip       = module.fgt_vpc.ilb1_ip

  vpc-spoke_cidr = concat(local.vpc_spoke-subnet_cidrs, [module.fgt_vpc.subnet_cidrs["bastion"]])
}
#------------------------------------------------------------------------------------------------------------
# Create FGT cluster instances
#------------------------------------------------------------------------------------------------------------
module "fgt" {
  source = "../../fgt-vm-instances"

  prefix = local.prefix
  region = local.region
  zone1  = local.zone1
  zone2  = local.zone2

  machine        = local.machine
  rsa-public-key = trimspace(tls_private_key.ssh-rsa.public_key_openssh)
  gcp-user_name  = split("@", data.google_client_openid_userinfo.me.email)[0]
  license_type   = local.license_type

  subnet_names          = module.fgt_vpc.subnet_names
  fgt-active-ni_ips     = module.fgt_vpc.fgt-active-ni_ips
  fgt-passive-ni_ips    = module.fgt_vpc.fgt-passive-ni_ips
  fgt-mgmt-ni_ips       = module.fgt_vpc.fgt-mgmt-ni_ips
  fgt-proxy-1-ni_ips    = module.fgt_vpc.fgt-proxy-1-ni_ips
  fgt-proxy-2-ni_ips    = module.fgt_vpc.fgt-proxy-2-ni_ips

  fgt_config_1 = module.fgt_config.fgt_config_1
  fgt_config_2 = module.fgt_config.fgt_config_2
  fgt_config_mgmt = module.fgt_config.fgt_config_mgmt
  fgt_config_proxy_1 = module.fgt_config.fgt_config_proxy_1
  fgt_config_proxy_2 = module.fgt_config.fgt_config_proxy_2

  config_fgsp = local.cluster_type == "fgsp" ? true : false

  fgt_passive = local.fgt_passive
}
#------------------------------------------------------------------------------------------------------------
# Create Internal and External Load Balancer
#------------------------------------------------------------------------------------------------------------
module "xlb" {
  source = "../../xlb"

  prefix = local.prefix
  region = local.region
  zone1  = local.zone1
  zone2  = local.zone2

  vpc_names             = module.fgt_vpc.vpc_names
  subnet_names          = module.fgt_vpc.subnet_names
  ilb1_ip               = module.fgt_vpc.ilb1_ip
  ilb2_ip               = module.fgt_vpc.ilb2_ip
  ilb3_ip               = module.fgt_vpc.ilb3_ip
  ilb4_ip               = module.fgt_vpc.ilb4_ip
  fgt_active_self_link  = module.fgt.fgt_active_self_link
  fgt_passive_self_link = module.fgt.fgt_passive_self_link[0]
}


#------------------------------------------------------------------------------------------------------------
# Necessary variables
#------------------------------------------------------------------------------------------------------------
// GET deploy public IP for management
data "http" "my-public-ip" {
  url = "http://ifconfig.me/ip"
}

data "google_client_openid_userinfo" "me" {}

resource "tls_private_key" "ssh-rsa" {
  algorithm = "RSA"
}

resource "local_file" "ssh_private_key_pem" {
  content         = tls_private_key.ssh-rsa.private_key_pem
  filename        = ".ssh/ssh-key.pem"
  file_permission = "0600"
}