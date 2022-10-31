# main.tf

######
# create ssh key
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# save ssh key
resource "local_file" "ssh_key-keyfile" {
  filename = var.keyFile
  file_permission = "0400"
  content = tls_private_key.ssh_key.private_key_openssh
}

# create ec2 key
resource "aws_key_pair" "aws_key" {
  key_name   = var.keyName
  public_key = tls_private_key.ssh_key.public_key_openssh
}
######

######
# cloud init template
data "template_file" "instance_script" {
  template = file(var.dataFile)
}

# cloud init config
data "template_cloudinit_config" "instance_config" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${data.template_file.instance_script.rendered}"
  }
}
######

######
# create ec2 security group
resource "aws_security_group" "sg_instance" {
  name = var.securityGroup
  description = "[Terraform] Instance ACL"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
######

# create ec2 instance
resource "aws_instance" "instance" {
  ami                        = var.ami
  instance_type              = var.instanceType
  key_name                   = aws_key_pair.aws_key.key_name
  vpc_security_group_ids     = [ aws_security_group.sg_builder.id ]
  user_data_base64           = "${data.template_cloudinit_config.instance_config.rendered}"

  tags = {
    Name = var.instanceName
  }

  volume_tags = {
    Name = var.instanceName
  }
}

# end of main.tf
