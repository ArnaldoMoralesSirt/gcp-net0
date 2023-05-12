#-----------------------------------------------------------------------------------
# Predefined variables for HA
# - config_fgcp   = true (default)
# - confgi_fgsp   = false (default)
#-----------------------------------------------------------------------------------
variable "config_fgcp" {
  type    = bool
  default = false
}
variable "config_fgsp" {
  type    = bool
  default = false
}

#-----------------------------------------------------------------------------------
# Route to change by SDN connector when FGCP and no LB
#-----------------------------------------------------------------------------------
variable "route_tables" {
  type = list(string)
  default = null
}
variable "cluster_pips" {
  type = list(string)
  default = null
}

#-----------------------------------------------------------------------------------
# Predefined variables for FMG 
# - config_fmg = false (default) 
#-----------------------------------------------------------------------------------
variable "config_fmg" {
  type    = bool
  default = false
}

variable "fmg_ip" {
  type    = string
  default = ""
}

variable "fmg_sn" {
  type    = string
  default = ""
}

variable "fmg_interface-select-method" {
  type    = string
  default = ""
}

variable "fmg_fgt-1_source-ip" {
  type    = string
  default = ""
}

variable "fmg_fgt-2_source-ip" {
  type    = string
  default = ""
}

#-----------------------------------------------------------------------------------
# Predefined variables for xLB 
# - config_xlb = false (default) 
#-----------------------------------------------------------------------------------
variable "config_xlb" {
  type    = bool
  default = false
}

variable "ilb1_ip" {
  type = string 
  default = "172.30.0.137"
}

#-----------------------------------------------------------------------------------
# Predefined variables for FAZ 
# - config_faz = false (default) 
#-----------------------------------------------------------------------------------
variable "config_faz" {
  type    = bool
  default = false
}

variable "faz_ip" {
  type    = string
  default = ""
}

variable "faz_sn" {
  type    = string
  default = ""
}

variable "faz_interface-select-method" {
  type    = string
  default = ""
}

variable "faz_fgt-1_source-ip" {
  type    = string
  default = ""
}

variable "faz_fgt-2_source-ip" {
  type    = string
  default = ""
}


#-----------------------------------------------------------------------------------
variable "admin_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "admin_port" {
  type    = string
  default = "8443"
}

variable "api_key" {
  type    = string
  default = null
}

variable "fgt_passive" {
  type    = bool
  default = false
}

variable "fgt_passive_extra-config" {
  type    = string
  default = ""
}

variable "fgt_active_extra-config" {
  type    = string
  default = ""
}

variable "vpc-spoke_cidr" {
  type    = list(string)
  default = null
}

variable "fgt-active-ni_ips" {
  type    = map(string)
  default = null
}

variable "fgt-passive-ni_ips" {
  type    = map(string)
  default = null
}

variable "fgt-mgmt-ni_ips" {
  type    = map(string)
  default = null
}

variable "fgt-proxy-1-ni_ips" {
  type    = map(string)
  default = null
}

variable "fgt-proxy-2-ni_ips" {
  type    = map(string)
  default = null
}

variable "subnet_cidrs" {
  type    = map(string)
  default = null
}

variable "public_port" {
  type    = string
  default = "port1"
}

variable "onpremise_port" {
  type    = string
  default = "port2"
}

variable "mgmt_port" {
  type    = string
  default = "port3"
}

variable "private1_port" {
  type    = string
  default = "port4"
}

// License Type to create FortiGate-VM
// Provide the license type for FortiGate-VM Instances, either byol or payg.
variable "license_type" {
  type    = string
  default = "payg"
}

// license file for the active fgt
variable "license_file_1" {
  // Change to your own byol license file, license.lic
  type    = string
  default = "./licenses/license1.lic"
}

// license file for the passive fgt
variable "license_file_2" {
  // Change to your own byol license file, license2.lic
  type    = string
  default = "./licenses/license2.lic"
}

// license file for the mgmt fgt
variable "license_file_mgmt" {
  // Change to your own byol license file, license2.lic
  type    = string
  default = "./licenses/licensemgmt.lic"
}

// license file for the proxy 1 fgt
variable "license_file_proxy1" {
  // Change to your own byol license file, licensemgmt.lic
  type    = string
  default = "./licenses/licenseproxy1.lic"
}

// license file for the proxy 2 fgt
variable "license_file_proxy2" {
  // Change to your own byol license file, licensemgmt.lic
  type    = string
  default = "./licenses/licenseproxy2.lic"
}

variable "keypair" {
  description = "Provide a keypair for accessing the FortiGate instances"
  type      = string
  default   = null
}

// SSH RSA public key for KeyPair if not exists
variable "rsa-public-key" {
  type    = string
  default = null
}

variable "backend-probe_port" {
  type    = string
  default = "8008"
}