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