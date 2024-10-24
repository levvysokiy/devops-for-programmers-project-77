terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
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
