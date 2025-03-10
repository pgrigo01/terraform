<!-- markdownlint-disable first-line-h1 no-inline-html -->
<a href="https://terraform.io">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset=".github/terraform_logo_dark.svg">
    <source media="(prefers-color-scheme: light)" srcset=".github/terraform_logo_light.svg">
    <img src=".github/terraform_logo_light.svg" alt="Terraform logo" title="Terraform" align="right" height="50">
  </picture>
</a>

# Terraform CloudLab Provider
[discuss-badge]: https://img.shields.io/badge/discuss-terraform--cloudlab-623CE4.svg?style=flat
![Forums][discuss-badge]

The [CloudLab Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) allows [Terraform](https://terraform.io) to manage [CloudLab](https://www.cloudlab.us/) resources.

## Usage Example
```
#When changing versions run:
# terraform init -upgrade 

#If first time run : terraform init 
#If you want to see the changes in the plan  run: terraform plan 
#If you want to apply the plan run: terraform apply 

#version = "2.2.0" //for locallhost 
#version = "3.0.0" //works with duckdns when running the server not working on ucy wifi otan allazo vms 
# If a new vm is added and the server is running on the ucy wifi then change the HostURL to the new vm's ip address 
# and build the provider with ./buildprovider.sh 

# CloudLab provider configuration, specifying the path to the credentials file and API endpoint
terraform {
  required_providers {
    cloudlab = {
      source  = "pgrigo01/cloudlab" # this directory is under the .terraform directory
      version = "2.2.0"
    }
  }
}

provider "cloudlab" {
  project          = "UCY-CS499-DC"
  credentials_path = "cloudlab-decrypted.pem" # path to the credentials file that is downloaded from CloudLab and decrypted
}
# terraform init
# terraform workspace new workspace1
# terraform workspace select workspace1 
# terraform workspace list //to see the workspaces

#IF ON WORKSPACE 2 (if you have a second one) Do this to differentiate the resources accross workspaces
# terraform init
# terraform workspace new workspace2
# terraform workspace select workspace2

#Then uncon=mment the following code and run terraform apply 

# resource "cloudlab_vlan" "my_vlan" {
#   name        = "vlan-${terraform.workspace}"
#   subnet_mask = "255.255.255.0"
# }

# resource "cloudlab_vm" "my_vm" {
#   name         = "vm1-${terraform.workspace}"
#   routable_ip  = true
#   image        = "UBUNTU 20.04"
#   aggregate    = "Any"
# }

# resource "cloudlab_vm" "my_vm2" {
#   name         = "vm2-${terraform.workspace}"
#   routable_ip  = true
#   image        = "UBUNTU 20.04"
#   aggregate    = "Any"
# }
```
