#When changing versions run:
# terraform init -upgrade 

#If first time run : terraform init 
#If you want to see the changes in the plan  run: terraform plan 
#If you want to apply the plan run: terraform apply 

# CloudLab provider configuration, specifying the path to the credentials file and API endpoint
terraform {
  required_providers {
    cloudlab = {
      source  = "pgrigo01/cloudlab" # this directory is under the .terraform directory
      version = "4.0.9" 
    }
  }
}

provider "cloudlab" {
  project          = "UCY-CS499-DC"
  credentials_path = "cloudlab-decrypted.pem"
  
}


# The following code creates a vlan and 4 VMs. The VMs are created on different aggregates.
# Then uncomment the following code and run terraform apply 

# resource "cloudlab_vlan" "my_vlan" {
#   name        = "vlan"
#   subnet_mask = "255.255.255.0"
# }


# resource "cloudlab_elastic_vm" "test" {
#   name               = "elastic1"
#   release            = "zed"
#   compute_node_count = 0
#   os_node_type       = ""   # default:"" is emulab. see node-type.txt for more or visit https://www.cloudlab.us/resinfo.php to see available node types 
#   os_link_speed      = 0
#   ml2plugin          = "openvswitch"
#   extra_image_urls   = ""
# }

# resource "cloudlab_elastic_vm" "elastic2" {
#   name               = "elastic2"
#   release            = "zed" #zed is for ubuntu 22.04 you can visit the profile to see available releases https://www.cloudlab.us/show-profile.php?uuid=afab050d-0c2c-11f0-af1a-e4434b2381fc
#   compute_node_count = 0
#   os_node_type       = "c220g1"   # default:"" is emulab. see node-type.txt for more or visit https://www.cloudlab.us/resinfo.php to see available node types 
#   os_link_speed      = 0
#   ml2plugin          = "openvswitch"
#   extra_image_urls   = ""
# }

# resource "cloudlab_elastic_vm" "elastic3" {
#   name               = "elastic3"
#   release            = "zed"
#   compute_node_count = 0
#   os_node_type       = ""   # default:"" is emulab. see node-type.txt for more or visit https://www.cloudlab.us/resinfo.php to see available node types 
#   os_link_speed      = 0
#   ml2plugin          = "openvswitch"
#   extra_image_urls   = ""
# }




# extra-disk-space is essentialy a Node-Local-Dataset
# A Node-Local-Dataset is stored on the local disk of the node and will be deleted when the node is terminated.(not persistent).This is
# useful if you know you need more storage for an experiment but you don't have to keep it later on.

#This resource creates a node on an experiment that has a node-local-dataset of 50GB 
# resource "cloudlab_vm" "exp1" {
#   name         = "exp1"
#   routable_ip  = true
#   image        = "UBUNTU 20.04"
#   aggregate    = "emulab.net"
#   extra_disk_space = 50 # added option to ask for a 50GB local file system mounted at /mydata --> see with df -h
#   node_count = 3 #nodes that are on the same experiment
# }

#These 3 nodes dont have a node-local-dataset but we demonstrate how we can get resources from different clusters
# resource "cloudlab_vm" "exp2" {
#   name         = "exp2"
#   routable_ip  = true
#   image        = "UBUNTU 20.04"
#   aggregate    = "utah.cloudlab.us"
#   node_count = 2
#   extra_disk_space = 30 
# }


# resource "cloudlab_vm" "exp3" {
#   name         = "exp3"
#   routable_ip  = true
#   image        = "UBUNTU 24.04"
#   aggregate    = "wisc.cloudlab.us"
# }

# resource "cloudlab_vm" "exp4" {
#   name         = "exp4"
#   routable_ip  = true
#   image        = "UBUNTU 24.04"
#   aggregate    = "clemson.cloudlab.us"
# }