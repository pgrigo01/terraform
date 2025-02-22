terraform {
  required_providers {
    cloudlab = {
      source  = "pgrigo01/cloudlab"
      version = "2.5.5" 
    }
  }
}

#version = "2.4.2" //for locallhost 

# CloudLab provider configuration, specifying the path to the credentials file and API endpoint
provider "cloudlab" {
  project          = "UCY-CS499-DC"
  credentials_path = "cloudlab-decrypted.pem"
}

resource "cloudlab_vlan" "my_cloudlab_vlan" {
  name        = "vlan-test"
  subnet_mask = "255.255.255.0"
}

#currently running vms

# resource "cloudlab_vm" "my_vm2" {
#   name         = "exp7"
#   routable_ip  = true
#   image        = "UBUNTU 20.04"
#   aggregate    = "Any"
# }

# resource "cloudlab_vm" "my_vm3" {
#   name         = "vmtest8"
#   routable_ip  = true
#   image        = "UBUNTU 20.04"
#   aggregate    = "Any"
# }


# resource "cloudlab_vm" "my_vm4" {
#   name         = "vmtest9"
#   routable_ip  = true
#   image        = "UBUNTU 20.04"
#   aggregate    = "Any"
# }

