provider "aws" {
  access_key = ""
  secret_key = ""
  region = ""
}

resource "aws_instance" "server" {
  lifecycle {
    create_before_destroy = true
  }
  count         = 2 # create two similar EC2 instances
  ami           = "ami-0a75b786d9a7f8144"
  instance_type = "t2.micro"
  key_name = "terraform-aws"
  security_groups = ["terraform-aws"]

  tags = {
    Name = "Server ${count.index}"
  }
}



resource "aws_security_group" "terraform-aws" {
  name = "terraform-aws"
  description = "Allow standart http and https ports inbound and everything outbound"

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Terraform" : "true"
  }

}


