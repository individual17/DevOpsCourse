provider "google" {
  credentials = file("service_account.json")
  project     = "myterra-274109"
  region      = "europe-west2"
  zone        = "europe-west2-a"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"
  /*  user_data    = file("prometheus_and_graffana.sh")
*/
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }
}
