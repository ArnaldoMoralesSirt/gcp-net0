locals {
  # ----------------------------------------------------------------------------------
  # Subnet cidrs (UPDATE IF NEEDED)
  # ----------------------------------------------------------------------------------
  subnet_public_cidr             = cidrsubnet(var.vpc-sec_cidr, 4, 0)
  subnet_proxy_cidr              = cidrsubnet(var.vpc-sec_cidr, 4, 1)
  subnet_onpremise_cidr          = cidrsubnet(var.vpc-sec_cidr, 4, 2)
  subnet_bastion_cidr            = cidrsubnet(var.vpc-sec_cidr, 4, 3)
  subnet_mgmt_cidr               = cidrsubnet(var.vpc-sec_cidr, 4, 4)
  subnet_private1_cidr           = cidrsubnet(var.vpc-sec_cidr, 4, 5)
  subnet_private2_cidr           = cidrsubnet(var.vpc-sec_cidr, 4, 6)
  subnet_private3_cidr           = cidrsubnet(var.vpc-sec_cidr, 4, 7)
  subnet_private4_cidr           = cidrsubnet(var.vpc-sec_cidr, 4, 8)
  subnet_onpremise_mgmt_cidr     = cidrsubnet(var.vpc-sec_cidr, 4, 9)
  subnet_mgmt_tools_cidr         = cidrsubnet(var.vpc-sec_cidr, 4, 10)
  # ----------------------------------------------------------------------------------
  # FGT IP (UPDATE IF NEEDED)
  # ----------------------------------------------------------------------------------
  fgt-1_ni_mgmt_ip     = cidrhost(local.subnet_mgmt_cidr, 10)
  fgt-1_ni_public_ip   = cidrhost(local.subnet_public_cidr, 10)
  fgt-1_ni_private1_ip  = cidrhost(local.subnet_private1_cidr, 10)
  fgt-1_ni_private2_ip  = cidrhost(local.subnet_private2_cidr, 10)
  fgt-1_ni_private3_ip  = cidrhost(local.subnet_private3_cidr, 10)
  fgt-1_ni_private4_ip  = cidrhost(local.subnet_private4_cidr, 10)
  fgt-1_ni_onpremise_ip  = cidrhost(local.subnet_onpremise_cidr, 10)

  fgt-2_ni_mgmt_ip    = cidrhost(local.subnet_mgmt_cidr, 11)
  fgt-2_ni_public_ip  = cidrhost(local.subnet_public_cidr, 11)
  fgt-2_ni_private1_ip = cidrhost(local.subnet_private1_cidr, 11)
  fgt-2_ni_private2_ip = cidrhost(local.subnet_private2_cidr, 11)
  fgt-2_ni_private3_ip = cidrhost(local.subnet_private3_cidr, 11)
  fgt-2_ni_private4_ip = cidrhost(local.subnet_private4_cidr, 11)
  fgt-2_ni_onpremise_ip = cidrhost(local.subnet_onpremise_cidr, 11)


  # ----------------------------------------------------------------------------------
  # FGT MGMT
  # ----------------------------------------------------------------------------------
  fgt-mgmt_ni_onpremise_mgmt_ip = cidrhost(local.subnet_onpremise_mgmt_cidr, 10)
  fgt-mgmt_ni_mgmt_tools_ip = cidrhost(local.subnet_mgmt_tools_cidr, 10)


  # ----------------------------------------------------------------------------------
  # FGT Proxy 1 - 2
  # ----------------------------------------------------------------------------------
  fgt-proxy-1_ni_mgmt_ip     = cidrhost(local.subnet_mgmt_cidr, 12)
  fgt-proxy-1_ni_private1_ip  = cidrhost(local.subnet_private1_cidr, 12)
  fgt-proxy-1_ni_private2_ip  = cidrhost(local.subnet_private2_cidr, 12)
  fgt-proxy-1_ni_private3_ip  = cidrhost(local.subnet_private3_cidr, 12)
  fgt-proxy-1_ni_private4_ip  = cidrhost(local.subnet_private4_cidr, 12)
  fgt-proxy-1_ni_onpremise_ip  = cidrhost(local.subnet_onpremise_cidr, 12)

  fgt-proxy-2_ni_mgmt_ip     = cidrhost(local.subnet_mgmt_cidr, 13)
  fgt-proxy-2_ni_private1_ip  = cidrhost(local.subnet_private1_cidr, 13)
  fgt-proxy-2_ni_private2_ip  = cidrhost(local.subnet_private2_cidr, 13)
  fgt-proxy-2_ni_private3_ip  = cidrhost(local.subnet_private3_cidr, 13)
  fgt-proxy-2_ni_private4_ip  = cidrhost(local.subnet_private4_cidr, 13)
  fgt-proxy-2_ni_onpremise_ip  = cidrhost(local.subnet_onpremise_cidr, 13)

  # ----------------------------------------------------------------------------------
  # FAZ and FMG
  # ----------------------------------------------------------------------------------
  faz_ni_onpremise_mgmt_ip  = cidrhost(local.subnet_onpremise_mgmt_cidr, 12)
  faz_ni_mgmt_tools_ip = cidrhost(local.subnet_mgmt_tools_cidr, 12)
  fmg_ni_onpremise_mgmt_ip  = cidrhost(local.subnet_onpremise_mgmt_cidr, 13)
  fmg_ni_mgmt_tools_ip = cidrhost(local.subnet_mgmt_tools_cidr, 13)
  # ----------------------------------------------------------------------------------
  # iLB
  # ----------------------------------------------------------------------------------
  ilb1_ip = cidrhost(local.subnet_private1_cidr, 9)
  ilb2_ip = cidrhost(local.subnet_private2_cidr, 9)
  ilb3_ip = cidrhost(local.subnet_private3_cidr, 9)
  ilb4_ip = cidrhost(local.subnet_private4_cidr, 9)
  # ----------------------------------------------------------------------------------
  # NCC
  # ----------------------------------------------------------------------------------
  ncc_private_ips = [
    cidrhost(local.subnet_private1_cidr, 5),
    cidrhost(local.subnet_private1_cidr, 6)
  ]
  ncc_public_ips = [
    cidrhost(local.subnet_public_cidr, 5),
    cidrhost(local.subnet_public_cidr, 6)
  ]
  # ----------------------------------------------------------------------------------
  # Bastion VM
  # ----------------------------------------------------------------------------------
  bastion_ni_ip = cidrhost(local.subnet_bastion_cidr, 10)
}