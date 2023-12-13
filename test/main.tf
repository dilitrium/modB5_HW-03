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
  family = "lemp"
}

resource "yandex_compute_instance" "vm-1" {
  name = "terraform1"

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
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/home/litium/.ssh/id_ed25519.pub")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}

output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}