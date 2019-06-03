data "template_file" "docker_install" {
  template = "${file("${path.module}/templates/docker.sh.tpl")}"
}

resource "aws_instance" "docker" {
  count = "${length(data.aws_availability_zones.available.names) * var.servers_per_az}"
  associate_public_ip_address = true
  ami = "${var.ami_ubuntu}"
  instance_type = "t2.micro"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  vpc_security_group_ids = ["${aws_security_group.sg_elb_morse.id}"]
  key_name = "${var.key_name}"
  tags {
    Name = "docker-${element(data.aws_availability_zones.available.names, count.index)}-${count.index+1}"
  }
  user_data = "${element(data.template_file.docker_install.*.rendered, count.index)}"
}


data "template_file" "client_install" {
  template = "${file("${path.module}/templates/client.sh.tpl")}"

  vars {
    elb_morse_dns_name = "${aws_elb.elb_morse.dns_name}"
  }
}

resource "aws_instance" "client" {
  count = "1"
  associate_public_ip_address = true
  ami = "${var.ami_ubuntu}"
  instance_type = "t2.micro"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  vpc_security_group_ids = ["${aws_security_group.sg_elb_morse.id}"]
  key_name = "${var.key_name}"
  tags {
    Name = "client-${element(data.aws_availability_zones.available.names, count.index)}-${count.index+1}"
  }
  user_data = "${(data.template_file.client_install.rendered)}"
}
