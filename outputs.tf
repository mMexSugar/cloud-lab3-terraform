output "vm_external_ip" {
  value = google_compute_instance.web_server.network_interface[0].access_config[0].nat_ip
}

output "vm_name" {
  value = google_compute_instance.web_server.name
}

output "image_used" {
  value = data.google_compute_image.ubuntu.name
}

output "website_url" {
  value = "http://${google_compute_instance.web_server.network_interface[0].access_config[0].nat_ip}:${var.web_port}"
}