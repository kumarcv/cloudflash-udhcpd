# validation is used by other modules
fileops = require 'fileops'
validate = require('json-schema').validate
exec = require('child_process').exec
fs = require 'fs'
uuid = require 'node-uuid'


@db = db =
    udhcpd:  require('dirty') '/tmp/udhcpd.db'


#schema to validate incoming JSON udhcpd configuration
udhcpdSchema =
    name: "udhcpd"
    type: "object"
    additionalProperties: false
    properties:
        start:              {"type":"string", "required":true}
        end:                {"type":"string", "required":true}
        interface:          {"type":"string", "required":false}
        max_leases:         {"type":"number", "required":false}
        remaining:          {"type":"string", "required":false}
        auto_time:          {"type":"number", "required":false}
        decline_time:       {"type":"number", "required":false}
        conflict_time:      {"type":"number", "required":false}
        offer_time:         {"type":"number", "required":false}
        min_lease:          {"type":"number", "required":false}
        lease_file:         {"type":"string", "required":false}
        pidfile:            {"type":"string", "required":false}
        notify_file:        {"type":"string", "required":false}
        siaddr:             {"type":"string", "required":false}
        sname:              {"type":"string", "required":false}
        boot_file:          {"type":"string", "required":false}
        option:
            items:
                type: "object"
                additionalProperties: false
                properties:
                    subnet:
                        items: {"type":"string"}
                    timezone: {"type":"string"}
                    router:
                        items: {"type":"string"}
                    timesvr:
                        items: {"type":"string"}
                    namesvr:
                        items: {"type":"string"}
                    dns:
                        items: {"type":"string"}
                    logsvr:
                        items: {"type":"string"}
                    cookiesvr:
                        items: {"type":"string"}
                    lpsrvr:
                        items: {"type":"string"}
                    hostname: {"type":"string"}
                    bootsize: {"type":"number"}
                    domain: {"type":"string"}
                    swapsvr:
                        items: {"type":"string"}
                    ipttl: {"type":"number"}
                    mtu: {"type":"number"}
                    broadcast:
                        items: {"type":"string"}
                    ntpsrv:
                        items: {"type":"string"}
                    wins:
                        items: {"type":"string"}
                    requestip:
                        items: {"type":"string"}
                    lease: {"type":"number"}
                    dhcptype: {"type":"string"}
                    serverid:
                        items: {"type":"string"}
                    tftp:{"type":"string"}


                 

class udhcpd
    constructor:  ->
        console.log 'udhcpd initialized'
        @udhcpddb = db.udhcpd
        @udhcpddb.on 'load', ->
            console.log 'loaded udhcpd.db'
            @forEach (key,val) ->
                console.log 'found ' + key

    new: ->
        id = uuid.v4()
        return id

    # createConfig: Function to create the config from the input JSON
    createConfig: (body, id, callback) ->
       config = ''
       for key, val of body
           switch (typeof val)
               
               when "number", "string"
                   config += key + '\t' + val + "\n"
               when "boolean"
                   config += key + "\n"
               when "object"
                   for i, j of body.option
                       switch (typeof j)
                           when "object"
                                if j instanceof Array
                                    console.log j
                                    data = "option\t #{i}\t"
                                    for t in j
                                        data += "#{t} "
                                    config+= data + "\n"
                           when "number", "string"
                               config += "option\t #{i} \t #{j}\n"

        filename = "/config/network/udhcpd/#{id}.conf"
        fileops.createFile filename, (result) ->
            return new Error "Unable to create configuration file #{filename}!" if result instanceof Error
            fileops.updateFile filename, config
            try
                #exec "ln -s /config/network/udhcpd/udhcpd.conf /etc/udhcpd.conf"
                exec "udhcpd -S #{filename} ", (error, stdout, stderr) =>
                    unless error instanceof Error
                        res = {}
                        res.id = id
                        res.config = body
                        db.udhcpd.set id, res, =>
                            console.log "created udhcpd service configuration"
                            callback res
                    else
                        fileops.removeFileSync filename
                        callback error
            catch err
                console.log err
                return err


    list: (callback) ->
        res = []
        @udhcpddb.forEach (key, val) ->
            res.config.push val
        callback(res)

    listById: (id, callback)->
        res = {}
        entry = @udhcpddb.get id
        res.config =  entry
        callback(res)

    remove: (id, callback) ->
        entry = @udhcpddb.get id
        unless entry
            err = new Error "No such udhcpd configuration!" 
            callback err
        else
            @udhcpddb.rm id
            result = fileops.removeFileSync "/config/network/udhcpd/#{id}.conf"
            unless result instanceof Error
                res = fileops.fileExistsSync "/usr/sbin/svcs"
                unless res
                    exec "pkill udhcpd; service udhcpd restart"
                else
                    exec "svcs dhcp restart"
                callback true
            else
                callback result

 

module.exports = udhcpd
module.exports.udhcpdSchema = udhcpdSchema
