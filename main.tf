locals {
  common_labels = {
    owner   = "maksym"
    variant = "12"
    project = "lab3"
  }
}


resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}


resource "google_compute_subnetwork" "subnet_a" {
  name          = "${var.vpc_name}-subnet-a"
  ip_cidr_range = var.subnet_a_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
}

# 3. Налаштування Firewall (Security Groups)
resource "google_compute_firewall" "allow_ssh_web" {
  name    = "allow-ssh-and-web-12"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", var.web_port]
  }

  source_ranges = ["0.0.0.0/0"]
}

# 4. Динамічний пошук образу Ubuntu 24.04
data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2404-lts-amd64"
  project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "web_server" {
  name         = "vm-lab3-var12"
  machine_type = "e2-micro"
  zone         = "${var.region}-c"
  labels       = local.common_labels

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet_a.id
    access_config {
      # Публічна IP-адреса
    }
  }

  # Передача скрипта ініціалізації
  metadata_startup_script = templatefile("bootstrap.sh", {
    web_port    = var.web_port
    server_name = var.server_name
    doc_root    = var.doc_root
  })
}