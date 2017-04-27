package main

import (
  "fmt"
  "net"
  "encoding/hex"
  "net/http"
  "log"
  "text/template"
  "strings"
  "github.com/hashicorp/consul/api"
)

const ipxeBootScript = `#!ipxe
set channel {{.Channel}}
set base-url http://{{.BaseUrl}}/repo/pctce/${channel}
kernel ${base-url}/platform/i86pc/kernel/unix -B hostname='{{.Hostname}}',ipaddress='{{.IP}}',diskless='{{.Diskless}}',rebuild='{{.Rebuild}}'
module ${base-url}/platform/i86pc/boot_archive
boot
`

func main() {


  // Register the iPXE boot script server.
  http.HandleFunc("/", ipxeBootScriptServer)

  log.Fatal(http.ListenAndServe("0.0.0.0:4777", nil))

}

func consul(hostname, key, fallback string) string {
  // Query consul KV
  config := api.DefaultConfig()
  config.Address = "16.0.96.20:8500"
  client, err := api.NewClient(config)
  if err != nil {
    panic(err)
  }

  // Get a handle to the KV API
  kv := client.KV()
  
  // Lookup the pair
  host_path := fmt.Sprintf("pctce/%s/%s", hostname, key)
  log.Printf("Query consul for value of %s", host_path)
  pair, _, err := kv.Get(host_path, nil)
  if err != nil {
    panic(err)
  }
  if pair == nil {
    log.Printf("%s not found, fallback to %s", host_path, fallback)
    return fallback
  }
  log.Printf("%s is %s", host_path, pair.Value)
  return string(pair.Value)
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
    "Channel": "latest",
    "Hostname": hostname,
    "IP": remote_ip,
    "Diskless": consul(hostname, "diskless", "false"),
    "Rebuild": consul(hostname, "rebuild", "false"),
  }
  err = t.Execute(w, data)
  if err != nil {
    log.Print("Error generating iPXE boot script: " + err.Error())
    http.Error(w, "Error generating the iPXE boot script", 500)
    return
  }
  return
}
