#------------------------------------------------------------------------------------------------------------
# FGT ACTIVE VM
#------------------------------------------------------------------------------------------------------------
# Create new random str
resource "random_string" "randon_str" {
  length  = 5
  special = false
  numeric = true
  upper   = false
}
# Create log disk for fmg
resource "google_compute_disk" "fmg-logdisk" {
  name = "${var.prefix}-fmg-log-disk-${random_string.randon_str.result}"
  size = 30
  type = "pd-standard"
  zone = var.zone
}

# Create static cluster ip
resource "google_compute_address" "fmg-public-ip" {
  name         = "${var.prefix}-fmg-public-ip"
  address_type = "EXTERNAL"
  region       = var.region
}

# Create FGTVM compute fmg instance
resource "google_compute_instance" "fmg" {
  name         = "nus-gcpg-cfwnet0-01-eswa"
  machine_type = var.machine
  zone         = var.zone

  tags = ["${var.prefix}-t-fwr-fgt-mgmt", "${var.prefix}-t-fwr-fgt-public", "${var.prefix}-t-fwr-bastion", "${var.subnet_names["mgmt_tools"]}-t-route", "${var.subnet_names["mgmt_tools"]}-t-fwr"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.fmg_image_byol.self_link
    }
  }
  attached_disk {
    source = google_compute_disk.fmg-logdisk.name
  }
  network_interface {
    subnetwork = var.subnet_names["onpremise_mgmt"]
    network_ip = var.fmg_ni_ips["onpremise_mgmt"]
    access_config {
      nat_ip = google_compute_address.fmg-public-ip.address
    }
  }
  network_interface {
    subnetwork = var.subnet_names["mgmt_tools"]
    network_ip = var.fmg_ni_ips["mgmt_tools"]
  }
  metadata = {
    ssh-keys  = trimspace("${var.gcp-user_name}:${var.rsa-public-key}")
    user-data = data.template_file.fmg_config.rendered
    license   = fileexists("${var.license_file}") ? "${file(var.license_file)}" : null
  }
  service_account {
    scopes = ["userinfo-email", "compute-rw", "storage-ro", "cloud-platform"]
  }
  scheduling {
    preemptible       = false
    automatic_restart = false
  }
}

#------------------------------------------------------------------------------------------------------------
# user-date template
#------------------------------------------------------------------------------------------------------------
data "template_file" "fmg_config" {
  template = file("${path.module}/templates/fmg.conf")
  vars = {
    fmg_id           = "nus-gcpg-cfwnet0-01-eswa"
    type             = var.license_type
    license_file     = var.license_file
    admin_username   = var.admin_username
    rsa-public-key   = trimspace(var.rsa-public-key)
    public_port      = var.public_port
    public_ip        = var.fmg_ni_ips["onpremise_mgmt"]
    public_mask      = cidrnetmask(var.subnet_cidrs["onpremise_mgmt"])
    public_gw        = cidrhost(var.subnet_cidrs["onpremise_mgmt"], 1)
    private_port     = var.private_port
    private_ip       = var.fmg_ni_ips["mgmt_tools"]
    private_mask     = cidrnetmask(var.subnet_cidrs["mgmt_tools"])
    private_gw       = cidrhost(var.subnet_cidrs["mgmt_tools"], 1)
    fmg_extra-config = var.fmg_extra-config
  }
}

#------------------------------------------------------------------------------------------------------------
# Images
#------------------------------------------------------------------------------------------------------------
data "google_compute_image" "fmg_image_byol" {
  project = "fortigcp-project-001"
  filter  = "name=fortinet-fmg-${var.fmg_version}*"
}