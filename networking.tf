# Security Group for the second server
resource "aws_security_group" "jenkins_access" {
  name        = "jenkins_access"
  description = "Allow SSH from Jenkins server"
  vpc_id      = data.aws_vpc.default.id
  
  tags = {
    Name = "my_ec2_sg-jenkins"
  }
}

resource "aws_security_group" "example" {
  name        = "example-sg"
  description = "Security group for first server"
  vpc_id      = var.vpc_id

  tags = {
    Name = "example-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "example_ingress" {
  security_group_id = aws_security_group.example.id
  description       = "Allow SSH from my IP"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.my_ip}/32"]  # If you want to restrict to exactly one IP
}

resource "aws_vpc_security_group_egress_rule" "example_egress" {
  security_group_id = aws_security_group.example.id
  description       = "Allow all outbound"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
