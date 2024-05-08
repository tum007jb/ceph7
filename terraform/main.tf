#variable vault_token {}
variable vsphere_user {}
variable vsphere_password {}
variable "vsphere_server" {
  default = "localhost"
}
# vsphere datacenter the virtual machine will be deployed to. empty by default.
variable "vsphere_datacenter" {}

# vsphere resource pool the virtual machine will be deployed to. empty by default.
variable "vsphere_resource_pool" {}

# vsphere datastore the virtual machine will be deployed to. empty by default.
variable "vsphere_datastore" {}

# vsphere network the virtual machine will be connected to. empty by default.
variable "vsphere_network" {}

# vsphere virtual machine template that the virtual machine will be cloned from. empty by default.
variable "vsphere_virtual_machine_template" {}

# the name of the vsphere virtual machine that is created. empty by default.
#variable "vsphere_virtual_machine_name" {}

variable "vsphere_folder_vm" {}
variable "guest_cpu" {}
variable "guest_ram" {}
#variable "guest_disk" {}
variable "vm_name1"{}
variable "gateway" {}
variable "dns_list" {}
variable "dns_search" {}
variable "ipvm1" {}
variable "vm_name2"{}
variable "ipvm2" {}
variable "vm_name3"{}
variable "ipvm3" {}
variable "hostname1"{}
variable "hostname2"{}
variable "hostname3"{}

#provider "vault" {
#  address         = "http://vault-server-hashicrop-vault.apps.ocpdso.dso.local"
#  skip_tls_verify = true
#  token           = var.vault_token
#}

#data "vault_generic_secret" "vcenter" {
#  path = "vcenter/lab"
#}

provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  #user            = data.vault_generic_secret.vcenter.data["username"]
  #password        = data.vault_generic_secret.vcenter.data["password"]
  vsphere_server = "${var.vsphere_server}"
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "${var.vsphere_datacenter}"
}

data "vsphere_datastore" "datastore" {
  name          = "${var.vsphere_datastore}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "${var.vsphere_resource_pool}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "${var.vsphere_network}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.vsphere_virtual_machine_template}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}


#Provision VM1
resource "vsphere_virtual_machine" "cloned_virtual_machine_vm1" {
  name             = "${var.vm_name1}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  

  num_cpus = "${ var.guest_cpu }"
  num_cores_per_socket = "${ var.guest_cpu }"
  //cpu_reservation = "${ var.guest_cpu }"
  memory   = "${ var.guest_ram }"
  //memory_reservation = "${ var.guest_ram }"
  folder = "${ var.vsphere_folder_vm }"
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"
  firmware = "${data.vsphere_virtual_machine.template.firmware}"
  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label = "disk0"
    size = 100
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
      customize {
        linux_options {
        host_name = "${var.hostname1}"
        domain    = "dso.local"
      }
        network_interface {
          ipv4_address = "${var.ipvm1}"
          ipv4_netmask = 24
        }
        ipv4_gateway    = "${var.gateway}"
        dns_server_list = [var.dns_list]
        dns_suffix_list = [var.dns_search]
    }
  }
}

#Provision VM2
resource "vsphere_virtual_machine" "cloned_virtual_machine_vm2" {
  name             = "${var.vm_name2}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = "${ var.guest_cpu }"
  num_cores_per_socket = "${ var.guest_cpu }"
  //cpu_reservation = "${ var.guest_cpu }"
  memory   = "${ var.guest_ram }"
  //memory_reservation = "${ var.guest_ram }"
  folder = "${ var.vsphere_folder_vm }"
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"
  firmware = "${data.vsphere_virtual_machine.template.firmware}"
  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label = "disk0"
    size = 100
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
      customize {
        linux_options {
        host_name = "${var.hostname2}"
        domain    = "dso.local"
      }
        network_interface {
          ipv4_address = "${var.ipvm2}"
          ipv4_netmask = 24
        }
        ipv4_gateway    = "${var.gateway}"
        dns_server_list = [var.dns_list]
        dns_suffix_list = [var.dns_search]
    }
  }
}

#Provision VM3
resource "vsphere_virtual_machine" "cloned_virtual_machine_vm3" {
  name             = "${var.vm_name3}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = "${ var.guest_cpu }"
  num_cores_per_socket = "${ var.guest_cpu }"
  //cpu_reservation = "${ var.guest_cpu }"
  memory   = "${ var.guest_ram }"
  //memory_reservation = "${ var.guest_ram }"
  folder = "${ var.vsphere_folder_vm }"
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"
  firmware = "${data.vsphere_virtual_machine.template.firmware}"
  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label = "disk0"
    size = 100
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
      customize {
        linux_options {
        host_name = "${var.hostname3}"
        domain    = "dso.local"
      }
        network_interface {
          ipv4_address = "${var.ipvm3}"
          ipv4_netmask = 24
        }
        ipv4_gateway    = "${var.gateway}"
        dns_server_list = [var.dns_list]
        dns_suffix_list = [var.dns_search]
    }
  }
}