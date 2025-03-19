#When changing versions run:
# terraform init -upgrade 

#If first time run : terraform init 
#If you want to see the changes in the plan  run: terraform plan 
#If you want to apply the plan run: terraform apply 

#version = "2.3.0" //for locallhost 
#version = "3.0.0" //works with duckdns when running the server not working on ucy wifi otan allazo vms 
# If a new vm is added and the server is running on the ucy wifi then change the HostURL to the new vm's ip address 
# and build the provider with ./buildprovider.sh 

# CloudLab provider configuration, specifying the path to the credentials file and API endpoint
terraform {
  required_providers {
    cloudlab = {
      source  = "pgrigo01/cloudlab" # this directory is under the .terraform directory
      version = "4.0.6" 
    }
  }
}

provider "cloudlab" {
  project          = "UCY-CS499-DC"
  credentials_path = "cloudlab-decrypted.pem"
  workspace        = terraform.workspace //passes the current workspace to the provider
}

# terraform init
# terraform workspace new workspace1
# terraform workspace select workspace1 
# terraform workspace list //to see the workspaces

#IF ON WORKSPACE 2 (if you have a second one) Do this to differentiate the resources accross workspaces
# terraform init
# terraform workspace new workspace2
# terraform workspace select workspace2

#extra-disk-space  essentialy is a Node-Local-Dataset
#A node-local dataset is stored on the local disk of the node and will be deleted when the node is terminated.(not persistent).This is
#useful if you know you need more storage for an experiment but you don't have to keep it later on.

#The following code creates a vlan and 4 VMs. The VMs are created on different aggregates.
#Then uncomment the following code and run terraform apply 

# resource "cloudlab_vlan" "my_vlan" {
#   name        = "vlan"
#   subnet_mask = "255.255.255.0"
# }

# resource "cloudlab_vm" "my_vm" {
#   name         = "vm1"
#   routable_ip  = true
#   image        = "UBUNTU 20.04"
#   aggregate    = "emulab.net"
#   extra_disk_space = 50 # ask for a 50GB file system mounted at /mydata --> see with df -h
# }

# resource "cloudlab_vm" "my_vm2" {
#   name         = "vm2"
#   routable_ip  = true
#   image        = "UBUNTU 20.04"
#   aggregate    = "utah.cloudlab.us"
#   extra_disk_space = 30
# }


# resource "cloudlab_vm" "my_vm3" {
#   name         = "vm3"
#   routable_ip  = true
#   image        = "UBUNTU 24.04"
#   aggregate    = "wisc.cloudlab.us"
# }

# resource "cloudlab_vm" "my_vm4" {
#   name         = "vm4"
#   routable_ip  = true
#   image        = "UBUNTU 24.04"
#   aggregate    = "clemson.cloudlab.us"
# }