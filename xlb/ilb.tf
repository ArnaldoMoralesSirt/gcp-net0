# Create health checks
resource "google_compute_region_health_check" "ilb_health-check_fgt" {
  name               = "${var.prefix}-ilb-fgt-health-check"
  region             = var.region
  check_interval_sec = 2
  timeout_sec        = 2

  tcp_health_check {
    port = var.backend-probe_port
  }
}

# Create FGT active instance group
resource "google_compute_instance_group" "lb_group_fgt-1" {
  name      = "${var.prefix}-lb-group-fgt-1"
  zone      = var.zone1
  instances = [var.fgt_active_self_link]
}
# Create FGT passive instance group
resource "google_compute_instance_group" "lb_group_fgt-2" {
  name      = "${var.prefix}-lb-group-fgt-2"
  zone      = var.zone2
  instances = [var.fgt_passive_self_link]
}

#------------------------------------------------------------------------------------------------------------
# Create iLB Private1
#------------------------------------------------------------------------------------------------------------
# Create Internal Load Balancer
resource "google_compute_region_backend_service" "ilb1" {
  provider = google-beta
  name     = "${var.prefix}-ilb1"
  region   = var.region
  network  = var.vpc_names["private1"]

  backend {
    group = google_compute_instance_group.lb_group_fgt-1.id
  }
  backend {
    group = google_compute_instance_group.lb_group_fgt-2.id
  }

  health_checks = [google_compute_region_health_check.ilb_health-check_fgt.id]
  connection_tracking_policy {
    connection_persistence_on_unhealthy_backends = "NEVER_PERSIST"
  }
}
# Create forwarding rule to ILB in private VPC
resource "google_compute_forwarding_rule" "ilb1_fwd-rule_all" {
  name   = "${var.prefix}-ilb-fwd-rule-ilb1"
  region = var.region

  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.ilb1.id
  all_ports             = true
  network               = var.vpc_names["private1"]
  subnetwork            = var.subnet_names["private1"]
  allow_global_access   = true
  ip_address            = var.ilb1_ip
}

#------------------------------------------------------------------------------------------------------------
# Create default route to iLB in VPC private1
#------------------------------------------------------------------------------------------------------------
resource "google_compute_route" "private_route_ilb1_1" {
  name         = "${var.prefix}-private-route-ilb1-1"
  dest_range   = "0.0.0.0/0"
  network      = var.vpc_names["private1"]
  next_hop_ilb = var.ilb1_ip
  priority     = 100
}




#------------------------------------------------------------------------------------------------------------
# Create iLB Private2
#------------------------------------------------------------------------------------------------------------
# Create Internal Load Balancer
resource "google_compute_region_backend_service" "ilb2" {
  provider = google-beta
  name     = "${var.prefix}-ilb2"
  region   = var.region
  network  = var.vpc_names["private2"]

  backend {
    group = google_compute_instance_group.lb_group_fgt-1.id
  }
  backend {
    group = google_compute_instance_group.lb_group_fgt-2.id
  }

  health_checks = [google_compute_region_health_check.ilb_health-check_fgt.id]
  connection_tracking_policy {
    connection_persistence_on_unhealthy_backends = "NEVER_PERSIST"
  }
}
# Create forwarding rule to ILB in private VPC
resource "google_compute_forwarding_rule" "ilb2_fwd-rule_all" {
  name   = "${var.prefix}-ilb-fwd-rule-ilb2"
  region = var.region

  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.ilb2.id
  all_ports             = true
  network               = var.vpc_names["private2"]
  subnetwork            = var.subnet_names["private2"]
  allow_global_access   = true
  ip_address            = var.ilb2_ip
}

#------------------------------------------------------------------------------------------------------------
# Create default route to iLB in VPC private2
#------------------------------------------------------------------------------------------------------------
resource "google_compute_route" "private_route_ilb2_1" {
  name         = "${var.prefix}-private-route-ilb2-1"
  dest_range   = "0.0.0.0/0"
  network      = var.vpc_names["private2"]
  next_hop_ilb = var.ilb2_ip
  priority     = 100
}




#------------------------------------------------------------------------------------------------------------
# Create iLB Private3
#------------------------------------------------------------------------------------------------------------
# Create Internal Load Balancer
resource "google_compute_region_backend_service" "ilb3" {
  provider = google-beta
  name     = "${var.prefix}-ilb3"
  region   = var.region
  network  = var.vpc_names["private3"]

  backend {
    group = google_compute_instance_group.lb_group_fgt-1.id
  }
  backend {
    group = google_compute_instance_group.lb_group_fgt-2.id
  }

  health_checks = [google_compute_region_health_check.ilb_health-check_fgt.id]
  connection_tracking_policy {
    connection_persistence_on_unhealthy_backends = "NEVER_PERSIST"
  }
}
# Create forwarding rule to ILB in private VPC
resource "google_compute_forwarding_rule" "ilb3_fwd-rule_all" {
  name   = "${var.prefix}-ilb-fwd-rule-ilb3"
  region = var.region

  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.ilb3.id
  all_ports             = true
  network               = var.vpc_names["private3"]
  subnetwork            = var.subnet_names["private3"]
  allow_global_access   = true
  ip_address            = var.ilb3_ip
}

#------------------------------------------------------------------------------------------------------------
# Create default route to iLB in VPC private3
#------------------------------------------------------------------------------------------------------------
resource "google_compute_route" "private_route_ilb3_1" {
  name         = "${var.prefix}-private-route-ilb3-1"
  dest_range   = "0.0.0.0/0"
  network      = var.vpc_names["private3"]
  next_hop_ilb = var.ilb3_ip
  priority     = 100
}






#------------------------------------------------------------------------------------------------------------
# Create iLB Private4
#------------------------------------------------------------------------------------------------------------
# Create Internal Load Balancer
resource "google_compute_region_backend_service" "ilb4" {
  provider = google-beta
  name     = "${var.prefix}-ilb4"
  region   = var.region
  network  = var.vpc_names["private4"]

  backend {
    group = google_compute_instance_group.lb_group_fgt-1.id
  }
  backend {
    group = google_compute_instance_group.lb_group_fgt-2.id
  }

  health_checks = [google_compute_region_health_check.ilb_health-check_fgt.id]
  connection_tracking_policy {
    connection_persistence_on_unhealthy_backends = "NEVER_PERSIST"
  }
}
# Create forwarding rule to ILB in private VPC
resource "google_compute_forwarding_rule" "ilb4_fwd-rule_all" {
  name   = "${var.prefix}-ilb-fwd-rule-ilb4"
  region = var.region

  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.ilb4.id
  all_ports             = true
  network               = var.vpc_names["private4"]
  subnetwork            = var.subnet_names["private4"]
  allow_global_access   = true
  ip_address            = var.ilb4_ip
}

#------------------------------------------------------------------------------------------------------------
# Create default route to iLB in VPC private4
#------------------------------------------------------------------------------------------------------------
resource "google_compute_route" "private_route_ilb4_1" {
  name         = "${var.prefix}-private-route-ilb4-1"
  dest_range   = "0.0.0.0/0"
  network      = var.vpc_names["private4"]
  next_hop_ilb = var.ilb4_ip
  priority     = 100
}