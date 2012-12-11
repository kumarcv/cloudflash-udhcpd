*List of uDHCPd APIs*
======================

<table>
  <tr>
    <th>Verb</th><th>URI</th><th>Description</th>
  </tr>
  <tr>     
    <td>POST</td><td>/network/udhcpd</td><td>Create DHCP server configuration</td>
  </tr>
  <tr>
      <td>GET</td><td>/network/udhcpd</td><td>List DHCP servers configuration</td>  
  </tr>
  <tr>
      <td>GET</td><td>/network/udhcpd/:id</td><td>List DHCP server configuration by ID</td>
  </tr>
  <tr>
      <td>DELETE</td><td>/network/udhcpd/:id</td><td>Delete DHCP server configuration</td>  
  </tr>  
    
</table>


Create DHCP server configuration
--------------------------------

    Verb    URI        		    Description
    POST	/network/udhcpd 	Creating a DHCP server configuraion in VCG.

On success it returns JSON data with the service-id, config success.

*TODO: Define JSON format for error codes and description.*

**Example Request and Response**

### Request Headers


### Request JSON

    {
           "start": "192.168.0.20",
           "end": "192.168.0.100",
           "interface": "wan0",
           "max_leases": 254,
           "remaining": "yes",
           "auto_time": 7200,
           "decline_time": 3600,
           "conflict_time": 3600,
           "offer_time": 60,
           "min_lease": 60,
           "lease_file": "/var/lib/misc/udhcpd.leases",
           "pidfile": "/var/run/udhcpd.pid",
           "notify_file": "dumpleases",
           "siaddr": "192.168.0.22",
           "sname": "zorak",
           "boot_file": "/var/lib/misc/udhcpd.leases",
           "option": 
           {
            "subnet":["192.168.0.25"],
            "router":["192.10.0.40", "192.10.0.41"],
            "dns":["192.10.0.40", "192.10.0.41"],
            "wins":["192.10.0.40", "192.10.0.41"],
            "domain":["192.10.0.40", "192.10.0.41"],
            "lease":60,
            "timezone":"IST",
            "timesvr":["192.10.0.40", "192.10.0.41"],
            "logsvr" :["192.10.0.40", "192.10.0.41"],
            "cookiesvr" :["192.10.0.40", "192.10.0.41"],
            "lprsrv" :["192.10.0.40", "192.10.0.41"],
            "hostname":"kvm570"
          }
           
    }

### Response JSON


    {
      "id": "cc6279dd-7409-4cd2-b4ad-086dbd1b59a5",
      "config":
      {
       "start": "192.168.0.20",
       "end": "192.168.0.100",
       "interface": "wan0",
       "max_leases": 254,
       "remaining": "yes",
       "auto_time": 7200,
       "decline_time": 3600,
       "conflict_time": 3600,
       "offer_time": 60,
       "min_lease": 60,
       "lease_file": "/var/lib/misc/udhcpd.leases",
       "pidfile": "/var/run/udhcpd.pid",
       "notify_file": "dumpleases",
       "siaddr": "192.168.0.22",
       "sname": "zorak",
       "boot_file": "/var/lib/misc/udhcpd.leases",
       "option":
       {
           "subnet":
           [
               "192.168.0.25"
           ],
           "router":
           [
               "192.10.0.40",
               "192.10.0.41"
           ],
           "dns":
           [
               "192.10.0.40",
               "192.10.0.41"
           ],
           "wins":
           [
               "192.10.0.40",
               "192.10.0.41"
           ],
           "domain":
           [
               "192.10.0.40",
               "192.10.0.41"
           ],
           "lease": 60,
           "timezone": "IST",
           "timesvr":
           [
               "192.10.0.40",
               "192.10.0.41"
           ],
           "logsvr":
           [
               "192.10.0.40",
               "192.10.0.41"
           ],
           "cookiesvr":
           [
               "192.10.0.40",
               "192.10.0.41"
           ],
           "lprsrv":
           [
               "192.10.0.40",
               "192.10.0.41"
           ],
           "hostname": "kvm570"
       }     
      }      
    }

Upon error, error code 500 will be returned


List DHCP servers configuration
--------------------------------

    Verb	URI	             Description
    GET	/network/udhcpd	 List the DHCP servers configuration.

**Example Request and Response**

### Request Headers

    GET  /network/udhcpd

### Response JSON


    {
      "config":
      [
       {
           "id": "cc6279dd-7409-4cd2-b4ad-086dbd1b59a5",
           "config":
           {
               "start": "192.168.0.20",
               "end": "192.168.0.100",
               "interface": "wan0",
               "max_leases": 254,
               "remaining": "yes",
               "auto_time": 7200,
               "decline_time": 3600,
               "conflict_time": 3600,
               "offer_time": 60,
               "min_lease": 60,
               "lease_file": "/var/lib/misc/udhcpd.leases",
               "pidfile": "/var/run/udhcpd.pid",
               "notify_file": "dumpleases",
               "siaddr": "192.168.0.22",
               "sname": "zorak",
               "boot_file": "/var/lib/misc/udhcpd.leases",
               "option":
               {
                   "subnet":
                   [
                       "192.168.0.25"
                   ],
                   "router":
                   [
                       "192.10.0.40",
                       "192.10.0.41"
                   ],
                   "dns":
                   [
                       "192.10.0.40",
                       "192.10.0.41"
                   ],
                   "wins":
                   [
                       "192.10.0.40",
                       "192.10.0.41"
                   ],
                   "domain":
                   [
                       "192.10.0.40",
                       "192.10.0.41"
                   ],
                   "lease": 60,
                   "timezone": "IST",
                   "timesvr":
                   [
                       "192.10.0.40",
                       "192.10.0.41"
                   ],
                   "logsvr":
                   [
                       "192.10.0.40",
                       "192.10.0.41"
                   ],
                   "cookiesvr":
                   [
                       "192.10.0.40",
                       "192.10.0.41"
                   ],
                   "lprsrv":
                   [
                       "192.10.0.40",
                       "192.10.0.41"
                   ],
                   "hostname": "kvm570"
               }
           }
       }
      ]      
    }



    
    
List DHCP server configuration by ID
-------------------------------------
    Verb URI                    Description
    GET  /network/udhcpd/:id    List DHCP server configuration.


On Success returns 200 with JSON data

**Example Request and Response**

### Request Headers

    GET  /network/udhcpd/cc6279dd-7409-4cd2-b4ad-086dbd1b59a5
    
### Response JSON

    {
      {
        "id": "cc6279dd-7409-4cd2-b4ad-086dbd1b59a5",
        "config":
        {
           "start": "192.168.0.20",
           "end": "192.168.0.100",
           "interface": "wan0",
           "max_leases": 254,
           "remaining": "yes",
           "auto_time": 7200,
           "decline_time": 3600,
           "conflict_time": 3600,
           "offer_time": 60,
           "min_lease": 60,
           "lease_file": "/var/lib/misc/udhcpd.leases",
           "pidfile": "/var/run/udhcpd.pid",
           "notify_file": "dumpleases",
           "siaddr": "192.168.0.22",
           "sname": "zorak",
           "boot_file": "/var/lib/misc/udhcpd.leases",
           "option":
           {
               "subnet":
               [
                   "192.168.0.25"
               ],
               "router":
               [
                   "192.10.0.40",
                   "192.10.0.41"
               ],
               "dns":
               [
                   "192.10.0.40",
                   "192.10.0.41"
               ],
               "wins":
               [
                   "192.10.0.40",
                   "192.10.0.41"
               ],
               "domain":
               [
                   "192.10.0.40",
                   "192.10.0.41"
               ],
               "lease": 60,
               "timezone": "IST",
               "timesvr":
               [
                   "192.10.0.40",
                   "192.10.0.41"
               ],
               "logsvr":
               [
                   "192.10.0.40",
                   "192.10.0.41"
               ],
               "cookiesvr":
               [
                   "192.10.0.40",
                   "192.10.0.41"
               ],
               "lprsrv":
               [
                   "192.10.0.40",
                   "192.10.0.41"
               ],
               "hostname": "kvm570"
           }
        }
     }
    }    


Delete DHCP server configuration
---------------------------------

    Verb        URI	                    Description
    DELETE      /network/udhcpd/:id     Delete DHCP server configuration 

On Success returns status code 204

**Example Request and Response**

### Request Headers

    DELETE  /network/udhcpd/cc6279dd-7409-4cd2-b4ad-086dbd1b59a5
    
### Response JSON

    Status Code: 204
