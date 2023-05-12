# GCP resourcers prefix description
variable "prefix" {
  type    = string
  default = "terraform"
}
# GCP region
variable "region" {
  type    = string
  default = "europe-southwest1" #Default Region
}
# GCP zone
variable "zone1" {
  type    = string
  default = "europe-southwest1-a" #Default Zone
}

# GCP zone
variable "zone2" {
  type    = string
  default = "europe-southwest1-b" #Default Zone
}

# GCP instance machine type
variable "machine" {
  type    = string
  default = "n2-standard-8"
}

# GCP instance machine mgmt type
variable "machinemgmt" {
  type    = string
  default = "n2-standard-4"
}

# GCP instance machine proxy type
variable "machineproxy" {
  type    = string
  default = "n2-standard-8"
}

# license file for active
variable "licenseFile" {
  type    = string
  default = "license1.lic"
}
# license file for passive
variable "licenseFile2" {
  type    = string
  default = "license2.lic"
}

// License Type to create FortiGate-VM
// Provide the license type for FortiGate-VM Instances, either byol or payg.
variable "license_type" {
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
  // Change to your own byol license file, licensemgmt.lic
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
variable "fgt_version" {
  type    = string
  default = "724"
}

variable "fgt_passive" {
  type    = bool
  default = false
}

variable "fgt_ha_fgsp" {
  type    = bool
  default = false
}

variable "fgt_config_1" {
  type    = string
  default = ""
}

variable "fgt_config_2" {
  type    = string
  default = ""
}

variable "fgt_config_mgmt" {
  type    = string
  default = ""
}

variable "fgt_config_proxy_1" {
  type    = string
  default = ""
}

variable "fgt_config_proxy_2" {
  type    = string
  default = ""
}

// SSH RSA public key for KeyPair if not exists
variable "rsa-public-key" {
  type    = string
  default = null
}

// GCP user name launch Terrafrom
variable "gcp-user_name" {
  type    = string
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

variable "subnet_names" {
  type    = map(string)
  default = null
}

variable "config_fgsp" {
  type    = bool
  default = false
}