# Генерируем шаблон
data "template_file" "ansible_inventory" {
  template = file("${path.module}/inventory.ini.tpl") # Путь до шаблона на локальном компьютере
  vars = {
    webserver_1  = "foo.example.com"
    webserver_2  = "bar.example.com"
    dbserver_1 = "one.example.com"
    dbserver_2 = "two.example.com"
    dbserver_3 = "three.example.com"
    ansible_ssh_private_key_file = "~/.ssh/git.pem"
    ansible_ssh_user = "ubuntu"
  }
}

# Записываем сгенерированный шаблон в файл
resource "null_resource" "update_inventory" {
  triggers = { # Код будет выполнен, когда inventory будет сгенерирован
    template = data.template_file.ansible_inventory.rendered
  }
  provisioner "local-exec" { # выполняем команду на локальной машине
    command = "echo '${data.template_file.ansible_inventory.rendered}' > inventory.ini"
  }
}