output "vm_id" {
  description = "OCID of the compute"
  value       = oci_core_instance.vm.id
}

output "vm_image_name" {
  description = "The name of the image that was used"
  value       = data.oci_core_images.oracle_linux.images[0].name
}

output "vm_private_ip" {
  description = "Private IP address of the VM"
  value       = oci_core_instance.vm.private_ip
}

output "vm_public_ip" {
  description = "Public IP address of the VM"
  value       = oci_core_public_ip.vm_reserved_ip.ip_address
}
