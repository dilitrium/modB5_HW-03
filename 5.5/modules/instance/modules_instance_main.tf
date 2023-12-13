terraform {
  # Используемая версия Terraform в проекте
  required_version = "1.5.5"
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.100.0"
    }
  }
   backend "s3" {
    endpoint  = "storage.yandexcloud.net"
    bucket = "sf-bucket-beridium"
    region = "ru-central1-a"
    key    = "sfstate/lemp.tfstate"
    access_key = "YCAJESToi_GSxIAkktKGo8ODI"
    secret_key = "YCOtG0_NJ0Tgehwnzjc5RIjnk4eLPRT6_8Fx_Gol"

    skip_region_validation      = true
    skip_credentials_validation = true
 #   skip_requesting_account_id  = true
 #   skip_metadata_api_check     = true
  } 
}
provider "yandex" {
  token = "y0_AgAAAAByMlwJAATuwQAAAADzoD1RXmKxHLWaStSQsYKFNndskOeCh_M"
 # service_account_key_file = file("~/authorized_key.json")
  cloud_id  = "b1g7htbt15eptelpg2hg"
  folder_id = "b1gsn7asivb4355ot1ju"
  zone      = "ru-central1-a"
}

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