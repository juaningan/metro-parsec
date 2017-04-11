package main

import (
  "fmt"
  "net"
  "encoding/hex"
  "net/http"
  "log"
  "text/template"
  "strings"
)

const ipxeBootScript = `#!ipxe
set coreos-version {{.Version}}
set base-url http://{{.BaseUrl}}/images/amd64-usr/${coreos-version}
kernel ${base-url}/coreos_production_pxe.vmlinuz -B hostname={{.Hostname}},ipaddress={{.IP}},diskless={{.Diskless}},rebuild={{.Rebuild}}
initrd ${base-url}/coreos_production_pxe_image.cpio.gz
boot
`

func main() {


  // Register the iPXE boot script server.
  http.HandleFunc("/", ipxeBootScriptServer)

  log.Fatal(http.ListenAndServe("0.0.0.0:4777", nil))

}

func ipxeBootScriptServer(w http.ResponseWriter, r *http.Request) {

  // Remove port from http.Request.RemoteAddr
  remote_ip := strings.Split(r.RemoteAddr, ":")[0]
  log.Printf("creating boot script for %s", remote_ip)

  // Parse IP string in 4 bytes and get hex format
  ip_addr := net.ParseIP(remote_ip).To4()
  ip_addr_hex := hex.EncodeToString(ip_addr)

  // Call the service
  service := NewIPMPort("", true)
  ipaddr := fmt.Sprintf("ip_addr LIKE '%s'", ip_addr_hex)
  query := GetIpaddresslist{Input: []Ipaddresslistin{Ipaddresslistin{Authlogin: "apiparsec", Authpassword: "apiparsec", WHERE: ipaddr}}}
  result, err := service.GetIpaddresslist(&query)
  if err != nil {
    panic(err)
  }
  hostname := result.GetIpaddresslistResult.IpaddresslistResponse[0].Name
  log.Printf("resolved hostname as %s", hostname)

  // Process the iPXE boot script template.
  t, err := template.New("ipxebootscript").Parse(ipxeBootScript)
  if err != nil {
    log.Print("Error generating iPXE boot script: " + err.Error())
    http.Error(w, "Error generating the iPXE boot script", 500)
    return
  }
  data := map[string]string{
    "BaseUrl": "16.0.96.20",
    "Version": "stable",
    "Hostname": hostname,
    "IP": remote_ip,
    "Diskless": "false",
    "Rebuild": "false",
  }
  err = t.Execute(w, data)
  if err != nil {
    log.Print("Error generating iPXE boot script: " + err.Error())
    http.Error(w, "Error generating the iPXE boot script", 500)
    return
  }
  return
}
