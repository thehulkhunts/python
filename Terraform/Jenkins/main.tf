resource "aws_instance" "jenkins" {
  ami           = var.image
  instance_type = var.instance_type[0]
  user_data     = file("${path.module}/jenkins.sh")
  key_name      = "goaws"

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("${path.module}/goaws.pem") //use your pem file at the time of execution
    port        = 22
  }

  provisioner "file" {
    source      = "sonarqube.sh"
    destination = "/home/ec2-user/sonarqube.sh" //copy your script to dest of your remote server
  }

  provisioner "remote-exec" {

    inline = [
      "chmod +x /home/ec2-user/sonarqube.sh",
      "/home/ec2-user/sonarqube.sh" // execute your script

    ]

  }


  tags = {
    Name        = "jenkins-build-server"
    Environment = "prod"
  }

  root_block_device {

    volume_size = 20
    volume_type = "gp2"

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