variable "do_token" {
  description = "value of the DigitalOcean API token"
  sensitive   = true
  type        = string
}

variable "ssh_fingerprint" {
  description = "SSH key fingerprint"
  type        = string
  sensitive   = true
}

variable "droplet_name" {
  type        = string
  description = "The name of the Droplet"
}

variable "region" {
  type        = string
  description = "The region where the Droplet will be created"
}

variable "droplet_size" {
  type        = string
  description = "The size of the Droplet"
}

variable "droplet_image" {
  type        = string
  description = "The image used to create the Droplet"
}

variable "droplet_tags" {
  type        = list(string)
  description = "The tags assigned to the Droplet"
}

variable "db_node_count" {
  type        = number
  description = "The number of nodes in the PostgreSQL cluster"
}

variable "db_size" {
  type        = string
  description = "The size of the PostgreSQL nodes"
}

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
  description = "value of the Datadog API key"
  sensitive   = true
  type        = string
}

variable "datadog_app_key" {
  description = "value of the Datadog application key"
  sensitive   = true
  type        = string
}

variable "domain" {
  type        = string
  description = "The domain name for the application"
}

variable "http_port" {
  type        = number
  description = "The port for HTTP traffic"
}

variable "https_port" {
  type        = number
  description = "The port for HTTPS traffic"
}

variable "redmine_secret_key_base" {
  type        = string
  description = "The secret key base for Redmine"
  sensitive   = true
}


