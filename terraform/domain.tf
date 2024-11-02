# Add a domain to DigitalOcean
resource "digitalocean_domain" "web_domain" {
  name = var.domain
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
