package main

import (
	"bytes"
	"crypto/tls"
	"encoding/xml"
	"io/ioutil"
	"log"
	"net"
	"net/http"
	"time"
)

// against "unused imports"
var _ time.Time
var _ xml.Name

type Ipaddresslist struct {
  XMLName xml.Name `xml:"urn:IPM_SOAP ip_address_list"`

  Input []Ipaddresslistin
}

type Ipaddresslistin struct {
	XMLName xml.Name `xml:"input"`

	Authlogin    string `xml:"auth_login,omitempty"`
	Authpassword string `xml:"auth_password,omitempty"`
	OPTSELECT    string `xml:"OPT_SELECT,omitempty"`
	WHERE        string `xml:"WHERE,omitempty"`
	ORDERBY      string `xml:"ORDERBY,omitempty"`
	Offset       string `xml:"offset,omitempty"`
	Limit        string `xml:"limit,omitempty"`
}

type Ipaddresslistout struct {
	XMLName xml.Name `xml:"urn:IPM_SOAP ip_address_listResponse"`

	Ipfreeipid          string `xml:"ip_free_ip_id,omitempty"`
	Type_               string `xml:"type,omitempty"`
	Freestartipaddr     string `xml:"free_start_ip_addr,omitempty"`
	Freeendipaddr       string `xml:"free_end_ip_addr,omitempty"`
	Freescopesize       string `xml:"free_scope_size,omitempty"`
	Ipid                string `xml:"ip_id,omitempty"`
	Siteistemplate      string `xml:"site_is_template,omitempty"`
	Rootsiteid          string `xml:"root_site_id,omitempty"`
	Hiddensite          string `xml:"hidden_site,omitempty"`
	Realsitename        string `xml:"real_site_name,omitempty"`
	Realsiteid          string `xml:"real_site_id,omitempty"`
	Sitename            string `xml:"site_name,omitempty"`
	Treelevel           string `xml:"tree_level,omitempty"`
	Treepath            string `xml:"tree_path,omitempty"`
	Realtreepath        string `xml:"real_tree_path,omitempty"`
	Realtreeidpath      string `xml:"real_tree_id_path,omitempty"`
	Blockname           string `xml:"block_name,omitempty"`
	Ipaddr              string `xml:"ip_addr,omitempty"`
	Name                string `xml:"name,omitempty"`
	Macaddr             string `xml:"mac_addr,omitempty"`
	Ipclassname         string `xml:"ip_class_name,omitempty"`
	Subnetname          string `xml:"subnet_name,omitempty"`
	Poolname            string `xml:"pool_name,omitempty"`
	Siteid              string `xml:"site_id,omitempty"`
	Subnetid            string `xml:"subnet_id,omitempty"`
	Subnetstartipaddr   string `xml:"subnet_start_ip_addr,omitempty"`
	Subnetendipaddr     string `xml:"subnet_end_ip_addr,omitempty"`
	Subnetscopesize     string `xml:"subnet_scope_size,omitempty"`
	Blockscopesize      string `xml:"block_scope_size,omitempty"`
	Blockid             string `xml:"block_id,omitempty"`
	Vlsmsubnetid        string `xml:"vlsm_subnet_id,omitempty"`
	Ipclassparameters   string `xml:"ip_class_parameters,omitempty"`
	Poolclassname       string `xml:"pool_class_name,omitempty"`
	Poolid              string `xml:"pool_id,omitempty"`
	Poolreadonly        string `xml:"pool_read_only,omitempty"`
	Poolrowenabled      string `xml:"pool_row_enabled,omitempty"`
	Iplnetdevname       string `xml:"iplnetdev_name,omitempty"`
	Iplnetdevid         string `xml:"iplnetdev_id,omitempty"`
	Iplportname         string `xml:"iplport_name,omitempty"`
	Iplportslotnumber   string `xml:"iplport_slotnumber,omitempty"`
	Iplportportnumber   string `xml:"iplport_portnumber,omitempty"`
	Iplportifvlan       string `xml:"iplport_ifvlan,omitempty"`
	Hostifacename       string `xml:"hostiface_name,omitempty"`
	Hostifaceid         string `xml:"hostiface_id,omitempty"`
	Hostdevname         string `xml:"hostdev_name,omitempty"`
	Hostdevid           string `xml:"hostdev_id,omitempty"`
	Sitedescription     string `xml:"site_description,omitempty"`
	Siteclassname       string `xml:"site_class_name,omitempty"`
	Siteclassparameters string `xml:"site_class_parameters,omitempty"`
	Rowenabled          string `xml:"row_enabled,omitempty"`
	Parentsitename      string `xml:"parent_site_name,omitempty"`
	Blockclassname      string `xml:"block_class_name,omitempty"`
	Scopesize           string `xml:"scope_size,omitempty"`
	Blockstartipaddr    string `xml:"block_start_ip_addr,omitempty"`
	Blockendipaddr      string `xml:"block_end_ip_addr,omitempty"`
	Vlsmblockid         string `xml:"vlsm_block_id,omitempty"`
	Subnetclassname     string `xml:"subnet_class_name,omitempty"`
	Poolsize            string `xml:"pool_size,omitempty"`
	Poolstartipaddr     string `xml:"pool_start_ip_addr,omitempty"`
	Poolendipaddr       string `xml:"pool_end_ip_addr,omitempty"`
	Ipalias             string `xml:"ip_alias,omitempty"`
	Errmsg              string `xml:"errmsg,omitempty"`
	Errno               string `xml:"errno,omitempty"`
}

type Ipaddresslistoutarray struct {
	XMLName xml.Name `xml:"urn:IPM_SOAP ip_address_listResponse"`
}

type IPMPort struct {
	client *SOAPClient
}

func NewIPMPort(url string, tls bool) *IPMPort {
	if url == "" {
		url = "https://16.3.96.20/interfaces/ws.php?wsdl_custom=IPAM"
	}
	client := NewSOAPClient(url, tls)

	return &IPMPort{
		client: client,
	}
}

func (service *IPMPort) Ipaddresslist(request Ipaddresslist) (*Ipaddresslistoutarray, error) {
	response := new(Ipaddresslistoutarray)
	err := service.client.Call("urn:ip_address_list", request, response)
	if err != nil {
		return nil, err
	}

	return response, nil
}

var timeout = time.Duration(30 * time.Second)

func dialTimeout(network, addr string) (net.Conn, error) {
	return net.DialTimeout(network, addr, timeout)
}

type SOAPEnvelope struct {
	XMLName xml.Name `xml:"http://schemas.xmlsoap.org/soap/envelope/ Envelope"`

	Body SOAPBody
}

type SOAPHeader struct {
	XMLName xml.Name `xml:"http://schemas.xmlsoap.org/soap/envelope/ Header"`

	Header interface{}
}

type SOAPBody struct {
	XMLName xml.Name `xml:"Body"`

	Fault   *SOAPFault  `xml:",omitempty"`
	Content interface{} `xml:",omitempty"`
}

type SOAPFault struct {
	XMLName xml.Name `xml:"http://schemas.xmlsoap.org/soap/envelope/ Fault"`

	Code   string `xml:"faultcode,omitempty"`
	String string `xml:"faultstring,omitempty"`
	Actor  string `xml:"faultactor,omitempty"`
	Detail string `xml:"detail,omitempty"`
}


type SOAPClient struct {
	url  string
	tls  bool
}

func (b *SOAPBody) UnmarshalXML(d *xml.Decoder, start xml.StartElement) error {
	if b.Content == nil {
		return xml.UnmarshalError("Content must be a pointer to a struct")
	}

	var (
		token    xml.Token
		err      error
		consumed bool
	)

Loop:
	for {
		if token, err = d.Token(); err != nil {
			return err
		}

		if token == nil {
			break
		}

		switch se := token.(type) {
		case xml.StartElement:
			if consumed {
				return xml.UnmarshalError("Found multiple elements inside SOAP body; not wrapped-document/literal WS-I compliant")
			} else if se.Name.Space == "http://schemas.xmlsoap.org/soap/envelope/" && se.Name.Local == "Fault" {
				b.Fault = &SOAPFault{}
				b.Content = nil

				err = d.DecodeElement(b.Fault, &se)
				if err != nil {
					return err
				}

				consumed = true
			} else {
				if err = d.DecodeElement(b.Content, &se); err != nil {
					return err
				}

				consumed = true
			}
		case xml.EndElement:
			break Loop
		}
	}

	return nil
}

func (f *SOAPFault) Error() string {
	return f.String
}

func NewSOAPClient(url string, tls bool) *SOAPClient {
	return &SOAPClient{
		url:  url,
		tls:  tls,
	}
}

func (s *SOAPClient) Call(soapAction string, request, response interface{}) error {
	envelope := SOAPEnvelope{
	//Header:        SoapHeader{},
	}

	envelope.Body.Content = request
	buffer := new(bytes.Buffer)

	encoder := xml.NewEncoder(buffer)
	//encoder.Indent("  ", "    ")

	if err := encoder.Encode(envelope); err != nil {
		return err
	}

	if err := encoder.Flush(); err != nil {
		return err
	}

	log.Println(buffer.String())

	req, err := http.NewRequest("POST", s.url, buffer)
	if err != nil {
		return err
	}

	req.Header.Add("Content-Type", "text/xml; charset=\"utf-8\"")
	if soapAction != "" {
		req.Header.Add("SOAPAction", soapAction)
	}

	req.Header.Set("User-Agent", "gowsdl/0.1")
	req.Close = true

	tr := &http.Transport{
		TLSClientConfig: &tls.Config{
			InsecureSkipVerify: s.tls,
		},
		Dial: dialTimeout,
	}

	client := &http.Client{Transport: tr}
	res, err := client.Do(req)
	if err != nil {
		return err
	}
	defer res.Body.Close()

	rawbody, err := ioutil.ReadAll(res.Body)
	if err != nil {
		return err
	}
	if len(rawbody) == 0 {
		log.Println("empty response")
		return nil
	}

	log.Println(string(rawbody))
	respEnvelope := new(SOAPEnvelope)
	respEnvelope.Body = SOAPBody{Content: response}
	err = xml.Unmarshal(rawbody, respEnvelope)
	if err != nil {
		return err
	}

	fault := respEnvelope.Body.Fault
	if fault != nil {
		return fault
	}

	return nil
}
