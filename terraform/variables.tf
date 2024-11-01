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
variable "size" {}
variable "image" {}
variable "tags" {}

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
}
