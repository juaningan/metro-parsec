package main

import (
  "fmt"
  "os"
  "net"
  "encoding/hex"
)

func main() {

  var ip_addr = net.ParseIP(os.Args[1]).To4()
  ip_addr_hex := hex.EncodeToString(ip_addr)

  service := NewIPMPort("", true)
  ipaddr := fmt.Sprintf("ip_addr LIKE '%s'", ip_addr_hex)
  query := GetIpaddresslist{Input: []Ipaddresslistin{Ipaddresslistin{Authlogin: "apiparsec", Authpassword: "apiparsec", WHERE: ipaddr}}}
  result, err := service.GetIpaddresslist(&query)
  if err != nil {
    panic(err)
  }
  fmt.Println(result.GetIpaddresslistResult.IpaddresslistResponse[0].Name)
}
