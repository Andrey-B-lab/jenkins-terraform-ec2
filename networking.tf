# Security Group for the second server
resource "aws_security_group" "allow_all_from_my_ip" {
  name        = "allow_all_from_my_ip"
  description = "Allow all from my IP"
  vpc_id      = data.aws_vpc.default.id
  
  tags = {
    Name = "my_ec2_sg-myIP"
  }
}

resource "aws_vpc_security_group_ingress_rule" "example_ingress" {
  security_group_id = aws_security_group.example.id
  description       = "Allow SSH from my IP"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.my_ip_address}/32"]  # If you want to restrict to exactly one IP
}

resource "aws_vpc_security_group_egress_rule" "example_egress" {
  security_group_id = aws_security_group.example.id
  description       = "Allow all outbound"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
