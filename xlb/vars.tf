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

variable "fgt_active_self_link" {
  type    = string
  default = null
}

variable "fgt_passive_self_link" {
  type    = string
  default = null
}

variable "backend-probe_port" {
  type    = string
  default = "8008"
}

variable "ilb1_ip" {
  type    = string
  default = null
}

variable "ilb2_ip" {
  type    = string
  default = null
}

variable "ilb3_ip" {
  type    = string
  default = null
}

variable "ilb4_ip" {
  type    = string
  default = null
}

variable "subnet_names" {
  type    = map(string)
  default = null
}

variable "vpc_names" {
  type    = map(string)
  default = null
}

variable "elb_frontend_pip_id" {
  type    = string
  default = null
}
