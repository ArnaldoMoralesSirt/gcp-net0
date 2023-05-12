locals {
  #-----------------------------------------------------------------------------------------------------
  # General variables
  #-----------------------------------------------------------------------------------------------------
  region = "europe-southwest1"
  zone1  = "europe-southwest1-a"
  zone2  = "europe-southwest1-b"
  prefix = "fgt-xlb-net0"
  
  #-----------------------------------------------------------------------------------------------------
  # FGT
  #-----------------------------------------------------------------------------------------------------
  license_type = "payg"
  machine      = "n2-standard-8"

  admin_port = "8443"
  admin_cidr = "${chomp(data.http.my-public-ip.response_body)}/32"

  onramp = {
    id      = "fgt"
    cidr    = "172.30.0.0/22" //minimum range to create proxy subnet
    bgp-asn = "65000"
  }

  cluster_type = "fgcp"
  fgt_passive  = true

  #-----------------------------------------------------------------------------------------------------
  # FAZ and FMG variables
  #-----------------------------------------------------------------------------------------------------
  faz-fmg_machine  = "n2-standard-4"
  faz_license_file = "./licenses/licenseFAZ.lic"
  fmg_license_file = "./licenses/licenseFMG.lic"
}