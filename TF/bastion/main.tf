resource "aws_instance" "bastion" {
  ami                    = var.image
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg-jenkins.id]
  key_name               = "goaws"


  connection {
    host        = self.public_ip
    port        = 22
    private_key = file("${path.module}/goaws.pem") // use pemkey at the time of applying the infrastructure
    user        = "ec2-user"
    type        = "ssh"
  }

  provisioner "file" {
    source      = "helm.sh"
    destination = "/home/ec2-user/helm.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/helm.sh",
      "/home/ec2-user/helm.sh"
    ]
  }

  root_block_device {
    volume_size = 20
    volume_type = "gp2"
  }
  tags = {
    Name = "bastion-server"
  }
}


resource "aws_security_group" "sg-jenkins" {
  vpc_id      = "vpc-085d437c59dcb52dd"
  description = "securitygroup-buildserver"

  ingress = [
    for ports in [22, 8080, 9000] : {
      from_port        = ports
      to_port          = ports
      description      = "enable ssh and jenkins port"
      self             = false
      security_groups  = []
      ipv6_cidr_blocks = []
      cidr_blocks      = ["0.0.0.0/0"]
      prefix_list_ids  = []
      protocol         = "tcp"
    }
  ]
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "null_resource" "install_packages" {

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${path.module}/goaws.pem")
    host        = aws_instance.bastion.public_ip
    port        = 22
  }

  provisioner "file" {
    source      = "eksctl.sh"
    destination = "/home/ec2-user/eksctl.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/eksctl.sh",
      "/home/ec2-user/eksctl.sh"
    ]
  }
}