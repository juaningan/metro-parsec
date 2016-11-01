template {
  source      = "/etc/consul-templates/merlin.conf.ctmpl"
  destination = "/usr/local/etc/merlin/merlin.conf"
  command     = "systemctl reload naemon"
  wait        = "5s:20s"
}
