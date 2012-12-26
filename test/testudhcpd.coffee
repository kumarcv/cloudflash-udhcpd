chai = require 'chai'
expect = chai.expect
should = chai.should()
udhcp = require '../lib/udhcpd.coffee'
check = require '../lib/checkschema.coffee'

validate = require('json-schema').validate


#chai.Assertion.includeStack = true 


# sample date to test mocha test framework
http = require('http')


udhcpdconfig = { "start": "192.168.0.20", "end": "192.168.0.254", "interface": "eth0", "max_leases": 254, "remaining": "yes", "auto_time": 7200, "decline_time": 3600, "conflict_time": 3600, "offer_time": 60, "min_lease": 60, "lease_file": "/var/lib/misc/udhcpd.leases", "pidfile": "/var/run/udhcpd.pid", "notify_file": "dumpleases", "siaddr": "192.168.0.22", "sname": "zorak", "boot_file": "/var/lib/misc/udhcpd.leases", "option":  { "subnet":["192.168.0.25"], "router":["192.10.0.40", "192.10.0.41"], "dns":["192.10.0.40", "192.10.0.41"], "wins":["192.10.0.40", "192.10.0.41"], "domain":["192.10.0.40", "192.10.0.41"], "lease":60, "timezone":"IST", "timesvr":["192.10.0.40", "192.10.0.41"], "logsvr" :["192.10.0.40", "192.10.0.41"], "cookiesvr" :["192.10.0.40", "192.10.0.41"], "lprsrv" :["192.10.0.40", "192.10.0.41"], "hostname":"kvm570" } }


udhcpdconfig_err = { "end": "192.168.0.254", "interface": "eth0", "max_leases": 254, "remaining": "yes", "auto_time": 7200, "decline_time": 3600, "conflict_time": 3600, "offer_time": 60, "min_lease": 60, "lease_file": "/var/lib/misc/udhcpd.leases", "pidfile": "/var/run/udhcpd.pid", "notify_file": "dumpleases", "siaddr": "192.168.0.22", "sname": "zorak", "boot_file": "/var/lib/misc/udhcpd.leases", "option":  { "subnet":["192.168.0.25"], "router":["192.10.0.40", "192.10.0.41"], "dns":["192.10.0.40", "192.10.0.41"], "wins":["192.10.0.40", "192.10.0.41"], "domain":["192.10.0.40", "192.10.0.41"], "lease":60, "timezone":"IST", "timesvr":["192.10.0.40", "192.10.0.41"], "logsvr" :["192.10.0.40", "192.10.0.41"], "cookiesvr" :["192.10.0.40", "192.10.0.41"], "lprsrv" :["192.10.0.40", "192.10.0.41"], "hostname":"kvm570" } }


describe 'Testing uDHCPd endpoints functions: ', ->
  it 'validate uDHCPd validateuDHCPdSchema', ->
    result = null
    body = udhcpdconfig        
    result = validate body, udhcp.udhcpdSchema
    expect(result).to.eql({ valid: true, errors: [] }) 

  it 'invalid uDHCPd validateuDHCPdSchema', ->
    result = null
    body = udhcpdconfig_err
    result = validate body, udhcp.udhcpdSchema
    expect(result).to.not.eql({ valid: true, errors: [] })

  it 'Test function dhcp list function ', (done) ->
    result = null
    dhcp1 = new udhcp

    dhcp1.list (res) =>
      setTimeout (->
         result = res
         console.log "result: " + result
         expect(result).to.be.a('array')
         done()
       ), 50

  it 'Test function dhcp listById function ', (done) ->
    result = null
    params = {}
    params.id = '7e011e20-3eaa-42ac-a0ef-cea648f43e01'
    dhcp2 = new udhcp
    dhcp2.listById params.id, (res) =>
      setTimeout (->
         result = res
         console.log "result: " + result
         expect(result).to.have.property('id')
         expect(result).to.have.property('config')
         done()
       ), 50

  it 'listById invalid id test', (done) ->
    result = null
    params = {}
    params.id = '1234567'
    dhcp3 = new udhcp
    dhcp3.listById params.id, (res) =>
      setTimeout (->
         result = res
         console.log "result: " + result
         expect(result).to.not.eql({ valid: true, errors: [] })
         done()
      ), 50

  it 'Test function dhcp remove function ', (done) ->
    result = null
    params = {}
    params.id = '7e011e20-3eaa-42ac-a0ef-cea648f43e01'
    dhcp4 = new udhcp
    dhcp4.remove params.id, (res) =>
      setTimeout (->
       result = res
       expect(result).to.eql({result:true})
       done()
      ), 50
  
  it 'dhcp remove invalid test', (done) ->
    result = null
    params = {}
    params.id = '1234567'
    dhcp5 = new udhcp
    dhcp5.remove params.id, (res) =>
      setTimeout (->
       result = res
       expect(result).to.not.eql({result:true})
       done()
      ), 50

  it 'Test function dhcp new function ', (done) ->
    result = null
    dhcp6 = new udhcp
    body = udhcpdconfig
    setTimeout (->
       result = dhcp6.new body
       console.log "result: " + result
       expect(result).to.be.a('string')
       done()
    ), 50

  it 'invalid new test', (done) ->
    result = null
    body = {}
    dhcp7 = new udhcp
    setTimeout (->
       result = dhcp7.new body
       console.log "result: " + result
       expect(result).to.be.a('string')
       done()
      ), 50

  it 'Test function dhcp createConfig', (done) ->
    result = null
    dhcp8 = new udhcp
    body = udhcpdconfig
    id = dhcp8.new()
    dhcp8.createConfig body, id, (res) =>
    setTimeout (->
       result = res
       expect(result).to.be.a('object')
       expect(result).to.have.property('id')
       expect(result).to.have.property('config')
       done()
       ), 50

  it 'Test invalid function dhcp createConfig', (done) ->
    result = null
    dhcp9 = new udhcp
    body = {}
    id = dhcp9.new()
    dhcp9.createConfig body, id, (res) =>
    setTimeout (->
       result = res
       expect(result).to.be.a('object')
       expect(result).to.have.property('id')
       expect(result).to.have.property('config')
       done()
       ), 50

