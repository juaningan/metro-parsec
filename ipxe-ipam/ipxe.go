package main

import (
  "fmt"
)

func main() {
  service := NewIPMPort("", true)
  ipaddr := "ip_addr LIKE '12493A29'"
  input := Ipaddresslistin{Authlogin: "apiparsec", Authpassword: "apiparsec", WHERE: ipaddr}
  get_ip := Ipaddresslist{Input: []Ipaddresslistin{input}}
  ipaddress, err := service.Ipaddresslist(get_ip)
  if err != nil {
    panic(err)
  }
  fmt.Println(ipaddress)

}
