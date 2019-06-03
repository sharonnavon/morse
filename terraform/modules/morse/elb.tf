resource "aws_elb" "elb_morse" {
  name = "elb-morse-${element(data.aws_availability_zones.available.names, count.index)}"
  internal = false
  cross_zone_load_balancing = true
  subnets = ["${aws_subnet.public.*.id}"]
  security_groups = ["${aws_security_group.sg_elb_morse.id}"]
  instances = ["${aws_instance.docker.*.id}"]

  listener {
    instance_port = 9999
    instance_protocol = "TCP"
    lb_port = 9999
    lb_protocol = "TCP"
  }

  health_check {
    healthy_threshold = 2
    interval = 10
    timeout = 5
    unhealthy_threshold = 2
    target = "TCP:9999"
  }
}
