data "aws_instances" "test" {
  instance_tags = {
    Role = "HardWorker"
  }

  filter {
    name   = "instance.group-id"
    values = ["sg-12345678"]
  }

  instance_state_names = ["running", "stopped"]
}

resource "aws_eip" "test" {
  count    = length(data.aws_instances.test.ids)
  instance = data.aws_instances.test.ids[count.index]
}
