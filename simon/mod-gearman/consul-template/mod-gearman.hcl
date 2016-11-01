template {
  source      = "/etc/consul-templates/module.conf.ctmpl"
  destination = "/etc/mod-gearman/module.conf"
  command     = "systemctl reload naemon"
  wait        = "5s:20s"
}
