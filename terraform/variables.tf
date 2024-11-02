variable "do_token" {
  sensitive = true
}

variable "ssh_fingerprint" {
  description = "SSH key fingerprint"
  type        = string
  sensitive   = true
}

variable "droplet_name" {}
variable "region" {}
variable "droplet_size" {}
variable "droplet_image" {}
variable "droplet_tags" {}


variable "db_node_count" {}
variable "db_size" {}
variable "db_name" {
  type        = string
  default     = "defaultdb"
  description = "The name of the PostgreSQL database"
}
variable "db_user" {
  type        = string
  default     = "doadmin"
  description = "The username for the PostgreSQL database"
}
variable "db_password" {
  type        = string
  description = "The password for the PostgreSQL database"
  sensitive   = true
}

variable "datadog_api_key" {
  sensitive = true
}

variable "datadog_app_key" {
  sensitive = true
}

variable "domain" {}
variable "http_port" {}
variable "https_port" {}
variable "redmine_secret_key_base" {}


