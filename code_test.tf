provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
}

resource "aws_security_group" "example" {
  name_prefix = "example-"
}

# This rule has a security issue, causing tfsec to fail
resource "aws_security_group_rule" "example" {
  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.example.id
}
