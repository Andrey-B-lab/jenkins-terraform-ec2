# Security Group for the second server
resource "aws_security_group" "jenkins_access" {
  name        = "jenkins_access"
  description = "Allow SSH from Jenkins server"
  vpc_id      = data.aws_vpc.default.id
  
  tags = {
    Name = "my_ec2_sg-jenkins"
  }
}

# Ingress rule for IPv4
resource "aws_vpc_security_group_ingress_rule" "ssh_from_jenkins_ipv4" {
  security_group_id = aws_security_group.jenkins_access.id
  description       = "Allow SSH from Jenkins IPv4"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.jenkins_ip_address}/32"]  # The Jenkins server's public IP or private IP range
}

# Optionally, if you actually need IPv6
# If not needed, omit this entirely
resource "aws_vpc_security_group_ingress_rule" "ssh_from_jenkins_ipv6" {
  security_group_id    = aws_security_group.jenkins_access.id
  description          = "Allow SSH from Jenkins IPv6"
  from_port            = 22
  to_port              = 22
  protocol             = "tcp"
  ipv6_cidr_blocks     = ["${var.jenkins_ip_address}/128"]  # If you have a real IPv6
}

# Egress rule: allow all outbound (common default)
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.jenkins_access.id
  description       = "Allow all outbound"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
