resource "oci_core_instance" "vm" {
  compartment_id      = var.tenancy_ocid
  availability_domain = data.oci_identity_availability_domains.availability_domains.availability_domains[0].name
  shape               = "VM.Standard.A1.Flex" #Always free! 

  shape_config {
    ocpus         = var.vm_cpu
    memory_in_gbs = var.vm_memory
  }

  source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.oracle_linux.images[0].id
    boot_volume_size_in_gbs = var.vm_storage
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.public-subnet.id
    assign_public_ip = false # this isn't a static ip address

    display_name   = "vps-vnic-${random_pet.proxy.id}"
    hostname_label = "vnic${random_pet.proxy.id}"

    freeform_tags = merge(var.tags, {
      Name = "vps-vnic-${random_pet.proxy.id}"
    })
  }

  metadata = {
    ssh_authorized_keys = file(var.deployer_public_ssh_key)
  }
}
