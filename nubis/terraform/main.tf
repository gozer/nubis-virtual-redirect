module "worker" {
  source       = "github.com/nubisproject/nubis-terraform//worker?ref=v1.3.0"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}"
  purpose      = "webserver"
  ami          = "${var.ami}"
  elb          = "${module.load_balancer.name}"
  ssh_key_file = "${var.ssh_key_file}"
  ssh_key_name = "${var.ssh_key_name}"
}

module "load_balancer" {
  source               = "github.com/nubisproject/nubis-terraform//load_balancer?ref=v1.3.0"
  region               = "${var.region}"
  environment          = "${var.environment}"
  account              = "${var.account}"
  service_name         = "${var.service_name}"
  ssl_cert_name_prefix = "redirects-star-allizom"
}

module "dns" {
  source       = "github.com/nubisproject/nubis-terraform//dns?ref=v1.3.0"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "${var.service_name}"
  target       = "${module.load_balancer.address}"
}
