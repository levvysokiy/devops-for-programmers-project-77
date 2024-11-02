resource "local_file" "ansible-inventory" {
  content = templatefile("templates/inventory.tfpl", {
    web1 = digitalocean_droplet.web1.ipv4_address
    web2 = digitalocean_droplet.web2.ipv4_address
  })
  filename = "../ansible/inventory.ini"
}

resource "local_file" "ansible-vars" {
  content = templatefile("templates/ansible-vars.tfpl", {
    redmine_db_addr         = digitalocean_database_cluster.postgres.host
    redmine_secret_key_base = var.redmine_secret_key_base
    redmine_db_username     = var.db_user
    redmine_db_password     = var.db_password
    redmine_db_database     = var.db_name
    redmine_db_port         = digitalocean_database_cluster.postgres.port
    datadog_api_key         = var.datadog_api_key
    datadog_app_key         = var.datadog_app_key
  })
  filename = "../ansible/group_vars/webservers/vars.yml"
}
