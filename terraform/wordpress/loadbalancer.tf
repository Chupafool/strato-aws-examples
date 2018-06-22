
#Provision load balancer
resource "aws_alb" "alb" {
  subnets = ["${aws_subnet.pub_subnet.id}"]
  internal = false
  security_groups = ["${aws_security_group.lb-sec.id}"]
  #depends_on = ["aws_route_table_association.rtb_assoc_to_pub"]

  #workaround
  lifecycle {
    ignore_changes = ["load_balancer_type", "security_groups"]
  }
}

resource "aws_alb_target_group" "targ" {
  port = 8080
  protocol = "HTTP"
  vpc_id = "${aws_vpc.app_vpc.id}"

  #workaround - won't be needed in 4.2.6
  lifecycle {
    ignore_changes = ["port", "target_type", "vpc_id"]
  }
}

resource "aws_alb_target_group_attachment" "attach_web1" {
  target_group_arn = "${aws_alb_target_group.targ.arn}"
  target_id = "${aws_instance.web-server1.id}"
  port = 8080
}

resource "aws_alb_target_group_attachment" "attach_web2" {
  target_group_arn = "${aws_alb_target_group.targ.arn}"
  target_id = "${aws_instance.web-server2.id}"
  port = 8080
}

resource "aws_alb_listener" "list" {
  "default_action" {
    target_group_arn = "${aws_alb_target_group.targ.arn}"
    type = "forward"
  }
  load_balancer_arn = "${aws_alb.alb.arn}"
  port = 80
//  depends_on = ["aws_instance.web-server"]
}

resource "aws_security_group" "lb-sec" {
  name = "lb-secgroup"
  vpc_id = "${aws_vpc.app_vpc.id}"

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #ping from anywhere
    ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # default security group has egress completely free
}
