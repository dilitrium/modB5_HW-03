terraform {
  # Используемая версия Terraform в проекте
  required_version = "1.5.5"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.100.0"
    }
  }
}
#provider "yandex" {
#  token = "y0_AgAAAAByMlwJAATuwQAAAADzoD1RXmKxHLWaStSQsYKFNndskOeCh_M"
# service_account_key_file = file("~/authorized_key.json")
#  cloud_id  = "b1g7htbt15eptelpg2hg"
#  folder_id = "b1gsn7asivb4355ot1ju"
#  zone      = "ru-central1-a"
#}

data "yandex_compute_image" "my_image" {
  family = var.instance_family_image
}

resource "yandex_compute_instance" "vm" {
  name = "terraform-${var.instance_family_image}"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}