provider "scaleway" {
  access_key      = "<SCALEWAY-ACCESS-KEY>"
  secret_key      = "<SCALEWAY-SECRET-KEY>"
  organization_id = "<SCALEWAY-ORGANIZATION-ID>"
  zone            = "fr-par-1"
  region          = "fr-par"
}

resource "scaleway_instance_ip" "public_ip" {}

resource "scaleway_instance_volume" "data" {
  size_in_gb = var.disk_size
  type = "l_ssd"
}

resource "scaleway_instance_security_group" "${var.cluster_name}-security-group" {
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action = "accept"
    port   = "22"
  }

  inbound_rule {
    action = "accept"
    port   = "80"
  }

  inbound_rule {
    action = "accept"
    port   = "443"
  }
}

resource "scaleway_instance_server" "${var.cluster_name}-instance" {
  type  = var.instance_type
  image = var.image_name

  tags = [ "front", "web" ]

  ip_id = scaleway_instance_ip.public_ip.id

  additional_volume_ids = [ scaleway_instance_volume.data.id ]
  security_group_id = scaleway_instance_security_group.my-security-group.id
}