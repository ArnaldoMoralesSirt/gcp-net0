#------------------------------------------------------------------------------------------------------------
# FGT Proxy 2 VM
#------------------------------------------------------------------------------------------------------------

# Create log disk for proxy1
resource "google_compute_disk" "fgtproxy2-logdisk" {
  name = "${var.prefix}-fgt-proxy-2-log-disk-${random_string.randon_str.result}"
  size = 30
  type = "pd-standard"
  zone = var.zone1
}

# Create static proxy2 instance management ip
resource "google_compute_address" "fgtproxy2-mgmt-public-ip" {
  name         = "${var.prefix}-fgtproxy2-mgmt-public-ip"
  address_type = "EXTERNAL"
  region       = var.region
}

# Create FGTVM compute proxy2 instance
resource "google_compute_instance" "fgt-proxy-2" {
  name           = "nus-gcp-prxnet0-01-eswb"
  machine_type   = var.machineproxy
  zone           = var.zone1
  can_ip_forward = "true"

  tags = ["${var.prefix}-t-fwr-fgtproxy2-mgmt", "${var.prefix}-t-fwr-fgtproxy2-public", "${var.prefix}-t-fwr-fgtproxy2-private", "${var.prefix}-t-fwr-fgt-public"]

  boot_disk {
    initialize_params {
      image = var.license_type == "byol" ? data.google_compute_image.fgt_image_byol.self_link : data.google_compute_image.fgt_image_payg.self_link
    }
  }
  attached_disk {
    source = google_compute_disk.fgtproxy2-logdisk.name
  }
  network_interface {
    subnetwork = var.subnet_names["public"]
    network_ip = var.fgt-proxy-2-ni_ips["public"]
    access_config {
      nat_ip = google_compute_address.fgtproxy2-mgmt-public-ip.address
    }
  }
  network_interface {
    subnetwork = var.subnet_names["onpremise"]
    network_ip = var.fgt-proxy-2-ni_ips["onpremise"]
  }
  network_interface {
    subnetwork = var.subnet_names["private1"]
    network_ip = var.fgt-proxy-2-ni_ips["private1"]
  }
  network_interface {
    subnetwork = var.subnet_names["private2"]
    network_ip = var.fgt-proxy-2-ni_ips["private2"]
  }
  network_interface {
    subnetwork = var.subnet_names["private3"]
    network_ip = var.fgt-proxy-2-ni_ips["private3"]
  }
  network_interface {
    subnetwork = var.subnet_names["private4"]
    network_ip = var.fgt-proxy-2-ni_ips["private4"]
  }
  metadata = {
    ssh-keys  = trimspace("${var.gcp-user_name}:${var.rsa-public-key}")
    user-data = var.fgt_config_proxy_2
    license   = fileexists("${var.license_file_proxy2}") ? "${file(var.license_file_proxy2)}" : null
  }
  service_account {
    scopes = ["userinfo-email", "compute-rw", "storage-ro", "cloud-platform"]
  }
  scheduling {
    preemptible       = false
    automatic_restart = false
  }
}