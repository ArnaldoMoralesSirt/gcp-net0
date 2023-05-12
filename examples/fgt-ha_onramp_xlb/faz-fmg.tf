#------------------------------------------------------------------------------------------------------------
# Create FAZ instance
#------------------------------------------------------------------------------------------------------------
module "faz" {
  source = "../../faz"

  prefix  = local.prefix
  region  = local.region
  zone    = local.zone1
  machine = local.faz-fmg_machine

  rsa-public-key = trimspace(tls_private_key.ssh-rsa.public_key_openssh)
  gcp-user_name  = split("@", data.google_client_openid_userinfo.me.email)[0]

  subnet_names = {
    onpremise_mgmt  = module.fgt_vpc.subnet_names["onpremise_mgmt"]
    mgmt_tools = module.fgt_vpc.subnet_names["mgmt_tools"]
  }
  subnet_cidrs = {
    onpremise_mgmt  = module.fgt_vpc.subnet_cidrs["onpremise_mgmt"]
    mgmt_tools = module.fgt_vpc.subnet_cidrs["mgmt_tools"]
  }
  faz_ni_ips = module.fgt_vpc.faz_ni_ips

  license_file = local.faz_license_file
}

#------------------------------------------------------------------------------------------------------------
# Create FMG instance
#------------------------------------------------------------------------------------------------------------
module "fmg" {
  source = "../../fmg"

  prefix  = local.prefix
  region  = local.region
  zone    = local.zone1
  machine = local.faz-fmg_machine

  rsa-public-key = trimspace(tls_private_key.ssh-rsa.public_key_openssh)
  gcp-user_name  = split("@", data.google_client_openid_userinfo.me.email)[0]

  subnet_names = {
    onpremise_mgmt = module.fgt_vpc.subnet_names["onpremise_mgmt"]
    mgmt_tools = module.fgt_vpc.subnet_names["mgmt_tools"]
  }
  subnet_cidrs = {
    onpremise_mgmt  = module.fgt_vpc.subnet_cidrs["onpremise_mgmt"]
    mgmt_tools = module.fgt_vpc.subnet_cidrs["mgmt_tools"]
  }
  fmg_ni_ips = module.fgt_vpc.fmg_ni_ips

  license_file = local.fmg_license_file
}