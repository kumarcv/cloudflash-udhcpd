validate = require('json-schema').validate
udhcpd = require './udhcpd'


module.exports.udhcpdSchema = validateDhcpSchema = ->
    console.log 'in validateDhcpSchema'
    console.log @body
    result = validate @body, udhcpd.udhcpdSchema
    console.log result
    return @next new Error "Invalid udhcpd configuration posting!: #{result.errors}" unless result.valid
    @next()


