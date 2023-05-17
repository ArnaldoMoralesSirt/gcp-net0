output "vpc_names" {
  value = {
    mgmt    = google_compute_network.vpc_mgmt.name
    public  = google_compute_network.vpc_public.name
    private1 = google_compute_network.vpc_private1.name
    private2 = google_compute_network.vpc_private2.name
    private3 = google_compute_network.vpc_private3.name
    private4 = google_compute_network.vpc_private4.name
    onpremise = google_compute_network.vpc_onpremise.name
  }
}

output "vpc_self_links" {
  value = {
    mgmt    = google_compute_network.vpc_mgmt.self_link
    public  = google_compute_network.vpc_public.self_link
    private1 = google_compute_network.vpc_private1.self_link
    private2 = google_compute_network.vpc_private2.self_link
    private3 = google_compute_network.vpc_private3.self_link
    private4 = google_compute_network.vpc_private4.self_link
    onpremise = google_compute_network.vpc_onpremise.self_link
  }
}

output "vpc_ids" {
  value = {
    mgmt    = google_compute_network.vpc_mgmt.id
    public  = google_compute_network.vpc_public.id
    private1 = google_compute_network.vpc_private1.id
    private2 = google_compute_network.vpc_private2.id
    private3 = google_compute_network.vpc_private3.id
    private4 = google_compute_network.vpc_private4.id
    onpremise = google_compute_network.vpc_onpremise.id
  }
}

output "subnet_names" {
  value = {
    mgmt    = google_compute_subnetwork.subnet_mgmt.name
    public  = google_compute_subnetwork.subnet_public.name
    private1 = google_compute_subnetwork.subnet_private1.name
    private2 = google_compute_subnetwork.subnet_private2.name
    private3 = google_compute_subnetwork.subnet_private3.name
    private4 = google_compute_subnetwork.subnet_private4.name
    bastion = google_compute_subnetwork.subnet_bastion.name
    onpremise = google_compute_subnetwork.subnet_onpremise.name
    onpremise_mgmt = google_compute_subnetwork.subnet_onpremise_mgmt.name
    mgmt_tools = google_compute_subnetwork.subnet_mgmt_tools.name
  }
}

output "subnet_self_links" {
  value = {
    mgmt    = google_compute_subnetwork.subnet_mgmt.self_link
    public  = google_compute_subnetwork.subnet_public.self_link
    private1 = google_compute_subnetwork.subnet_private1.self_link
    private2 = google_compute_subnetwork.subnet_private2.self_link
    private3 = google_compute_subnetwork.subnet_private3.self_link
    private4 = google_compute_subnetwork.subnet_private4.self_link
    bastion = google_compute_subnetwork.subnet_bastion.self_link
    onpremise = google_compute_subnetwork.subnet_onpremise.self_link
    onpremise_mgmt = google_compute_subnetwork.subnet_onpremise_mgmt.self_link
    mgmt_tools = google_compute_subnetwork.subnet_mgmt_tools.self_link
  }
}

output "subnet_ids" {
  value = {
    mgmt    = google_compute_subnetwork.subnet_mgmt.id
    public  = google_compute_subnetwork.subnet_public.id
    private1 = google_compute_subnetwork.subnet_private1.id
    private2 = google_compute_subnetwork.subnet_private2.id
    private3 = google_compute_subnetwork.subnet_private3.id
    private4 = google_compute_subnetwork.subnet_private4.id
    bastion = google_compute_subnetwork.subnet_bastion.id
    onpremise = google_compute_subnetwork.subnet_onpremise.id
    onpremise_mgmt = google_compute_subnetwork.subnet_onpremise_mgmt.id
    mgmt_tools = google_compute_subnetwork.subnet_mgmt_tools.id
  }
}

output "subnet_cidrs" {
  value = {
    public  = local.subnet_public_cidr
    private1 = local.subnet_private1_cidr
    private2 = local.subnet_private2_cidr
    private3 = local.subnet_private3_cidr
    private4 = local.subnet_private4_cidr
    bastion = local.subnet_bastion_cidr
    mgmt    = local.subnet_mgmt_cidr
    onpremise   = local.subnet_onpremise_cidr
    onpremise_mgmt = local.subnet_onpremise_mgmt_cidr
    mgmt_tools = local.subnet_mgmt_tools_cidr
  }
}

output "fgt-active-ni_ips" {
  value = {
    public  = local.fgt-1_ni_public_ip
    private1 = local.fgt-1_ni_private1_ip
    private2 = local.fgt-1_ni_private2_ip
    private3 = local.fgt-1_ni_private3_ip
    private4 = local.fgt-1_ni_private4_ip
    mgmt    = local.fgt-1_ni_mgmt_ip
    onpremise    = local.fgt-1_ni_onpremise_ip
  }
}

output "fgt-passive-ni_ips" {
  value = {
    public  = local.fgt-2_ni_public_ip
    private1 = local.fgt-2_ni_private1_ip
    private2 = local.fgt-2_ni_private2_ip
    private3 = local.fgt-2_ni_private3_ip
    private4 = local.fgt-2_ni_private4_ip
    mgmt    = local.fgt-2_ni_mgmt_ip
    onpremise    = local.fgt-2_ni_onpremise_ip
  }
}

output "fgt-mgmt-ni_ips" {
  value = {
    onpremise_mgmt  = local.fgt-mgmt_ni_onpremise_mgmt_ip
    mgmt_tools      = local.fgt-mgmt_ni_mgmt_tools_ip
  }
}

output "fgt-proxy-1-ni_ips" {
  value = {
    private1 = local.fgt-proxy-1_ni_private1_ip
    private2 = local.fgt-proxy-1_ni_private2_ip
    private3 = local.fgt-proxy-1_ni_private3_ip
    private4 = local.fgt-proxy-1_ni_private4_ip
    public    = local.fgt-proxy-1_ni_public_ip
    onpremise    = local.fgt-proxy-1_ni_onpremise_ip
  }
}

output "fgt-proxy-2-ni_ips" {
  value = {
    private1 = local.fgt-proxy-2_ni_private1_ip
    private2 = local.fgt-proxy-2_ni_private2_ip
    private3 = local.fgt-proxy-2_ni_private3_ip
    private4 = local.fgt-proxy-2_ni_private4_ip
    public    = local.fgt-proxy-2_ni_public_ip
    onpremise    = local.fgt-proxy-2_ni_onpremise_ip
  }
}

output "ilb1_ip" {
  value = local.ilb1_ip
}

output "ilb2_ip" {
  value = local.ilb2_ip
}

output "ilb3_ip" {
  value = local.ilb3_ip
}

output "ilb4_ip" {
  value = local.ilb4_ip
}

output "ncc_private_ips" {
  value = local.ncc_private_ips
}

output "ncc_public_ips" {
  value = local.ncc_public_ips
}

output "faz_ni_ips" {
  value = {
    onpremise_mgmt  = local.faz_ni_onpremise_mgmt_ip
    mgmt_tools = local.faz_ni_mgmt_tools_ip
  }
}

output "fmg_ni_ips" {
  value = {
    onpremise_mgmt  = local.fmg_ni_onpremise_mgmt_ip
    mgmt_tools = local.fmg_ni_mgmt_tools_ip
  }
}