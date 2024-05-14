data "template_file" "startup" {

  vars = {
    release_archive = "${var.artifact_url}"
  }
  template = "${file("init.sh")}"
}
resource "aws_launch_template" "template" {
  name_prefix     = "test"
  image_id        = "ami-0bb84b8ffd87024d8"
  instance_type   = "t2.micro"
  key_name = "instance_key"
  lifecycle {
    create_before_destroy = true
  }
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
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }
  force_delete = true
  lifecycle {
    create_before_destroy = true
  }
  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
 tag {
    key                 = "release"
    value               = "${var.artifact_url}"
    propagate_at_launch = false
  }
}