data "template_file" "startup" {
  template = "${file("init.sh")}"
}
resource "aws_launch_template" "template" {
  name_prefix     = "test"
  image_id        = "ami-0bb84b8ffd87024d8"
  instance_type   = "t2.micro"
  key_name = "instance_key"
  # vpc_security_group_ids = [aws_security_group.webapp-sg.id]
  network_interfaces {
    security_groups = [aws_security_group.webapp-sg.id]
    associate_public_ip_address = true
  }
  user_data = "${base64encode(data.template_file.startup.rendered)}"
}

resource "aws_autoscaling_group" "autoscale" {
  name                  = "test-autoscaling-group"  
  
  desired_capacity      = 3
  max_size              = 6
  min_size              = 3
  health_check_type     = "EC2"
  termination_policies  = ["OldestInstance"]
  vpc_zone_identifier   = aws_subnet.public_subnets[*].id

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
}