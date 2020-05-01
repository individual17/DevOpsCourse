
provider "aws" {
  access_key = "add_access_key"
  secret_key = "add_secret"
  region     = "add_region"
}


resource "aws_instance" "prometheus_instance" {
  ami                    = "ami-0e84e211558a022c0" #amazon linux ami
  instance_type          = "t2.micro"
  key_name               = "12345"
  vpc_security_group_ids = [aws_security_group.prometheus_instance.id]
  user_data              = file("prometheus_with_grafana.sh")
}

resource "aws_security_group" "prometheus_instance" {
  name        = "Serv sec grp"
  description = "1st sec grp"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
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
