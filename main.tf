# Specify the provider and access details
provider "aws" {
  region = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

# Create a VPC
resource "aws_vpc" "example_vpc" {
  cidr_block = "10.10.0.0/16"
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "example_gateway" {
  vpc_id = aws_vpc.example_vpc.id
}

# Create a subnet to launch our instances into
resource "aws_subnet" "example_subnet" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.10.4.0/24"
  map_public_ip_on_launch = false
  availability_zone = var.aws_zone
}

resource "aws_route" "example_route" {
  route_table_id = aws_vpc.example_vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.example_gateway.id
}

# Security group for our application.
resource "aws_security_group" "example_security_group" {
  name        = "example_security_group"
  description = "Security group for example application"
  vpc_id      = aws_vpc.example_vpc.id

  # tfsec:ignore:aws-vpc-add-description-to-security-group-rule
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # tfsec:ignore:aws-vpc-no-public-ingress-sgr
    cidr_blocks = ["0.0.0.0/0"]
  }

}

output "subnet_id" {
  value = aws_subnet.example_subnet.id
}

output "group_ids" {
  value = [aws_security_group.example_security_group.id]
}