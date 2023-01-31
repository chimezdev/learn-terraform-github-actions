#Create and bootstrap webserver
resource "aws_instance" "webserver" {
  ami                         = data.aws_ssm_parameter.webserver-ami.value
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.webserver-key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.subnet.id
  provisioner "remote-exec" { #this block will provision apache webserver in the ec2 resources
    inline = [ 
      "sudo yum -y install httpd && sudo systemctl start httpd",
      "echo '<h1><center>My Test Website With Help From Terraform Provisioner</center></h1>' > index.html",
      "sudo mv index.html /var/www/html/"
    ]
    # the terra provisioner will use this connection info to connect to the instance server
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/id_rsa_example") #giv the directory in my local device where the key pair is stored.
      # to create the keypair use, 'ssh-keygen -C <your_email_address> -f ~/.ssh/id_rsa_example'
      host        = self.public_ip # 'self' obj has access to all the attr of the resource in which it's defined
    }
  }
  tags = {
    Name = "webserver"
  }
}
