resource "aws_security_group" "allow_all_from_my_ip" {
  name        = "allow_all_from_my_ip"
  description = "Allow all inbound traffic from my IP"

  tags = {
    Name = "my_ec2_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "my_ec2_sg_ipv4" {
    description = "Allow HTTP from Leumi Proxy"
    cidr_ipv4         = aws_vpc.main.cidr_block
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip_address}/32"]  # Taken from variables.tf
}

resource "aws_vpc_security_group_ingress_rule" "my_ec2_sg_ipv6" {
    description = "Allow HTTP from Leumi Proxy"
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip_address}/32"]  # Taken from variables.tf
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.my_ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.my_ec2_sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
