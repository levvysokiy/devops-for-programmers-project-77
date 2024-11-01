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
