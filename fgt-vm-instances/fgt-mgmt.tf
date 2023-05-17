#------------------------------------------------------------------------------------------------------------
# FGT MGMT VM
#------------------------------------------------------------------------------------------------------------

# Create log disk for mgmt
resource "google_compute_disk" "fgtmgmt-logdisk" {
  name = "${var.prefix}-fgt-mgmt-log-disk-${random_string.randon_str.result}"
  size = 30
  type = "pd-standard"
  zone = var.zone1
}

# Create static mgmt instance management ip
resource "google_compute_address" "fgtmgmt-mgmt-public-ip" {
  name         = "${var.prefix}-fgtmgmt-mgmt-public-ip"
  address_type = "EXTERNAL"
  region       = var.region
}

# Create FGTVM compute active instance
resource "google_compute_instance" "fgt-mgmt" {
  name           = "nus-gcpg-fwnet0-01-eswa"
  machine_type   = var.machinemgmt
  zone           = var.zone1
  can_ip_forward = "true"

  tags = ["${var.prefix}-t-fwr-fgtmgmt-mgmt", "${var.prefix}-t-fwr-fgtmgmt-public", "${var.prefix}-t-fwr-fgtmgmt-private"]

  boot_disk {
    initialize_params {
      image = var.license_type == "byol" ? data.google_compute_image.fgt_image_byol.self_link : data.google_compute_image.fgt_image_payg.self_link
    }
  }
  attached_disk {
    source = google_compute_disk.fgtmgmt-logdisk.name
  }
  network_interface {
    subnetwork = var.subnet_names["onpremise_mgmt"]
    network_ip = var.fgt-mgmt-ni_ips["onpremise_mgmt"]
  }
  network_interface {
    subnetwork = var.subnet_names["mgmt_tools"]
    network_ip = var.fgt-mgmt-ni_ips["mgmt_tools"]
  }
  metadata = {
    ssh-keys  = trimspace("${var.gcp-user_name}:${var.rsa-public-key}")
    user-data = var.fgt_config_mgmt
    license   = fileexists("${var.license_file_mgmt}") ? "${file(var.license_file_mgmt)}" : null
  }
  service_account {
    scopes = ["userinfo-email", "compute-rw", "storage-ro", "cloud-platform"]
  }
  scheduling {
    preemptible       = false
    automatic_restart = false
  }
}