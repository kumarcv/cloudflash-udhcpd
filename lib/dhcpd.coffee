check = require './checkschema'
udhcpd = require './udhcpd'

@include = ->
    dhcpd = new udhcpd

    @post '/network/udhcpd', check.udhcpdSchema, ->
        id = dhcpd.new()
        dhcpd.createConfig @body, id, (result)  =>
            unless result instanceof Error
                @send result
            else
                @next new Error "Unable to create udhcpd config!. #{result}"

    @get '/network/udhcpd': ->
        dhcpd.list (result) =>
            unless result instanceof Error
                @send result
            else
                @next new Error "Unable to fetch udhcpd configuration! #{result}"

    @get '/network/udhcpd/:id': ->
        dhcpd.listById @params.id, (result) =>
            unless result instanceof Error
                @send result
            else
                @next new Error "Unable to fetch udhcpd configuration! #{result}"

    @del '/network/udhcpd/:id': ->
        dhcpd.remove @params.id, (result) =>
            unless result instanceof Error
                @send 204
            else
                @next new Error "Unable to delete udhcpd configuration! #{result}"

            

