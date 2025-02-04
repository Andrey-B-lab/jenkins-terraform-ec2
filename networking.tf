resource "aws_security_group" "allow_all_from_my_ip" {
  name        = "allow_all_from_my_ip"
  description = "Allow inbound from my IP for all ports"
  vpc_id      = "YOUR-VPC-ID" # If you're using the default VPC, you can omit or data-source it.

  tags = {
    Name = "allow_all_from_my_ip"
  }
}

# Ingress rule: Allow all protocols/ports from my IP
resource "aws_security_group_rule" "ingress_all_from_my_ip" {
  type              = "ingress"
  security_group_id = aws_security_group.allow_all_from_my_ip.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["${var.my_ip_address}/32"]
  description       = "Allow all inbound from my IP"
}

# Egress rule: Allow all outbound
resource "aws_security_group_rule" "egress_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.allow_all_from_my_ip.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all outbound"
}
