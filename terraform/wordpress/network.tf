#Provision vpc, subnets, igw, and default route
#1 VPC - 3 subnets (public, web, database)

#provision app vpc
resource "aws_vpc" "app_vpc" {
  cidr_block = "192.168.0.0/16"
  assign_generated_ipv6_cidr_block = false
  enable_dns_support = false
  enable_dns_hostnames = false
  tags {
    Name = "WP Solution VPC"
  }
}

#create igw
resource "aws_internet_gateway" "app_igw" {
  vpc_id = "${aws_vpc.app_vpc.id}"
}

#provision public subnet 
resource "aws_subnet" "pub_subnet"{
  vpc_id = "${aws_vpc.app_vpc.id}"
  cidr_block = "192.168.10.0/24"
  tags {
      Name = "public subnet"
  }
}

#provision webserver subnet
resource "aws_subnet" "web_subnet" {
  vpc_id = "${aws_vpc.app_vpc.id}"
  cidr_block = "192.168.20.0/24"
  tags {
    Name = "web server subnet"
  }
}

#provision database subnet
resource "aws_subnet" "db_subnet" {
  vpc_id = "${aws_vpc.app_vpc.id}"
  cidr_block = "192.168.30.0/24"
  tags {
    # name didn't apply - file a bug
    Name = "database subnet"
  }
}

 #new default route table 
 # having issues deploying in Symphony
resource "aws_default_route_table" "default" {
   default_route_table_id = "${aws_vpc.app_vpc.default_route_table_id}"

   route {
       cidr_block = "0.0.0.0/0"
       gateway_id = "${aws_internet_gateway.app_igw.id}"
   }
}




