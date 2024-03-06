# Create security group for public instance
resource "aws_security_group" "r_public_instance-sg" {
  name        = "${var.project_name}-${var.environment}-Public-SG"
  description = "Allow ssh and SSM inbound traffic"
  vpc_id      = aws_vpc.r_vpc.id

  tags = {
    Name = "${var.project_name}-${var.environment}-Public-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "r_allow_ssh" {
  security_group_id = aws_security_group.r_public_instance-sg.id
  cidr_ipv4         = var.jump_server
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "r_allow_https" {
  security_group_id = aws_security_group.r_public_instance-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "r_allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.r_public_instance-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# Amazon Linux 2 AMI (HVM)
# resource "aws_instance" "r_amazon_linux2" {
#   count                       = length(var.amis)
#   ami                         = var.amis[count.index]
#   instance_type               = var.instance_type
#   associate_public_ip_address = true
#   key_name                    = var.ec2_kp
#   vpc_security_group_ids      = [aws_security_group.r_public_instance-sg.id]
#   subnet_id                   = aws_subnet.r_public_subnet-01.id
#   iam_instance_profile        = aws_iam_instance_profile.r_instance_profile.name
#   #### >> update below parameters << ####

#   user_data = <<EOF
# #!/bin/bash
# useradd -m vajira_04101 && mkdir /home/vajira_04101/.ssh && touch /home/vajira_04101/.ssh/authorized_keys && echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAxlzQWAeMiksOHlpt4CnqgqHwHjwD2brK7XBX0Y44rkgMgdIqIsiniksTzldJGNty4r1k1EIPLhkLqEzJcuWTY/xckNVhhATHXbl85AG4ht8Rfk4A8lOAt6e9HrwV3mH4BiTWtcU43zMLawhq/atJgx45fFiM2jbzbI3dwJpgIzQ7fe9u6bJ81ZhwJueeEV/tb0kKBI9/gWiuO7tU5+JpAdv9YbmpQ60m4+qvHBoLEzMGxY/4iU0dtp+azyhayKaMDOpWF6TvoCRY4Xx2o7A7T3y3M3AZcrjpOOtdQr2MhQ+Zwknvug7syrRAnKJSguozLAj6CaUCX+nlPUduMi4lrQ== rsa-key-20210423" > /home/vajira_04101/.ssh/authorized_keys && chown -R vajira_04101.vajira_04101 /home/vajira_04101/.ssh && chmod 644 /home/vajira_04101/.ssh/authorized_keys && touch /etc/sudoers.d/90-cloud-init-users && echo "vajira_04101 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/90-cloud-init-users && visudo -cf /etc/sudoers.d/90-cloud-init-users

# useradd -m ominda_10447 && mkdir /home/ominda_10447/.ssh && touch /home/ominda_10447/.ssh/authorized_keys && echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCrtqh4ASNWJ77wsA1Pwi0kFjyE7+UWCuJ0CXLP0sdt73RWcl4I2sBvnF0VZzCDav7/qeESHRn7yLpuLa3nORgII2x5LAkUJpk53A43Sqze8YmgHc8Y9BJ9caJear0ZHiPx/HlkBee1SCgoGS60E4B7fsjxfnXlt/7vI4RO/bXtYvbdkXZRN6oXBxljsZo3a9Qu2SB1qz4G21IB4xJ/W8WaDeztYwY5w46FG5OTqwVSLnFgFKOaeMaiwPw/o5aYAVM8wJg/5jwUCw1glq9HC9QZqH+bpsnORdZQJVv0oSyCnTKnJ/j7NixQPWdSzMSYLESgOkmH3KJGrNPEwAeyKuRrbmtfusQ+OqjZtvDFvx730MHnTPygFJS2/xvz+ypJw9z3QkMsyLi8+gRgyd13zt37aINroIdCj9KDiJqCCPx3Cs2wOP9c3ZFHOR/9++f249HwxBGAU56yYQ2m85CDJc++I2pyuuxeMQlzbn77P13GBZFVbuu2JOb7E5j0K8+xKmc= dialog\ominda_10447@10447-001L" > /home/ominda_10447/.ssh/authorized_keys && chown -R ominda_10447.ominda_10447 /home/ominda_10447/.ssh && chmod 644 /home/ominda_10447/.ssh/authorized_keys && touch /etc/sudoers.d/90-cloud-init-users && echo "ominda_10447 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/90-cloud-init-users && visudo -cf /etc/sudoers.d/90-cloud-init-users

# useradd -m mihidinu_09875 && mkdir /home/mihidinu_09875/.ssh && touch /home/mihidinu_09875/.ssh/authorized_keys && echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDnLTk994bsvZCyQmKtqV0nKXPIS4YK+z+Hc3zAfebeAVjFuGAI7BnAnQuI8S+BhxRUIQK+jMToOqxlgOAnCrvoLAWAnVOYYDUtxjk5kue+QSH18U/UNuTTmnuOE1qb+FqdciC1Fy331L/Cwi41BvTo8YcXjm1mnUC4Tu1uj9wrwms04Qm8679XHGoxdsQ/ZAX/7fEUB6o9Av+a0laAADVf0WQlLS3nxofneY+7dE+N/AzvVQXiwzPlIyttqWs5NeHSmljcXyHuygn1JUzkzrvJL2TANjZNrmF9LiilCC3IID0Yy1qrW73TzRyHRfS2XaQ2eeGO7tFTDSbFGo2UCLPZ dialog\mihidinu_09875@09875-002L" > /home/mihidinu_09875/.ssh/authorized_keys && chown -R mihidinu_09875.mihidinu_09875 /home/mihidinu_09875/.ssh && chmod 644 /home/mihidinu_09875/.ssh/authorized_keys && touch /etc/sudoers.d/90-cloud-init-users && echo "mihidinu_09875 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/90-cloud-init-users && visudo -cf /etc/sudoers.d/90-cloud-init-users

# sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
# sudo systemctl enable amazon-ssm-agent
# sudo systemctl start amazon-ssm-agent
# EOF

#   tags = {
#     Name = "${var.project_name}-${var.environment}-${var.os_flavour[count.index]}"
#   }
# }

resource "aws_instance" "r_instances-ec2" {
  for_each                    = var.ec2_os_and_amis
  ami                         = each.value.ami
  instance_type               = each.value.type
  associate_public_ip_address = true
  key_name                    = var.ec2_kp
  vpc_security_group_ids      = [aws_security_group.r_public_instance-sg.id]
  subnet_id                   = aws_subnet.r_public_subnet-01.id
  iam_instance_profile        = aws_iam_instance_profile.r_instance_profile.name
  #### >> update below parameters << ####

  user_data = <<EOF
#!/bin/bash
useradd -m vajira_04101 && mkdir /home/vajira_04101/.ssh && touch /home/vajira_04101/.ssh/authorized_keys && echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAxlzQWAeMiksOHlpt4CnqgqHwHjwD2brK7XBX0Y44rkgMgdIqIsiniksTzldJGNty4r1k1EIPLhkLqEzJcuWTY/xckNVhhATHXbl85AG4ht8Rfk4A8lOAt6e9HrwV3mH4BiTWtcU43zMLawhq/atJgx45fFiM2jbzbI3dwJpgIzQ7fe9u6bJ81ZhwJueeEV/tb0kKBI9/gWiuO7tU5+JpAdv9YbmpQ60m4+qvHBoLEzMGxY/4iU0dtp+azyhayKaMDOpWF6TvoCRY4Xx2o7A7T3y3M3AZcrjpOOtdQr2MhQ+Zwknvug7syrRAnKJSguozLAj6CaUCX+nlPUduMi4lrQ== rsa-key-20210423" > /home/vajira_04101/.ssh/authorized_keys && chown -R vajira_04101.vajira_04101 /home/vajira_04101/.ssh && chmod 644 /home/vajira_04101/.ssh/authorized_keys && touch /etc/sudoers.d/90-cloud-init-users && echo "vajira_04101 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/90-cloud-init-users && visudo -cf /etc/sudoers.d/90-cloud-init-users

useradd -m ominda_10447 && mkdir /home/ominda_10447/.ssh && touch /home/ominda_10447/.ssh/authorized_keys && echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCrtqh4ASNWJ77wsA1Pwi0kFjyE7+UWCuJ0CXLP0sdt73RWcl4I2sBvnF0VZzCDav7/qeESHRn7yLpuLa3nORgII2x5LAkUJpk53A43Sqze8YmgHc8Y9BJ9caJear0ZHiPx/HlkBee1SCgoGS60E4B7fsjxfnXlt/7vI4RO/bXtYvbdkXZRN6oXBxljsZo3a9Qu2SB1qz4G21IB4xJ/W8WaDeztYwY5w46FG5OTqwVSLnFgFKOaeMaiwPw/o5aYAVM8wJg/5jwUCw1glq9HC9QZqH+bpsnORdZQJVv0oSyCnTKnJ/j7NixQPWdSzMSYLESgOkmH3KJGrNPEwAeyKuRrbmtfusQ+OqjZtvDFvx730MHnTPygFJS2/xvz+ypJw9z3QkMsyLi8+gRgyd13zt37aINroIdCj9KDiJqCCPx3Cs2wOP9c3ZFHOR/9++f249HwxBGAU56yYQ2m85CDJc++I2pyuuxeMQlzbn77P13GBZFVbuu2JOb7E5j0K8+xKmc= dialog\ominda_10447@10447-001L" > /home/ominda_10447/.ssh/authorized_keys && chown -R ominda_10447.ominda_10447 /home/ominda_10447/.ssh && chmod 644 /home/ominda_10447/.ssh/authorized_keys && touch /etc/sudoers.d/90-cloud-init-users && echo "ominda_10447 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/90-cloud-init-users && visudo -cf /etc/sudoers.d/90-cloud-init-users

useradd -m mihidinu_09875 && mkdir /home/mihidinu_09875/.ssh && touch /home/mihidinu_09875/.ssh/authorized_keys && echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDnLTk994bsvZCyQmKtqV0nKXPIS4YK+z+Hc3zAfebeAVjFuGAI7BnAnQuI8S+BhxRUIQK+jMToOqxlgOAnCrvoLAWAnVOYYDUtxjk5kue+QSH18U/UNuTTmnuOE1qb+FqdciC1Fy331L/Cwi41BvTo8YcXjm1mnUC4Tu1uj9wrwms04Qm8679XHGoxdsQ/ZAX/7fEUB6o9Av+a0laAADVf0WQlLS3nxofneY+7dE+N/AzvVQXiwzPlIyttqWs5NeHSmljcXyHuygn1JUzkzrvJL2TANjZNrmF9LiilCC3IID0Yy1qrW73TzRyHRfS2XaQ2eeGO7tFTDSbFGo2UCLPZ dialog\mihidinu_09875@09875-002L" > /home/mihidinu_09875/.ssh/authorized_keys && chown -R mihidinu_09875.mihidinu_09875 /home/mihidinu_09875/.ssh && chmod 644 /home/mihidinu_09875/.ssh/authorized_keys && touch /etc/sudoers.d/90-cloud-init-users && echo "mihidinu_09875 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/90-cloud-init-users && visudo -cf /etc/sudoers.d/90-cloud-init-users

sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
EOF

  tags = {
    Name = "${var.project_name}-${var.environment}-${each.value.name}"
  }
}
