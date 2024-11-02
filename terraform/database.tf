resource "digitalocean_database_cluster" "postgres" {
  name       = "my-postgres-cluster"
  engine     = "pg"
  version    = "13"
  region     = var.region
  size       = var.db_size
  node_count = var.db_node_count
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
