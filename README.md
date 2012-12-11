cloudflash-network
==================


*List of interface APIs*
========================

<table>
  <tr>
    <th>Verb</th><th>URI</th><th>Description</th>
  </tr>
  <tr>     
    <td>POST</td><td>/network/udhcpd</td><td>Create DHCP server configuration</td>
  </tr>
  <tr>
      <td>GET</td><td>/network/udhcpd/:id</td><td>Describe DHCP server configuration for a given id</td>  
  </tr>
  <tr>
      <td>DELETE</td><td>/network/udhcpd/:id</td><td>Delete DHCP server configuration for a given id</td>  
  </tr>  
  <tr>
      <td>GET</td><td>/network/udhcpd</td><td>List all DHCP servers configuration</td>
  </tr>  
</table>



Configure DHCP server
----------------------------

    Verb    URI        		 Description
    POST    /network/udhcpd	Create DHCP server configuration



**Example Request and Response**

### Request JSON
   {
      "start": "192.168.0.20",
      "end": "192.168.0.254",
      "interface": "eth0",
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
      "option": {
        "subnet": [
          "1.1.1.1",
          "2.2.2.2"
        ],
        "mtu": "100"
      }
    }



### Response JSON
    {
      "id": "caa8dc3b-c178-47f4-b0b4-3f53ced8181d",
      "config": {
        "body": {
          "start": "192.168.0.20",
          "end": "192.168.0.254",
          "interface": "eth0",
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
          "option": {
            "subnet": [
              "1.1.1.1",
              "2.2.2.2"
            ],
            "mtu": "100"
          }
        }
      }
    }



Describe DHCP server details
---------------------------

    Verb    URI	                         Description
    GET     /network/udhcpd/:id       Describe DHCP server details for a given id.

On Success returns 200 with JSON data

**Example Request and Response**

### Request Headers

    GET  /network/udhcpd/caa8dc3b-c178-47f4-b0b4-3f53ced8181d
    
### Response JSON

    {
          "start": "192.168.0.20",
          "end": "192.168.0.254",
          "interface": "eth0",
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
          "option": {
            "subnet": [
              "1.1.1.1",
              "2.2.2.2"
            ],
            "mtu": "100"
          }
    }

Delete DHCP server details
-------------------------

    Verb    URI	                       Description
    DELETE  /network/udhcpd/:id     Delete DHCP server details by id.

On Success returns 204 

**Example Request and Response**

### Request Headers

    DELETE  /network/udhcpd/caa8dc3b-c178-47f4-b0b4-3f53ced8181d
    
### Response JSON
    Status code: 204


List DHCP servers configured
---------------------------
    Verb URI                        Description
    GET  /network/udhcpd	List all DHCP servers


On Success returns 200 with JSON data

**Example Request and Response**

### Request Headers

    GET  /network/udhcpd
    
### Response JSON
    {
	[
        	{
		"id": "caa8dc3b-c178-47f4-b0b4-3f53ced8181d",
			"config": {
				"start": "192.168.0.20",
				"end": "192.168.0.254",
				"interface": "eth0",
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
				"option": {
					"subnet": [
						"1.1.1.1",
					"2.2.2.2"
						],
					"mtu": "100"
				}
			}
        	}
	]
    }


