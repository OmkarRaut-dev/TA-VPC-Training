resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.lab_vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}
