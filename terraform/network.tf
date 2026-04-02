resource "oci_core_vcn" "vcn" {
  compartment_id = var.tenancy_ocid
  cidr_blocks    = [var.vcn_cidr]

  display_name = "vcn-${random_pet.proxy.id}"
  dns_label    = "vcn${random_pet.proxy.id}"

  freeform_tags = merge(var.tags, {
    Name = "vcn-${random_pet.proxy.id}"
  })
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.vcn.id

  display_name = "igw-${random_pet.proxy.id}"
  enabled      = true

  freeform_tags = merge(var.tags, {
    Name = "igw-${random_pet.proxy.id}"
  })
}

resource "oci_core_route_table" "rt" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.vcn.id

  display_name = "rt-${random_pet.proxy.id}"

  route_rules {
    network_entity_id = oci_core_internet_gateway.igw.id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    description       = "Allow routing of all traffic"
  }

  freeform_tags = merge(var.tags, {
    Name = "rt-${random_pet.proxy.id}"
  })
}

resource "oci_core_security_list" "public-sl" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "vcn-public-sl-${random_pet.proxy.id}"

  # Allow all traffic out of VM
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
    stateless   = false
  }

  # Allow the Deployer to ssh into the machine
  ingress_security_rules {
    source   = var.deployer_ip
    protocol = "6" # code for tcp 
    tcp_options {
      min = 22
      max = 22
    }
    stateless = false
  }

  # Allow HTTP
  ingress_security_rules {
    source   = "0.0.0.0/0"
    protocol = "6"
    tcp_options {
      min = 80
      max = 80
    }
    stateless = false
  }

  # Allow HTTPS 
  ingress_security_rules {
    source   = "0.0.0.0/0"
    protocol = "6"
    tcp_options {
      min = 443
      max = 433
    }
    stateless = false
  }

  # Allow WireGuard 
  ingress_security_rules {
    source   = "0.0.0.0/0"
    protocol = "17"
    udp_options {
      min = 51820
      max = 51820
    }
    stateless = false
  }

  freeform_tags = merge(var.tags, {
    Name = "vcn-public-sl-${random_pet.proxy.id}"
  })
}

resource "oci_core_subnet" "public-subnet" {
  compartment_id = var.tenancy_ocid
  vcn_id         = oci_core_vcn.vcn.id

  cidr_block                 = var.subnet_cidr
  prohibit_public_ip_on_vnic = false

  display_name = "vcn-public-subnet-${random_pet.proxy.id}"
  dns_label    = "publicsubent${random_pet.proxy.id}"

  route_table_id    = oci_core_route_table.rt.id
  security_list_ids = [oci_core_security_list.public-sl.id]
  freeform_tags = merge(var.tags, {
    Name = "vcn-public-subnet-${random_pet.proxy.id}"
  })
}
