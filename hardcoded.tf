resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  user_data     = "supersecret"
}

resource "aws_security_group_rule" "example" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.example.id
}
