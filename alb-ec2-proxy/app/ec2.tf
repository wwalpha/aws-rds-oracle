locals {
  user_data = <<EOT
#!/bin/bash
yum update -y
amazon-linux-extras install -y postgresql13

# download postgresql sample database
curl -O https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip
unzip dvdrental.zip

# create sample database
echo "export PGUSER=${var.database_username}" >> /root/.bash_profile
echo "export PGPASSWORD=${var.database_password}" >> /root/.bash_profile
echo "export PGHOST=${var.database_proxy_endpoint}" >> /root/.bash_profile
echo "export PGDATABASE=dvdrental" >> /root/.bash_profile
echo "export PGPORT=5432" >> /root/.bash_profile
source /root/.bash_profile

psql -d postgres -c "create database dvdrental;"
pg_restore -d dvdrental dvdrental.tar
psql -d dvdrental -c "\dt"

# install nodejs
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
yum install -y git nodejs yarn
npm install -g typescript ts-node

# install sample source
git clone https://github.com/wwalpha/nodejs-postgresql-samples.git
cd nodejs-postgresql-samples
yarn install
yarn start

# sudo tail /var/log/cloud-init-output.log -n 20
EOT
}

resource "time_sleep" "wait_120_seconds" {
  create_duration = "120s"
}

module "ec2_instance" {
  depends_on = [time_sleep.wait_120_seconds]
  source     = "terraform-aws-modules/ec2-instance/aws"
  version    = "~> 3.0"

  name                   = "${var.prefix}-instance"
  ami                    = "ami-0404778e217f54308"
  instance_type          = "t3a.medium"
  key_name               = "onecloud"
  monitoring             = false
  vpc_security_group_ids = [module.app_sg.security_group_id]
  subnet_id              = var.private_subnets[0]
  user_data_base64       = base64encode(local.user_data)
  iam_instance_profile   = var.iam_role_profile_ec2_ssm
}
