terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    datadog = {
      source  = "datadog/datadog"
      version = "~> 3.0" # specify the version or use latest compatible version
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
  api_url = "https://api.us5.datadoghq.com/"
}

# Create a new Droplet (VM)
resource "digitalocean_droplet" "web1" {
  name   = "${var.droplet_name}-1"
  region = var.region
  size   = var.size
  image  = var.image
  tags   = var.tags

  # Optional: Configure SSH key
  ssh_keys = [var.ssh_fingerprint]
}

resource "digitalocean_droplet" "web2" {
  name   = "${var.droplet_name}-2"
  region = var.region
  size   = var.size
  image  = var.image
  tags   = var.tags

  # Optional: Configure SSH key
  ssh_keys = [var.ssh_fingerprint]
}

resource "digitalocean_loadbalancer" "web_lb" {
  name   = "example-lb"
  region = var.region
  forwarding_rule {
    entry_port      = 80
    entry_protocol  = "http"
    target_port     = 80
    target_protocol = "http"
  }

  forwarding_rule {
    entry_port       = 443
    entry_protocol   = "https"
    target_port      = 80
    target_protocol  = "http"
    certificate_name = digitalocean_certificate.cert.name
    tls_passthrough  = false
  }

  healthcheck {
    protocol = "http"
    port     = 80
    path     = "/"
  }

  droplet_ids = [digitalocean_droplet.web1.id, digitalocean_droplet.web2.id]
  depends_on  = [digitalocean_droplet.web1, digitalocean_droplet.web2]
}

# Add a domain to DigitalOcean
resource "digitalocean_domain" "web_domain" {
  name = "vysokiylev.xyz"
}

resource "digitalocean_record" "www" {
  domain = digitalocean_domain.web_domain.name
  type   = "A"
  name   = "www"
  value  = digitalocean_loadbalancer.web_lb.ip
}

resource "digitalocean_record" "root" {
  domain = digitalocean_domain.web_domain.name
  type   = "A"
  name   = "@"
  value  = digitalocean_loadbalancer.web_lb.ip
}

resource "digitalocean_certificate" "cert" {
  type    = "lets_encrypt"
  name    = "web-cert"
  domains = [digitalocean_domain.web_domain.name]

  depends_on = [digitalocean_domain.web_domain]
}

# PostgreSQL database cluster
resource "digitalocean_database_cluster" "postgres" {
  name       = "my-postgres-cluster"
  engine     = "pg"
  version    = "13"             # Specify the PostgreSQL version you need
  region     = var.region       # Choose the desired region
  size       = "db-s-1vcpu-1gb" # Select the node size
  node_count = 1                # Number of nodes in the cluster
}

# Create the initial database
resource "digitalocean_database_db" "mydatabase" {
  cluster_id = digitalocean_database_cluster.postgres.id
  name       = var.db_name
}

# Create a user for the database
resource "digitalocean_database_user" "db_user" {
  cluster_id = digitalocean_database_cluster.postgres.id
  name       = var.db_user
}

resource "datadog_monitor" "healthcheck" {
  name    = "Healthcheck monitor"
  type    = "service check"
  query   = "\"http.can_connect\".over(\"instance:datadog_health_check\").by(\"host\",\"instance\",\"url\").last(4).count_by_status()"
  message = "{{host.name}} not available"
}
