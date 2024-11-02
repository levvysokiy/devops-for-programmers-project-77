resource "digitalocean_loadbalancer" "web_lb" {
  name   = "example-lb"
  region = var.region

  forwarding_rule {
    entry_port      = var.http_port
    entry_protocol  = "http"
    target_port     = var.http_port
    target_protocol = "http"
  }

  forwarding_rule {
    entry_port       = var.https_port
    entry_protocol   = "https"
    target_port      = var.http_port
    target_protocol  = "http"
    certificate_name = digitalocean_certificate.cert.name
    tls_passthrough  = false
  }

  healthcheck {
    protocol = "http"
    port     = var.http_port
    path     = "/"
  }

  droplet_ids = [digitalocean_droplet.web1.id, digitalocean_droplet.web2.id]
  depends_on  = [digitalocean_droplet.web1, digitalocean_droplet.web2]
}
