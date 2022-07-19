resource "aws_vpc" "lab_vpc" {
    cidr_block = var.vpc_cidr

    tags = {
      Name = var.vpc_name
    }
}


resource "aws_subnet" "public" {
    vpc_id = aws_vpc.lab_vpc.id
    cidr_block = var.cidr_public

    tags = {
      "Name" = "public"
    }
  
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.lab_vpc.id
    cidr_block = var.cidr_private

    tags = {
      "Name" = "private"
    }
  
}

resource "aws_subnet" "date" {
    vpc_id = aws_vpc.lab_vpc.id
    cidr_block = var.cidr_data

    tags = {
      "Name" = "data"
    }
  
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.lab_vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}


resource "aws_eip" "lb" {
  vpc      = true

  tags = {
     Name = "my_elastic_ip"
  }
  
}


resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}