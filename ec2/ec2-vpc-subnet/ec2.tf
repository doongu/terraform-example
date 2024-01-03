resource "aws_instance" "example" {
  ami						= "ami-0e9bfdb247cc8de84"
  instance_type 			= "t2.micro"
  key_name					= "mysql_server"
  subnet_id					= aws_subnet.subnet.id
  vpc_security_group_ids	= ["${aws_security_group.sg.id}"]
  user_data					= <<-EOF
							  #!/bin/bash
							  sudo apt-get -y update
							  sudo apt-get install -y apache2
							  sudo systemctl start apache2
							  sudo systemctl enable apache2
							  sudo echo "nimwver" > /var/www/html/index.html
							  EOF

  tags = {
    Name = "ec2_example"
  }
}

resource "aws_security_group" "sg" {
  name			= "sg"
  description	= "http"
  vpc_id		= aws_vpc.vpc.id
}

resource "aws_security_group_rule" "inbound" {
  type				= "ingress"
  from_port			= 80
  to_port			= 80
  protocol			= "tcp"
  cidr_blocks		= ["0.0.0.0/0"]
  security_group_id	= aws_security_group.sg.id
  description		= "inbound"
}

resource "aws_security_group_rule" "outbound" {
  type				= "egress"
  from_port			= 0
  to_port			= 0
  protocol			= "-1"
  cidr_blocks		= ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
  description		= "outbound"
}

output "public_ip" {
  value			= aws_instance.example.public_ip
  description	= "The public IP"
}
