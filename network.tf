resource "aws_security_group" "webapp-sg" {
  name        = "ubuntu-security-group"
  description = "Allow HTTP, HTTPS and SSH traffic"
 vpc_id      = var.main_vpc_id
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
  
}

resource "aws_subnet" "public_subnets" {
 count      = length(var.public_subnet_cidrs)
 vpc_id     = var.main_vpc_id
 cidr_block = element(var.public_subnet_cidrs, count.index)
 tags = {
   Name = "Public Subnet ${count.index + 1}"
 }
}

resource "aws_route_table" "second_rt" {
 vpc_id = var.main_vpc_id
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = var.main_vpc_gw
 }
 tags = {
   Name = "2nd Route Table"
 }
}
resource "aws_route_table_association" "public_subnet_asso" {
 count = length(var.public_subnet_cidrs)
 subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
 route_table_id = aws_route_table.second_rt.id
}