#Create VPC
resource "aws_vpc" "prod-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  enable_classiclink = false
  instance_tenancy = "default"

  tags = {
    "name" = "prod-vpc"
  }
}

#Create Public Subnet
resource "aws_subnet" "prod-subnet-public-1" {
  vpc_id = "${aws_vpc.prod-vpc.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    "name" = "prod-subnet-public-1"
  }
}
#Create Internet Gateway
resource "aws_internet_gateway" "prod-igw" {
  vpc_id = "${aws_vpc.prod-vpc.id}"

  tags = {
    "name" = "prod-igw"
  }
}

#Create Route Table
resource "aws_route_table" "prod-public-crt" {
  vpc_id = "${aws_vpc.prod-vpc.id}"

  route = [ {
    carrier_gateway_id = null
    cidr_block = "0.0.0.0/0"
    destination_prefix_list_id = null
    egress_only_gateway_id = null
    gateway_id = "${aws_internet_gateway.prod-igw.id}"
    instance_id = null
    ipv6_cidr_block = null
    local_gateway_id = null
    nat_gateway_id = null
    network_interface_id = null
    transit_gateway_id = null
    vpc_endpoint_id = null
    vpc_peering_connection_id = null
  } ]

  tags = {
    "name" = "prod-public-crt"
  }
}

#Associate CRT and Subnet
resource "aws_route_table_association" "prod-crta-public-subnet-1" {
  subnet_id = "${aws_subnet.prod-subnet-public-1.id}"
  route_table_id = "${aws_route_table.prod-public-crt.id}"
}