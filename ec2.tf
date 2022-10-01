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

data "aws_vpc" "project-1" {
  id = "vpc-0d575aeede3f156b8"
}

data "aws_subnet" "priv-1" {
  id = "subnet-0575b740fb00a93e5"
}

data "aws_subnet" "priv-2" {
  id = "subnet-0f9885713aa384c17"
}

data "aws_subnet" "public-1" {
  id = "subnet-04e7666984a41f53b"
}

data "aws_subnet" "public-2" {
  id = "subnet-002d48988ca0204e2"
}


resource "random_string" "random-1" {
    length = 4
    special = false 
    upper = false
  
}

resource "random_string" "random-2" {
    length = 4
    special = true
    upper = false
  
}

resource "aws_instance" "project-1" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3a.large"
  key_name = aws_key_pair.deployer.key_name
  subnet_id = data.aws_subnet.priv-1.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  root_block_device {
    volume_size = "30"
    
  }

  ebs_block_device {
    volume_size = "50"
    device_name = "/dev/xvdc"
  }

  tags = {
    Name = "project - ${random_string.random-1.result}"
  }
}



resource "aws_key_pair" "deployer" {
  key_name   = "new_key"
  public_key = tls_private_key.project.public_key_openssh
}

resource "tls_private_key" "project" {
  algorithm = "RSA"
  rsa_bits  = 4096  
}

# resource "local_file" "foo" {
#     content  = tls_private_key.project.private_key_pem
#     filename = "new_KEY"
# }



resource "aws_instance" "project-2" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3a.large"
  key_name = aws_key_pair.deployer.key_name
  subnet_id = data.aws_subnet.priv-2.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  root_block_device {
    volume_size = "30"
  }

  ebs_block_device {
    volume_size = "50"
    device_name = "/dev/xvdc"
  }


  tags = {
    Name = "project - ${random_string.random-2.result}"
  }
}