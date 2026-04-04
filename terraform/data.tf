data "oci_identity_availability_domains" "availability_domains" {
  compartment_id = var.tenancy_ocid
}

data "oci_core_images" "oracle_linux" {
  compartment_id           = var.tenancy_ocid
  operating_system         = "Oracle Linux"
  operating_system_version = "9"
  shape                    = "VM.Standard.A1.Flex"
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"

  filter {
    name   = "display_name"
    values = ["^.*-aarch64-.*$"]
    regex  = true
  }
}


###################################################
## This data is collected *after* oci is created ##
###################################################

data "oci_core_vnic_attachments" "vm_vnic_attachments" {
  compartment_id = var.tenancy_ocid
  instance_id    = oci_core_instance.vm.id
}

data "oci_core_private_ips" "vm_private_ips" {
  vnic_id = data.oci_core_vnic_attachments.vm_vnic_attachments.vnic_attachments[0].vnic_id
}
