resource "aws_security_group" "sg_elb_morse" {
  name = "sg_elb_morse"
  vpc_id = "${aws_vpc.vpc_main.id}"

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
        from_port       = 9999
        to_port         = 9999
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        protocol = "-1"
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
}
