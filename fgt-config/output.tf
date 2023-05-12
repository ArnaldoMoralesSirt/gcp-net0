output "fgt_config_1" {
  value = data.template_file.fgt_active.rendered
}

output "fgt_config_2" {
  value = data.template_file.fgt_passive.rendered
}

output "fgt_config_mgmt" {
  value = data.template_file.fgt_mgmt.rendered
}

output "fgt_config_proxy_1" {
  value = data.template_file.fgt_proxy_1.rendered
}

output "fgt_config_proxy_2" {
  value = data.template_file.fgt_proxy_2.rendered
}

output "api_key" {
  value = var.api_key == null ? random_string.api_key.result : var.api_key
}

output "fgsp_auto-config_secret" {
  value = random_string.fgsp_auto-config_secret.result
}


