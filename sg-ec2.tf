resource "aws_security_group" "protradenet-sg" {
  name        = "allow_access"
  description = "Allow access inbound traffic"
  vpc_id      = data.aws_vpc.protradenet_vpc.id

  ingress {
    description      = "ssh from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["130.45.111.64/32","203.122.33.130/32","122.177.104.104/32","122.177.48.115/32","159.224.220.241/32","44.203.251.3/32"]
  }
   ingress {
    description      = "mysql/aurora from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["207.36.136.72/32","12.208.243.202/32","64.70.194.0/24","23.21.85.5/32","207.36.136.35/32","64.70.193.0/24","216.87.172.161/32"]
  }
    ingress {
    description      = "custom tcp from VPC"
    from_port        = 9000
    to_port          = 9000
    protocol         = "tcp"
    cidr_blocks      = ["159.224.220.241/32"]
    }
    ingress {
    description      = "http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
    ingress {
    description      = "https from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
    ingress {
    description      = "custom tcp from VPC"
    from_port        = 88
    to_port          = 88
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
    ingress {
    description      = "All trafic from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["12.239.215.0/24"]
    }

   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

 tags = {
    Name = "protradenet_sg"
  }
} 