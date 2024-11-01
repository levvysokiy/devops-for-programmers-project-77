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
