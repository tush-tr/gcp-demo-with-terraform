

 # Create managementnet network
 resource "google_compute_network" "managementnet" {
   name                    = "managementnet"
   auto_create_subnetworks = false
 }
 # Create managementsubnet-us subnetwork
resource "google_compute_subnetwork" "managementsubnet-us" {
  name          = "managementsubnet-us"
  region        = "us-central1"
  network       = google_compute_network.managementnet.self_link
  ip_cidr_range = "10.130.0.0/20"
}
# Add a firewall rule to allow HTTP, SSH, RDP and ICMP traffic on managementnet
resource google_compute_firewall "managementnet-allow-http-ssh-rdp-icmp" {
name = allow-http-ssh-rdp-icmp
  source_ranges = [
    "0.0.0.0/0"
  ]
#RESOURCE properties go here
network = google_compute_network.managementnet.self_link
allow {
    protocol = "tcp"
    ports    = ["22", "80", "3389"]
  }
allow {
    protocol = "icmp"
  }
}