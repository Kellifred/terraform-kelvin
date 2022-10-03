data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Canonical
}

data "aws_vpc" "protradenet_vpc" {
  id = "vpc-0a87cea05526db67d"
}

data "aws_subnet" "protradenet_priv-1" {
  id = "subnet-0ac5b975f1505a4d9"
}

data "aws_subnet" "protradenet_priv-2" {
  id = "subnet-023d5d457e96deb29"
}

data "aws_subnet" "protradenet_public-1" {
  id = "subnet-060c1a045db9f924a"
}

data "aws_subnet" "protradenet_public-2" {
  id = "subnet-0d03dfc09e3ac4a3f"
}

resource "aws_instance" "protradenet-1" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3a.large"
  key_name = aws_key_pair.protradenet-key.key_name
  subnet_id = data.aws_subnet.protradenet_priv-1.id
  vpc_security_group_ids = [aws_security_group.protradenet-sg.id]
  root_block_device {
    volume_size = "30"
    
  }

  ebs_block_device {
    volume_size = "50"
    device_name = "/dev/xvdc"
  }

  tags = {
    Name = "protradenet-1"
  }
}



resource "aws_key_pair" "protradenet-key" {
  key_name   = "protradenet_key"
  public_key = tls_private_key.protradenet_key.public_key_openssh
}

resource "tls_private_key" "protradenet_key" {
  algorithm = "RSA"
  rsa_bits  = 4096  
}

# resource "local_file" "foo" {
#     content  = tls_private_key.project.private_key_pem
#     filename = "new_KEY"
# }



resource "aws_instance" "protradenet-2" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3a.large"
  key_name = aws_key_pair.protradenet-key.key_name
  subnet_id = data.aws_subnet.protradenet_priv-2.id
  vpc_security_group_ids = [aws_security_group.protradenet-sg.id]
  root_block_device {
    volume_size = "30"
  }

  ebs_block_device {
    volume_size = "50"
    device_name = "/dev/xvdc"
  }


  tags = {
    Name = "protradenet-2"
  }
}