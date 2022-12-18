terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 4.46.0"
    }
  }
}

provider "google" {
  credentials = file("giservin_key.json")

  project = "celestial-brand-369406"
  region  = "us-west1"
  zone    = "us-west1-b"
}

resource "google_compute_instance" "kube_worker" {
  count = 1

  name = "kube-worker-0${count.index + 1}"
  machine_type = "e2-small"
  zone = "us-west1-b"
  
  boot_disk {
    initialize_params {
      image = "ubuntu-2204-jammy-v20221206"
      size = 24
      type = "pd-standard"
    }
  }

  network_interface {
    network = "default"
    network_ip = var.private_ip[count.index]

    access_config {

    }
  }

  metadata = {
    ssh-keys = "giservin2000:${file("ssh_key.pub")}"
  }

  metadata_startup_script = file("script.sh")

}

resource "google_compute_instance" "kube_control" {
  count = 1

  name = "kube-control-0${count.index + 1}"
  machine_type = "e2-small"
  zone = "us-west1-b"
  
  boot_disk {
    initialize_params {
      image = "ubuntu-2204-jammy-v20221206"
      size = 24
      type = "pd-standard"
    }
  }

  network_interface {
    network = "default"
    network_ip = var.private_ip[count.index+1]

    access_config {

    }
  }

  metadata = {
    ssh-keys = "giservin2000:${file("ssh_key.pub")}"
  }

  metadata_startup_script = file("script.sh")

  lifecycle {
    prevent_destroy = true
  }

}

