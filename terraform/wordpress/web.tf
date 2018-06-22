#Deploy Wordpress instances

#Reference to bash script which prepares xenial image
data "template_file" "wpdeploy"{
  template = "${file("./webconfig.conf")}"

  vars {
    db_ip = "${aws_db_instance.wpdb.address}"
    db_user = "${var.db_user}"
    db_password = "${var.db_password}"
  }
}

resource "aws_instance" "web-server1" {
  ami = "${var.web_ami}"
  # The public SG is added for SSH and ICMP
  vpc_security_group_ids = ["${aws_security_group.pub.id}", "${aws_security_group.web-sec.id}", "${aws_security_group.allout.id}"]
  instance_type = "${var.web_instance_type}"
  subnet_id = "${aws_subnet.web_subnet.id}"

  tags {
    Name = "web-server-1"
  }
 # count = "${var.web_number}"
  user_data = "${data.template_file.wpdeploy.rendered}"
}

resource "aws_instance" "web-server2" {
  ami = "${var.web_ami}"
  # The public SG is added for SSH and ICMP
  vpc_security_group_ids = ["${aws_security_group.pub.id}", "${aws_security_group.web-sec.id}", "${aws_security_group.allout.id}"]
  instance_type = "${var.web_instance_type}"
  subnet_id = "${aws_subnet.web_subnet.id}"

  tags {
    Name = "web-server-2"
  }
 # count = "${var.web_number}"
  user_data = "${data.template_file.wpdeploy.rendered}"
}

resource "aws_security_group" "web-sec" {
  name = "webserver-secgroup"
  vpc_id = "${aws_vpc.app_vpc.id}"

  # Internal HTTP access from anywhere
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #ssh from anywhere (unnecessary)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # ping access from anywhere
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#public access sg 
resource "aws_security_group" "pub" {
  name = "pub-secgroup"
  vpc_id = "${aws_vpc.app_vpc.id}"

  # ssh access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # ping access from anywhere
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # default security group has egress completely free
}

resource "aws_security_group" "allout" {
  name = "allout-secgroup"
  vpc_id = "${aws_vpc.app_vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
