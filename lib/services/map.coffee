fuzzymap = require 'fuzzymap'

module.exports = (name) ->

    map =
        emailAddress: ['EmailAddress', 'emailAddress', 'email']
        city: ['City']
        companyName: ['Company']
        personName: ['Person']

    mapper = fuzzymap.defineMap map
    mapper.map name
